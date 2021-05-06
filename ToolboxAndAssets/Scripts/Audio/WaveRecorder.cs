using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;

// Ajouté par Loup
// Provient du projet Articulations
// SoundHandler gère l'enregistrement du son d'un micro vers un audiosource
// SavWave permet d'enregistrer un audio clip en fichier wave


public class SoundHandler : MonoBehaviour
{

    public AudioSource[] instructions;
    public AudioSource recordAudioSource;
    
    public bool isRecording, recordPostScenarioAudio;
    public bool micConnected = false;  
    private string[] microphoneName;
    private int frequencyRate = 44100;
    int sessionID;
    private int sampleRate = 0;
    public string audioDirPath;
    public int postScenarioRecordingLenght, recordingTimeLeft;


    public void Init(bool recordAudioAfterScenario, int audioRecordLength){
        recordPostScenarioAudio = recordAudioAfterScenario;
        postScenarioRecordingLenght = audioRecordLength;
    
    }

    /* RECORDING */

    public void InitAudioRecorder(int id, int audioRecordTime)
    {
        sessionID = id;

        audioDirPath = Application.dataPath + "/StreamingAssets/SoundRecords/"+System.DateTime.Now.ToString("dd-MM-yyyy_hh-mm-ss")+"_S"+sessionID+"_P" + (gameEngine.userManager.me._registeredRank+1) ;

        microphoneName = new string[Microphone.devices.Length];
        
        postScenarioRecordingLenght = audioRecordTime;
        
        sampleRate = AudioSettings.outputSampleRate;

        //Check if there is at least one microphone connected  
        if (Microphone.devices.Length <= 0) {  
                //Throw a warning message at the console if there isn't  
                Debug.LogWarning ("Microphone not connected!");  
        } else { 
                micConnected = true; 
                Debug.Log("Microphone ready"); 
        }
    }
 
    public void Launch (int recordLength)
    {
        postScenarioRecordingLenght = recordLength;
        recordingTimeLeft = postScenarioRecordingLenght;

        if (!Directory.Exists (audioDirPath)) {   
                //if it doesn't, create it
                Directory.CreateDirectory (audioDirPath);
        }

        if (micConnected) {  
            //If the audio from any microphone isn't being captured  
            if (!Microphone.IsRecording (null)) {   
                //Start recording and store the audio captured from the microphone at the AudioClip in the AudioSource  
                recordAudioSource.clip = Microphone.Start (null, true, postScenarioRecordingLenght, frequencyRate); 
                isRecording = true; 
                
                PlayInstructions(0);
                Debug.Log("Audio Recording Started!");
            }  
        } 
        else {  
            Debug.Log("Microphone not connected!");  
        }  

        //if(postScenarioRecordingLenght > 0) Invoke("Stop", postScenarioRecordingLenght); // invoke stop when time is passed
    }


    // client - triggered by order from server
    public void Stop ()
    {
        recordAudioSource.clip = SavWav.TrimSilence (recordAudioSource.clip, 0);
        string fileName = "S"+sessionID+"_"+System.DateTime.Now.ToString("MM-dd-yyyy_hh-mm");
        isRecording = false; 
        SavWav.Save (audioDirPath, fileName, recordAudioSource.clip);
        Microphone.End (null);
        Debug.Log("Audio Recording Stopped !");  
	}

}


public static class SavWav
{
    
        const int HEADER_SIZE = 44;
    
        public static bool Save (string audioDirPath, string filename, AudioClip clip)
        {

                bool fileExists = false;
                string[] content;
                int n = 0;

                content = readFolder (audioDirPath);


                for (int i=0; i<content.Length; i++) {

                        //Debug.Log (content [i]);
                        if (File.Exists (filename + ".wav") && n == 0) {
                                
                                fileExists = true;
                                i = -1;
                                n++;
                        } else if (File.Exists (filename + ".wav") && n != 0) {
                
                                fileExists = true;
                                i = -1;
                                n++;
                        }
                }
                if (fileExists) {
                        filename = string.Concat (filename, "_", n);
                }
        
        
        
                if (!filename.ToLower ().EndsWith (".wav")) {
                        filename += ".wav";
                }
        
                var filepath = audioDirPath+"/"+filename;
        
        
                // Make sure directory exists if user is saving to sub dir.
                //Directory.CreateDirectory (Path.GetDirectoryName (filepath));
        
                using (var fileStream = CreateEmpty(filepath)) {
                        ConvertAndWrite (fileStream, clip);
                        WriteHeader (fileStream, clip);
                }
        
                Debug.Log ("Saving audio at : "+filepath);
                return true; // TODO: return false if there's a failure saving the file
        }



        public static AudioClip TrimSilence (AudioClip clip, float min)
        {
                var samples = new float[clip.samples];
                clip.GetData (samples, 0);
                return TrimSilence (new List<float> (samples), min, clip.channels, clip.frequency);
        }


        public static AudioClip TrimSilence (List<float> samples, float min, int channels, int hz)
        {
                return TrimSilence (samples, min, channels, hz, false, false);
        }

        public static AudioClip TrimSilence (List<float> samples, float min, int channels, int hz, bool _3D, bool stream)
        {
                int i;
        
                for (i=0; i<samples.Count; i++) {
                        if (Mathf.Abs (samples [i]) > min) {
                                break;
                        }
                }
        
                samples.RemoveRange (0, i);
        
                for (i=samples.Count - 1; i>0; i--) {
                        if (Mathf.Abs (samples [i]) > min) {
                                break;
                        }
                }
        
                samples.RemoveRange (i, samples.Count - i);
        
                var clip = AudioClip.Create ("TempClip", samples.Count, channels, hz, _3D, stream);
        
                clip.SetData (samples.ToArray (), 0);
        
                return clip;
        }


        static FileStream CreateEmpty (string filepath)
        {
                var fileStream = new FileStream (filepath, FileMode.Create);
                byte emptyByte = new byte ();
        
                for (int i = 0; i < HEADER_SIZE; i++) { //preparing the header
                        fileStream.WriteByte (emptyByte);
                }
        
                return fileStream;
        }



        static void ConvertAndWrite (FileStream fileStream, AudioClip clip)
        {
        
                var samples = new float[clip.samples];
        
                clip.GetData (samples, 0);
        
                Int16[] intData = new Int16[samples.Length];
                //converting in 2 float[] steps to Int16[], //then Int16[] to Byte[]
        
                Byte[] bytesData = new Byte[samples.Length * 2];
                //bytesData array is twice the size of
                //dataSource array because a float converted in Int16 is 2 bytes.
        
                int rescaleFactor = 32767; //to convert float to Int16
        
                for (int i = 0; i<samples.Length; i++) {
                        intData [i] = (short)(samples [i] * rescaleFactor);
                        Byte[] byteArr = new Byte[2];
                        byteArr = BitConverter.GetBytes (intData [i]);
                        byteArr.CopyTo (bytesData, i * 2);
                }
        
                fileStream.Write (bytesData, 0, bytesData.Length);
        }



        static void WriteHeader (FileStream fileStream, AudioClip clip)
        {
        
                var hz = clip.frequency;
                var channels = clip.channels;
                var samples = clip.samples;
        
                fileStream.Seek (0, SeekOrigin.Begin);
        
                Byte[] riff = System.Text.Encoding.UTF8.GetBytes ("RIFF");
                fileStream.Write (riff, 0, 4);
        
                Byte[] chunkSize = BitConverter.GetBytes (fileStream.Length - 8);
                fileStream.Write (chunkSize, 0, 4);
        
                Byte[] wave = System.Text.Encoding.UTF8.GetBytes ("WAVE");
                fileStream.Write (wave, 0, 4);
        
                Byte[] fmt = System.Text.Encoding.UTF8.GetBytes ("fmt ");
                fileStream.Write (fmt, 0, 4);
        
                Byte[] subChunk1 = BitConverter.GetBytes (16);
                fileStream.Write (subChunk1, 0, 4);
        
                UInt16 two = 2;
                UInt16 one = 1;
        
                Byte[] audioFormat = BitConverter.GetBytes (one);
                fileStream.Write (audioFormat, 0, 2);
        
                Byte[] numChannels = BitConverter.GetBytes (channels);
                fileStream.Write (numChannels, 0, 2);
        
                Byte[] sampleRate = BitConverter.GetBytes (hz);
                fileStream.Write (sampleRate, 0, 4);
        
                Byte[] byteRate = BitConverter.GetBytes (hz * channels * 2); // sampleRate * bytesPerSample*number of channels, here 44100*2*2
                fileStream.Write (byteRate, 0, 4);
        
                UInt16 blockAlign = (ushort)(channels * 2);
                fileStream.Write (BitConverter.GetBytes (blockAlign), 0, 2);
        
                UInt16 bps = 16;
                Byte[] bitsPerSample = BitConverter.GetBytes (bps);
                fileStream.Write (bitsPerSample, 0, 2);
        
                Byte[] datastring = System.Text.Encoding.UTF8.GetBytes ("data");
                fileStream.Write (datastring, 0, 4);
        
                Byte[] subChunk2 = BitConverter.GetBytes (samples * channels * 2);
                fileStream.Write (subChunk2, 0, 4);
        
                //      fileStream.Close();
        }

        public static string[] readFolder (string path)
        {
                DirectoryInfo dir = new DirectoryInfo (path);
                FileInfo[] info = dir.GetFiles ("*.*");

                string[] content = new string[info.Length];

                int i = 0;
                foreach (FileInfo f in info) {
                        content [i] = f.Name;
                        //Debug.Log (f.Name);
                        i++;
                }
                return content;
        }

}

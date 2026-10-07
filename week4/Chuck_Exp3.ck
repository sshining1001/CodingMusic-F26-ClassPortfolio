// Session 3 - Simple Sample Sequencer

// Snd Buf
SndBuf kick => dac;
SndBuf snare => dac;
SndBuf hihat => dac;
SndBuf clap => dac;
SndBuf fx3 => dac;

// Load samples
"audio/kick_01.wav" => kick.read;
"audio/snare_01.wav" => snare.read;
"audio/hihat_01.wav" => hihat.read;
"audio/clap_01.wav" => clap.read;
"audio/stereo_fx_03.wav" => fx3.read;

// Rhythm patterns
[1,0,0,0, 0,0,1,0, 1,0,0,1, 0,1,0,0] @=> int kickPattern[];

[0,0,0,0, 1,0,0,0, 0,0,0,0, 1,0,0,0] @=> int snarePattern[];

[1,0,1,0, 1,1,0,1, 1,0,1,0, 1,1,0,1] @=> int hihatPattern[];

[0,0,0,0, 0,0,0,1, 0,0,0,0, 0,0,1,0] @=> int clapPattern[];

0 => int i;
int step;

while( true )
{
     // Modulo repeats the 16-step pattern
    i % 16 => int step;
    
    // Kick
    if( kickPattern[step] == 1 )
    {
        0 => kick.pos;
        0.8 => kick.gain;
    }
    
    // Snare
    if( snarePattern[step] == 1 )
    {
        0 => snare.pos;
        0.55 => snare.gain;
    }
    
    // Hi-hat
    if( hihatPattern[step] == 1 )
    {
        0 => hihat.pos;
        0.18 => hihat.gain;
    }
    
    // Clap
    if( clapPattern[step] == 1 )
    {
        0 => clap.pos;
        0.35 => clap.gain;
    }
    
    // FX 3 every two bars
    if( i % 32 == 31 )
    {
        0 => fx3.pos;
        0.25 => fx3.gain;
    }
    
    // Tempo
    200::ms => now;
    
    i++;
}        
        
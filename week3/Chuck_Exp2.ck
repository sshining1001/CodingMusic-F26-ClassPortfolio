// sound chain

SinOsc k => Pan2 p => NRev r => dac;
Noise n => dac;
.25 => k.gain;
.15 => r.mix;
.02 => n.gain;

// melody array 

[60, 62, 64, 67, 69, 67, 64, 62,
 60, 62, 64, 67, 72, 69, 67, 64] @=> int A[];

// print number of notes

<<< A.cap() >>>;

// loop the melody

while (true)
{
    for( 0 => int i; i < A.cap(); i++)
    {
        <<< i, A[i] >>>;
        
        // MIDI to freq
        Std.mtof(A[i]) => k.freq;
        
        // random pan position
        Std.rand2f(-1.0, 1.0) => p.pan;
        
        // small random amount of noise
        Std.rand2f(.005, .01) => n.gain;
        
        .35::second => now;  
    }
}
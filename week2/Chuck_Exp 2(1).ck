// synthesis patch

SinOsc kk => NRev r => dac;
SinOsc kk2 => NRev r2 => dac;

.35 => kk.gain;
.15 => kk2.gain;

.2 => r.mix;
.15 => r2.mix;

// an array of notes
[ 0, 2, 4, 7, 9 ] @=> int hi [];

while ( true )
{
    // choose a random note
    45 + Std.rand2(0,3) * 12 +
    hi[Std.rand2(0, hi.cap()-1)] => int note;
    
    // convert MIDI note to frequency
    Std.mtof(note) => kk.freq;
    
    // second oscillator plays a higher note
    Std.mtof(note + 12) => kk2.freq;
    
    // randomly change volume
    Std.rand2f(.2,.5) => kk.gain;
    Std.rand2f(.05,.2) => kk2.gain;
    
    // randomly change reverb
    Std.rand2f(.1,.4) => r.mix;
    
    // different note lengths
    Std.rand2(100,300)::ms => now;
}
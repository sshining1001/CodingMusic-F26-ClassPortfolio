Flute solo => JCRev rev => dac;
solo => Delay d => d => rev;

0.1 => rev.mix;
0.8::second => d.max => d.delay;
0.5 => d.gain;

// Melody
[65,67,69,72,69,67,65,60] @=> int melody[];

while(true)
{
    for(0 => int i; i < melody.cap(); i++)
    {
        Std.mtof(melody[i]) => solo.freq;
        0.7 => solo.noteOn;

        0.45::second => now;

        1 => solo.noteOff;

        0.15::second => now;
    }
}
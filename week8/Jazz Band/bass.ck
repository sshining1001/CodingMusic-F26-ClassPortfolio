Mandolin bass => NRev r => dac;

0.1 => r.mix;

0.0 => bass.stringDamping;
0.02 => bass.stringDetune;
0.05 => bass.bodySize;

// Bass notes
[41,45,48,52,36,43,48,51] @=> int bassLine[];

0 => int pos;

while(true)
{
    Std.mtof(bassLine[pos]) => bass.freq;

    0.3 => bass.pluckPos;
    1 => bass.noteOn;

    0.55::second => now;

    1 => bass.noteOff;

    0.05::second => now;

    (pos + 1) % bassLine.cap() => pos;
}
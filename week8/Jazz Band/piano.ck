Rhodey piano[4];

piano[0] => dac.left;
piano[1] => dac;
piano[2] => dac;
piano[3] => dac.right;

// Two chords
[ [53,57,60,64], [51,55,60,63] ] @=> int chordz[][];

while(true)
{
    // First chord
    for(0 => int i; i < 4; i++)
    {
        Std.mtof(chordz[0][i]) => piano[i].freq;
        0.65 => piano[i].noteOn;
    }

    2.2::second => now;

    for(0 => int i; i < 4; i++)
    {
        1 => piano[i].noteOff;
    }

    0.2::second => now;

    // Second chord
    for(0 => int i; i < 4; i++)
    {
        Std.mtof(chordz[1][i]) => piano[i].freq;
        0.65 => piano[i].noteOn;
    }

    2.2::second => now;

    for(0 => int i; i < 4; i++)
    {
        1 => piano[i].noteOff;
    }

    0.2::second => now;
}
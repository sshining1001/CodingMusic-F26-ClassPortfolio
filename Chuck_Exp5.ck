// 1. Global scope

SinOsc chord1 => dac;
SinOsc chord2 => dac;
SinOsc chord3 => dac;
SinOsc melody => dac;

0.10 => chord1.gain;
0.10 => chord2.gain;
0.10 => chord3.gain;
0.08 => melody.gain;

[60, 65, 57, 62] @=> int roots[];

[72, 76, 74, 69, 72, 77, 76, 71] @=> int notes[];


// 2. Function for chords

fun void playChord(SinOsc c1, SinOsc c2, SinOsc c3,
SinOsc m, int root, int note)
{
    // Local variables
    root + 4 => int third;
    root + 7 => int fifth;
    
    Std.mtof(root) => c1.freq;
    Std.mtof(third) => c2.freq;
    Std.mtof(fifth) => c3.freq;
    Std.mtof(note) => m.freq;
    
    <<< "Chord:", root, third, fifth >>>;
    1.2::second => now;
}


// 3. Function for melody

fun void playMelody(SinOsc m, int note)
{
    Std.mtof(note) => m.freq;
    0.35::second => now;
}


// 4. Recursive progression

fun void playProgression(int index, int count)
{
    if (count <= 0)
    {
        return;
    }
    
    playChord(chord1, chord2, chord3, melody,
    roots[index], notes[(index * 2) % notes.cap()]);
    
    playProgression((index + 1) % roots.cap(), count - 1);
}


// 5. Main program

<<< "Intro" >>>;
playProgression(0, 4);

<<< "Melody" >>>;
for (0 => int i; i < 8; i++)
{
    playMelody(melody, notes[i]);
}

<<< "Second section" >>>;
playProgression(2, 4);

<<< "Melody variation" >>>;
for (8 => int i; i < notes.cap(); i++)
{
    playMelody(melody, notes[i]);
}

<<< "Ending" >>>;
playChord(chord1, chord2, chord3, melody, 60, 72);

0.0 => chord1.gain;
0.0 => chord2.gain;
0.0 => chord3.gain;
0.0 => melody.gain;
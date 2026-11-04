// ---------- BASS ----------

TriOsc bass => LPF bassFilter => Gain bassVol => dac;

SinOsc bassHarmonic => Gain harmonicVol => dac;

// Main bass
Std.mtof(36) => bass.freq;
0.35 => bass.gain;
180 => bassFilter.freq;
0.65 => bassVol.gain;

// Upper harmonic
Std.mtof(48) => bassHarmonic.freq;
0.12 => bassHarmonic.gain;
0.25 => harmonicVol.gain;

// ---------- FM MELODY ----------

SinOsc mod => blackhole;

SinOsc carrier => ADSR env => LPF filt => NRev rev => dac;

0.22 => carrier.gain;
0.32 => rev.mix;
1500 => filt.freq;

env.set(10::ms, 150::ms, 0.2, 400::ms);


// ---------- MODAL BAR ----------

ModalBar bar => NRev barRev => dac;

0.06 => bar.gain;
0.15 => barRev.mix;


// ---------- NOTES ----------

[72, 76, 79, 84, 79, 76, 74, 0,
72, 76, 81, 84, 86, 84, 79, 0,
76, 79, 84, 88, 86, 84, 81, 79] @=> int notes[];


// ---------- PLAY MELODY ----------

for (0 => int i; i < notes.cap(); i++) {
    
    if (notes[i] > 0) {
        
        Std.mtof(notes[i]) => float f;
        f => carrier.freq;
        
        // FM modulation
        Std.rand2f(8.0, 15.0) => mod.freq;
        Std.rand2f(30.0, 90.0) => float depth;
        
        // Filter movement
        1000 + Std.rand2(0, 1800) => filt.freq;
        
        env.keyOn();
        
        for (0 => int j; j < 30; j++) {
            f + mod.last() * depth => carrier.freq;
            10::ms => now;
        }
        
        env.keyOff();
        
        // Occasional metallic accents
        if (i % 4 == 0) {
            f => bar.freq;
            bar.strike(0.35);
        }
        
        if (i % 3 == 0) {
            350::ms => now;
        } else {
            220::ms => now;
        }
        
    } else {
        350::ms => now;
    }
}

2::second => now;
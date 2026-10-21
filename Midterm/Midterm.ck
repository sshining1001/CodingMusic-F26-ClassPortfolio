// SOUND CHAIN
SinOsc bass => NRev bassRev => dac;
SinOsc pad => NRev padRev => dac;
SinOsc lead => NRev leadRev => dac;

// TIMING
0.25::second => dur stepTime;

// REVERB
0.10 => bassRev.mix;
0.30 => padRev.mix;
0.22 => leadRev.mix;

// Verse
[60, 0, 63, 0, 67, 0, 63, 0] @=> int verseLead[];
[36, 0, 36, 43, 0, 36, 0, 43] @=> int verseBass[];
[48, 0, 0, 0, 55, 0, 0, 0] @=> int versePad[];

// Build
[60, 63, 0, 67, 0, 70, 67, 0] @=> int buildLead[];
[36, 0, 43, 0, 39, 0, 43, 0] @=> int buildBass[];
[48, 0, 0, 55, 0, 0, 60, 0] @=> int buildPad[];

// Chorus
[67, 0, 70, 72, 0, 70, 67, 0] @=> int chorusLead[];
[43, 0, 43, 48, 0, 39, 0, 48] @=> int chorusBass[];
[55, 0, 0, 60, 0, 0, 58, 0] @=> int chorusPad[];

// Verse 2
[0, 60, 0, 63, 0, 67, 0, 65] @=> int verse2Lead[];
[36, 0, 0, 43, 0, 39, 0, 0] @=> int verse2Bass[];
[48, 0, 0, 0, 53, 0, 0, 0] @=> int verse2Pad[];

// Final Chorus
[67, 70, 0, 72, 70, 0, 67, 63] @=> int finalLead[];
[43, 0, 48, 0, 39, 0, 43, 0] @=> int finalBass[];
[55, 0, 60, 0, 58, 0, 0, 60] @=> int finalPad[];

// Outro
[60, 0, 0, 63, 0, 0, 60, 0] @=> int outroLead[];
[36, 0, 0, 0, 0, 43, 0, 0] @=> int outroBass[];
[48, 0, 0, 0, 0, 0, 55, 0] @=> int outroPad[];

// INTRO:

fun void playIntro()
{
    Std.mtof(48) => bass.freq;
    Std.mtof(60) => pad.freq;
    Std.mtof(67) => lead.freq;
    
    0.0 => bass.gain;
    0.0 => pad.gain;
    0.0 => lead.gain;
    
    // Slowly bring in the pad
    for (0 => int i; i < 8; i++)
    {
        (0.015 + i * 0.004) => pad.gain;
        1::second => now;
    }
    
    // Bass slowly enters
    for (0 => int i; i < 8; i++)
    {
        (0.015 + i * 0.008) => bass.gain;
        (0.045 + i * 0.003) => pad.gain;
        0.0 => lead.gain;
        0.5::second => now;
    }
}


// PLAY ONE STEP

fun void playStep(int n, int b, int p,
float level, int section)
{
    // Bass
    if (b > 0)
    {
        Std.mtof(b) => bass.freq;
        level * 0.80 => bass.gain;
    }
    else
    {
        0.0 => bass.gain;
    }
    
    // Melody
    if (n > 0)
    {
        Std.mtof(n) => lead.freq;
        level * 0.24 => lead.gain;
    }
    else
    {
        0.0 => lead.gain;
    }
    
    // Ambient pad
    if (p > 0)
    {
        Std.mtof(p) => pad.freq;
    }
    
    level * 0.18 => pad.gain;
    
    // Fuller sound in the choruses
    if (section == 3 || section == 5)
    {
        level * 0.25 => pad.gain;
    }
    
    stepTime => now;
}


// PLAY A SECTION

fun void playSection(int section, int repeats,
float baseLevel)
{
    for (0 => int cycle; cycle < repeats; cycle++)
    {
        for (0 => int i; i < 8; i++)
        {
            0 => int n;
            0 => int b;
            0 => int p;
            
            if (section == 1)
            {
                verseLead[i] => n;
                verseBass[i] => b;
                versePad[i] => p;
            }
            else if (section == 2)
            {
                buildLead[i] => n;
                buildBass[i] => b;
                buildPad[i] => p;
            }
            else if (section == 3)
            {
                chorusLead[i] => n;
                chorusBass[i] => b;
                chorusPad[i] => p;
            }
            else if (section == 4)
            {
                verse2Lead[i] => n;
                verse2Bass[i] => b;
                verse2Pad[i] => p;
            }
            else if (section == 5)
            {
                finalLead[i] => n;
                finalBass[i] => b;
                finalPad[i] => p;
            }
            else
            {
                outroLead[i] => n;
                outroBass[i] => b;
                outroPad[i] => p;
            }
            
            // Small volume changes over time
            baseLevel * (0.85 + 0.15 * cycle / repeats)
            => float level;
            
            // Give the final chorus a little more energy
            if (section == 5)
            {
                baseLevel * (0.90 + 0.10 * (i % 3) / 2.0)
                => level;
            }
            
            // Gradually lower the volume during the outro
            if (section == 6)
            {
                baseLevel * (1.0 - cycle * 1.0 / repeats)
                => level;
            }
            
            playStep(n, b, p, level, section);
        }
    }
}


// FINAL FADE OUT

fun void fadeOut()
{
    // Hold a soft final chord
    Std.mtof(36) => bass.freq;
    Std.mtof(60) => pad.freq;
    Std.mtof(67) => lead.freq;
    
    0.0 => bass.gain;
    0.0 => pad.gain;
    0.0 => lead.gain;
    
    // Gently bring in the final chord
    for (0 => int i; i < 10; i++)
    {
        (0.045 * (i + 1) / 10.0) => bass.gain;
        (0.060 * (i + 1) / 10.0) => pad.gain;
        (0.012 * (i + 1) / 10.0) => lead.gain;
        
        0.1::second => now;
    }
    
    // Fade out smoothly over 8 seconds
    for (0 => int i; i < 80; i++)
    {
        (0.045 * (1.0 - (i + 1) / 80.0)) => bass.gain;
        (0.060 * (1.0 - (i + 1) / 80.0)) => pad.gain;
        (0.012 * (1.0 - (i + 1) / 80.0)) => lead.gain;
        
        0.1::second => now;
    }
    
    // Make sure all sounds are off
    0.0 => bass.gain;
    0.0 => pad.gain;
    0.0 => lead.gain;
}

// FULL COMPOSITION

// 1. Ambient Intro: 
playIntro();

// 2. Verse: 
playSection(1, 6, 0.25);

// 3. Build: 
playSection(2, 6, 0.34);

// 4. Chorus: 
playSection(3, 10, 0.42);

// 5. Verse 2: 
playSection(4, 6, 0.28);

// 6. Final Chorus: 
playSection(5, 10, 0.45);

// 7. Outro: 
playSection(6, 3, 0.20);

// 8. Final ambient fade out: 
fadeOut();
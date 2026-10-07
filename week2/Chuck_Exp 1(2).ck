SinOsc kk => dac;

while( true )
{
    100 => kk.freq;
    .5::second => now; 
    
    200 => kk.freq;
    .5::second => now; 
    
    400 => kk.freq;
    1::second => now; 
}


// synthesis patch 
SinOsc kk => NRev r => dac;
.5 => kk.gain;
.2 => r.mix;

// an array: add stuff
[ 0, 2, 4, 7 ] @=> int hi [];

while ( true )
{
    // change parameters here
    Std.mtof (45 + Std.rand2 (0,4) * 12 +
         hi [Std.rand2(0, hi.cap()-1)] ) => kk.freq;
         
    // different rate
    150::ms => now;
}
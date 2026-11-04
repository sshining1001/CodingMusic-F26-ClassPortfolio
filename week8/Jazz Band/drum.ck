SndBuf hihat => dac;

"/Users/shining/Desktop/Other_Class/Calarts_Master/Intro_to_Coding/CodingMusic-F26-ClassPortfolio/week4/audio/hihat_01.wav" => hihat.read;

0.2 => hihat.gain;
1.0 => hihat.rate;

while(true)
{
    0 => hihat.pos;
    0.6::second => now;
}
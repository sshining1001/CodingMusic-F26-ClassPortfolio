// File paths
"/Users/shining/Desktop/Other_Class/Calarts_Master/Intro_to_Coding/CodingMusic-F26-ClassPortfolio/week8/Jazz Band/piano.ck" => string pianoPath;

"/Users/shining/Desktop/Other_Class/Calarts_Master/Intro_to_Coding/CodingMusic-F26-ClassPortfolio/week8/Jazz Band/bass.ck" => string bassPath;

"/Users/shining/Desktop/Other_Class/Calarts_Master/Intro_to_Coding/CodingMusic-F26-ClassPortfolio/week8/Jazz Band/drums.ck" => string drumsPath;

"/Users/shining/Desktop/Other_Class/Calarts_Master/Intro_to_Coding/CodingMusic-F26-ClassPortfolio/week8/Jazz Band/flute.ck" => string flutePath;


// Intro: Piano
Machine.add(pianoPath) => int pianoID;
4.8::second => now;


// A section: Add Bass
Machine.add(bassPath) => int bassID;
4.8::second => now;


// Add Drums
Machine.add(drumsPath) => int drumsID;
4.8::second => now;


// Melody: Add Flute
Machine.add(flutePath) => int fluteID;
9.6::second => now;


// Breakdown: Remove Drums
Machine.remove(drumsID);
4.8::second => now;


// Final section: Bring Drums back
Machine.add(drumsPath) => drumsID;
9.6::second => now;


// End the performance
Machine.remove(pianoID);
Machine.remove(bassID);
Machine.remove(drumsID);
Machine.remove(fluteID);
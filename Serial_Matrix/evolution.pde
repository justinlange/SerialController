//write out steps in pseudocode

//make step sequencer smaller -- i.e. 8 beats, or perhaps 16
//make step sequencer corrispond to a scale, e.g. Locrian
/*

----------add evolve function (basic)----------
//start with framework of Shakespear genetic algorhythm
//copy array[][] of current step sequencer sequence to targetArray[][]

//iterate through the array[][] of each sequencer population
//score++ if [i] is equal to  targetArray[i]

//perform mutation & crossover & run generations
//keep copies of generations -- add to an ArrayList<generation>
//when solution is reached, retrive a recent solution based on similarityParameter, i.e. generation.get(generation.size-parameter)

----------add evolve function (replicate existing manual functionality)----------
//make class for each step position, holding various data:
    -the string/note (int, values range 1-18)
    -place in sequence it is played (int, values range 1-16, or 1-8)
    -the number of repetitions played at that moment (int, values range 0-100)
    -the time between repetitions (int, values range 0-500)

//iterate over these values in each population object, scoring their similarity to the target sequenceObject
//parameratize the weighting of the fitness function, so that, for example, time between repetitions is valued highly 
(and hence will quickly end up being very close to the target sequence) while number of repetitions played at a trigger's moment 
may be given a very low rating, such that new populations have very different repetitions than the target sequence]]\\

----------add mutate between function (very cool!)------------
//select two existing manually (or note!) created but nevertheless existant sequences, a current sequence and a target sequence
//populate with varatinos of current sequence
//evolve towards target, w/ parameratized functions



*/



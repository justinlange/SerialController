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

// Genetic Algorithm, Evolving Shakespeare
// Daniel Shiffman <http://www.shiffman.net>

// Demonstration of using a genetic algorithm to perform a search

// setup()
//  # Step 1: The Population 
//    # Create an empty population (an array or ArrayList)
//    # Fill it with DNA encoded objects (pick random values to start)

// draw()
//  # Step 1: Selection 
//    # Create an empty mating pool (an empty ArrayList)
//    # For every member of the population, evaluate its fitness based on some criteria / function, 
//      and add it to the mating pool in a manner consistant with its fitness, i.e. the more fit it 
//      is the more times it appears in the mating pool, in order to be more likely picked for reproduction.

//  # Step 2: Reproduction Create a new empty population
//    # Fill the new population by executing the following steps:
//       1. Pick two "parent" objects from the mating pool.
//       2. Crossover -- create a "child" object by mating these two parents.
//       3. Mutation -- mutate the child's DNA based on a given probability.
//       4. Add the child object to the new population.
//    # Replace the old population with the new population
//  
//   # Rinse and repeat


float mutationRate = 0.01;    // Mutation rate
int totalPopulation = 150;      // Total Population
float fitnessThresh = .1;

DNA[] population;             // Array to hold the current population
ArrayList<DNA> matingPool;    // ArrayList which we will use for our "mating pool"
//int[] targetMatrix;
boolean[] returnMatrix;
// Target phrase
//boolean[] sourceMatrix;
int matrixSize;
int evolveCycles = 1000;

//String target;

PFont f;

 
void  setupEvolution() {
  //sourceMatrix = new boolean[nx*ny];
  matrixSize = (nx-1)*(ny-1);
  population = new DNA[totalPopulation];

  for (int i = 0; i < population.length; i++) {
    population[i] = new DNA(matrixSize);
  }
  
  f = createFont("Courier",12,true);
}



void evolve(int targetMatrix[]) {
  
  println("inside of evolving! second 1");
  /*
  for(int i=0;i<matrixSize;i++){
    if(sourceMatrix[i]){
      targetMatrix[i] =1;
    }else{
      targetMatrix[i] =0;
    }
}
*/
//for(int ei=0;ei<evolveCycles;ei++){
  
  for (int i = 0; i < population.length; i++) {
    population[i].calcFitness(targetMatrix);
  }
  println("section 2");

  ArrayList<DNA> matingPool = new ArrayList<DNA>();  // ArrayList which we will use for our "mating pool"

  for (int i = 0; i < population.length; i++) {
    int nnnn = int(population[i].fitness * 100);  // Arbitrary multiplier, we can also use monte carlo method
    for (int j = 0; j <nnnn; j++) {              // and pick two random numbers
      matingPool.add(population[i]);
    }
  }
  println("section 3");

  for (int i = 0; i < population.length; i++) {
    int a = int(random(matingPool.size()));
    int b = int(random(matingPool.size()));
    DNA partnerA = matingPool.get(a);
    DNA partnerB = matingPool.get(b);
    DNA child = partnerA.crossover(partnerB);
    child.mutate(mutationRate);
    population[i] = child;
  }
  
  println("section 4");
  
  //background(255);
  //fill(0);
 
  //String everything = "";
  //for (int i = 0; i < population.length; i++) {
  //  everything += population[i].getPhrase() + "     ";
  //}
  int lastPop = population.length-1;
  float topScore=0;
  int bestGene = 5;
 
   for (int i = 0; i < lastPop; i++) {
     if(population[i].fitness > topScore){
       topScore = population[i].fitness;
       bestGene = i;
     }
      println("fitness at " + i + "  " + population[i].fitness + "  best score: " + topScore + " fitness: " + bestGene);
   }

  
  println("section 5: population.length is: " + lastPop + "  fitnessThresh is: " + fitnessThresh);
  if(swapMatrix){
    println("section 6");
    int[] tempMatrix = new int[matrixSize];
    println("section 7");
   
    for(int i=0;i<matrixSize;i++){
      tempMatrix[i] = population[lastPop].genes[i];
    }
    println("section 8");
    replaceMatrix(tempMatrix);
    println("replaced Matrix!");
    swapMatrix = false;
  }
 // }else{
  // println("fitness too low: " + population[lastPop].fitness);  
  //}
  
  //textFont(f,12);
  //text(everything,10,10,width,height);
  //*/

//}  
}


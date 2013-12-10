// Genetic Algorithm, Evolving Shakespeare
// Daniel Shiffman <http://www.shiffman.net>

// A class to describe a psuedo-DNA, i.e. genotype
//   Here, a virtual organism's DNA is an array of character.
//   Functionality:
//      -- convert DNA into a string
//      -- calculate DNA's "fitness"
//      -- mate DNA with another set of DNA
//      -- mutate DNA


class DNA {

  // The genetic sequence
  int[] genes;
  //boolean[] geneMatrix = new boolean[nx*ny];

  float fitness;
  
  // Constructor (makes a random DNA)
  DNA(int num) {
    matrixSize = num;
    genes = new int[num];
    for (int i = 0; i < genes.length; i++) {
      genes[i] = (int) random(1,5)%2;  // Pick from range of chars
    }
  }
  
  // Converts character array to a String
  int[] getPhrase() {
    return new int[matrixSize];
  }
  
  // Fitness function (returns floating point % of "correct" characters)
  void calcFitness (int[] target) {
     int score = 0;
     for (int i = 0; i < genes.length; i++) {
        if (genes[i] == target[i]) {
          score++;
        }
     }
     fitness = (float)score / (float)matrixSize;
  }
  
  // Crossover
  DNA crossover(DNA partner) {
    // A new child
    DNA child = new DNA(matrixSize);
    
    int midpoint = int(random(matrixSize)); // Pick a midpoint
    
    // Half from one, half from the other
    for (int i = 0; i < matrixSize; i++) {
      if (i > midpoint) child.genes[i] = genes[i];
      else              child.genes[i] = partner.genes[i];
    }
    return child;
  }
  
  // Based on a mutation probability, picks a new random character
  void mutate(float mutationRate) {
    for (int i = 0; i < matrixSize; i++) {
      if (random(1) < mutationRate) {
        genes[i] = (int) random(1,5)%2;
      }
    }
  }
}

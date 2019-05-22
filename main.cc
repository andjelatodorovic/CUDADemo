#include <stdio.h>
#include <stdlib.h>

extern "C" {
  void square(float *a, int N);
}

int main(void) {
  float *a_h;
  const int N = 10;  // Number of elements in arrays
  size_t size = N * sizeof(float);

  a_h = (float *)malloc(size);        
  for (int i=0; i<N; i++) {
    a_h[i] = (float)i;
  }

  square(a_h, N);

  // Print results
  for (int i=0; i<N; i++) printf("%d %f\n", i, a_h[i]);
  // Cleanup
  free(a_h); 
}


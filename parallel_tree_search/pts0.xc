/* A program that searchs for regular expression matchs in strings
   contained in the nodes of an ADT tree.  This is done in parallel using
   Cilk constructs.
 */

#include <stdio.h>
#include <stdlib.h>

#include <cilk.h>
#include <cilk-cilk2c-pre.h>

typedef  datatype Tree  Tree;

datatype Tree {
    Fork (Tree*, Tree*, const char*);
    Leaf (const char*);
};

cilk int count_matches (Tree *t) ;
// this prototype also seems to be required - that is unfortunate, but OK for now


cilk int count_matches (Tree *t) {
    int foo = 9;
    match ( (Tree *) t) {
        Fork(t1,t2,str)-> { 
            int res_t1, res_t2;
            spawn res_t1 = count_matches(t1);
            spawn res_t2 = count_matches(t2);
            int res_str = foo;
            sync;
            cilk return res_t1 + res_t2 + res_str ; 
    }

    Leaf(_) -> { cilk return 1 ; }
    _ -> { cilk return 0 ; }
  } ;
    
}


cilk int main (int argv, char **argc) {
    Tree *tree ;
    tree =
        Fork (
            Fork ( Leaf ("hello"),
                   Leaf ("world"),
                   "123" ),
            Fork ( Leaf ("abc"),
                   Leaf ("456"),
                   "xyz" ),
            "789"
            );
            
    // read in a tree

    int result = 0;
    spawn result = count_matches(tree);
    printf ("Number of matches = %d\n", result);

    cilk return 0;
}




#include <stdio.h>

/* Use 'make opcat' to compile or 'gcc -o opcat opcat.c' */

void cat (FILE *file);

int
main (int argc, char **argv)
{
    register FILE *file;
    for ( register int i = 1; i < argc; ++i ) {
        file = fopen (argv[i], "r");
        cat (file);
        fclose (file);
    }

    return 0;
}

void
cat (FILE *file)
{
    register int c;
    while ( (c = fgetc (file)) != EOF ) putchar (c);
}

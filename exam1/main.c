#define _GNU_SOURCE
#include <stdlib.h>
#include <stdio.h>
#include "main.h"

// In this program, a "document" is a linked list of strings,
// where each string is a single line. Each object in the
// linked list is a structure with the name "line_obj" that
// contains a pointer to the line (of characters) and a
// pointer to the next list item.
//
// ---------------
// | Line: =========> "Line 1 of Document"
// | Next:  ||   |
// ---------||----
//          ||
//          \/
// --------------
// | Line: =========> "Line 2 of Document"
// | Next:  ||   |
// ---------||----
//          ||
//          \/
// ---------------
// | Line: =========> "Line 3 of Document"
// | Next: (NULL)|
// ---------------

int main()
{
  char filename[]="data.txt";
  FILE *fp = NULL;
  char *line;
  size_t line_len = 1024;
  int read;
  struct line_obj *document = NULL;

  fp = fopen(filename, "r");
  
  if(fp == NULL)
    {
      printf("Error: Unable to open input file\n");
      return 1;
    }
 
  // Read in the input file one line at a time
  while(!feof(fp))
    {
      // Allocate heap space for 1 line of characters.
      // Initialize memory to all zeros.
      line = calloc(1, line_len);

      // Read an entire line from the file into a memory
      // buffer that has already been allocated ('line').
      // The buffer  is  null-terminated and includes the newline 
      // character, if one was found.
      read = getline(&line, &line_len, fp);
      printf("Read line of length: %i\n", read);

      // Add each line to the linked list of objects.
      // "document" will always stay pointing to the first line.
      document = line_append(document, line);
    }
    
    free(line);

  // Close the file - done with input
  fclose(fp);

  // Print out the original document
  printf("\nOriginal document read from file: \n");
  line_print(document);
  printf("\n");

  // Delete the document
  line_delete(document);

  return 0;
}


// Append line to the end of the document. 
// Argument 1: Pointer to an existing document (or NULL, if no existing doc)
// Argument 2: Line of characters to append to end of document
// Return: Pointer to the start of the modified document
struct line_obj* line_append(struct line_obj* document , char * line)
{
  struct line_obj* ptr;

  // Allocate heap space for 1 additional line object
  // (which is a pointer to a string + pointer to the next object).
  struct line_obj* object = malloc(sizeof (struct line_obj)); 

  // Set member variables in the new object
  object->line = line;
  object->next = NULL;

  // Add the new object to the end of the existing document
  if(document == NULL)
    {
      // There is no existing document
      // Return a pointer to just this new object
      return object;
    }
  else
    {
      // There is a document list.  Walk it till the end
      ptr = document;
      while(ptr->next != NULL)
	ptr = ptr->next;

      // ptr now is at the end of original string
      // Add the new object to the end
      ptr->next = object;

      // Return a pointer to the original head of the string
      return document;
    }
}

// Print out a document, line by line
// Argument 1: Pointer to start of document
void line_print(struct line_obj* object)
{
  while(object != NULL)
    {
      printf("%s", object->line);
      object = object->next;
    }

  return;
}


// Delete a document by free()ing every line
// Argument 1: Pointer to start of document
void line_delete(struct line_obj* object)
{
  struct line_obj* next_object;

  while(object != NULL)
    {
      next_object = object->next;
      free(object);
      object = next_object;
    }

  return;
}

#ifndef MAIN_H
#define MAIN_H

struct line_obj
{
  char* line;
  struct line_obj* next;
};

struct line_obj* line_append(struct line_obj*, char *);
void line_print(struct line_obj*);
void line_delete(struct line_obj*);

#endif  // MAIN_H

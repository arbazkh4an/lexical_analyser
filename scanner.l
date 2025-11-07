
%{
#include <stdio.h>
#include <string.h>

// Keyword lookup
const char* keywords[] = {
  "agar","warna","jabtak","karo","har","wapas",
  "adad","ashar","lafz","sahi","ghalat","shuru",
  "khatam","amal","dikhao", NULL
};

int isKeyword(const char *lexeme) {
  for (int i = 0; keywords[i]; i++) {
    if (strcmp(lexeme, keywords[i]) == 0)
      return 1;
  }
  return 0;
}

void print_token(const char *type, const char *lexeme) {
  printf("Line %d: %-15s -> %s\n", yylineno, type, lexeme);
}
%}

%option noyywrap

%%

\n                       { yylineno++; }
[ \t\r]+                 { /* ignore whitespace */ }

"//"[^\n]*              { /* single-line comment */ }
"/*"                    { 
                          int c, found_end = 0;
                          while ((c = input()) != 0) {
                            if (c == '\n') yylineno++;
                            else if (c == '*') {
                              c = input();
                              if (c == '/') { found_end = 1; break; }
                              if (c != 0) unput(c);
                            }
                          }
                          if (!found_end && c == 0) {
                            fprintf(stderr, "Error: Unterminated comment starting at line %d\n", yylineno);
                          }
                        }

\"([^"\\]|\\.)*\"        { print_token("STRING_LITERAL", yytext); }
\'([^'\\]|\\.)\'         { print_token("CHAR_LITERAL", yytext); }

[0-9]+(\.[0-9]+)?([eE][+-]?[0-9]+)?  { print_token("NUMBER", yytext); }

[A-Za-z_][A-Za-z0-9_]*   {
                            if (isKeyword(yytext))
                              print_token("KEYWORD", yytext);
                            else
                              print_token("IDENTIFIER", yytext);
                          }

"=="|"!="|"<="|">="|"+"|"-"|"*"|"/"|"="|">"|"<"   { print_token("OPERATOR", yytext); }

";"|","|"("|")"|"{"|"}"  { print_token("PUNCTUATION", yytext); }

.                        { print_token("ERROR", yytext); }

%%

int main(int argc, char **argv) {
  yylineno = 1;
  if (argc > 1) {
    FILE *f = fopen(argv[1], "r");
    if (!f) { perror("fopen"); return 1; }
    yyin = f;
  }
  yylex();
  return 0;
}



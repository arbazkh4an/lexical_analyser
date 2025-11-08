# Lexical Analyzer

A simple lexical analyzer (scanner) for the PakCode programming language. This tool reads source code files and breaks them down into tokens like keywords, identifiers, operators, and literals.

## What it does

The scanner recognizes various token types including:
- Keywords (agar, warna, jabtak, karo, etc.)
- Identifiers (variable and function names)
- Numbers (integers and floating point)
- String and character literals
- Operators (+, -, *, /, ==, !=, etc.)
- Punctuation (semicolons, commas, brackets, etc.)
- Comments (both single-line and multi-line)

## Building the program

First, make sure you have `flex` installed on your system:

```bash
sudo apt-get install flex  # On Ubuntu/Debian
```

Then compile the scanner:

```bash
flex scanner.l
gcc lex.yy.c -o scanner -lfl
```

Or if you're on a system where `-lfl` doesn't work, try:

```bash
gcc lex.yy.c -o scanner
```

## How to use

Once compiled, you can run the scanner on a source code file:

```bash
./scanner filename.txt
```

The program will read the file and print out all the tokens it finds, one per line, showing the line number, token type, and the actual text that was matched.

For example:

```bash
./scanner sample.txt
```

If you don't provide a filename, the scanner will read from standard input (you can type code directly, though that's less convenient).

## Example output

When you run the scanner on a file, you'll see output like this:
```

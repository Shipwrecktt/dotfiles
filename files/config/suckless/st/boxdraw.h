#ifndef BOXDRAW_H
#define BOXDRAW_H

// Declarations for the variables
extern int boxdraw;
extern int boxdraw_braille;
extern int boxdraw_bold;

// Function prototypes for functions that depend on boxdraw
int isboxdraw(Rune u);
ushort boxdrawindex(const Glyph *g);

#endif // BOXDRAW_H


#ifndef VIDEO_H
#define VIDEO_H

static char * const VIDEO_MEMORY = (char*) 0xb8000;

typedef  enum {
    BLACK = 0x00,
    BLUE,
    GREEN,
    CYAN,
    RED,
    MAGENTA,
    BROWN,
    LT_GRAY,
    DK_GRAY,
    LT_BLUE,
    LT_GREEN,
    LT_CYAN,
    LT_RED,
    LT_MAGENTA,
    YELLOW,
    WHITE
} BIOS_COLORS;

static inline int offset(char row, char col) { return 2 * (col + (80 * row)); }
static inline char style(BIOS_COLORS text, BIOS_COLORS bg) {
    return (((char) text) & 0x0f) | (((char) bg) << 4);
}

void htos(unsigned int data, char *buffer, int buf_len);

void write_char(int offset, char ch, char attr);
void write_string(int offset, char *string, char attr);


#endif //VIDEO_H

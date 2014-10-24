#include "video.h"

void write_char(int offset, char ch, char attr) {
    *(VIDEO_MEMORY + offset) = ch;
    *(VIDEO_MEMORY + offset + 1) = attr;
}

void write_string(int offset, char *string, char attr) {
    while(*string != '\0') {
        write_char(offset, *(string++), attr);
        offset += 2;
    }
}

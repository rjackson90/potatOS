#include "video.h"

void write_char(const int offset, const char ch, const char attr) {
    *(VIDEO_MEMORY + offset) = ch;
    *(VIDEO_MEMORY + offset + 1) = attr;
}

void write_string(int offset, char * const string, const char attr) {
    while(*string != '\0') {
        write_char(offset, *(string++), attr);
        offset += 2;
    }
    write_char(offset, '*', attr);
}

void htos(unsigned int data, const char *buffer, int buf_len){
    if(buf_len < 11) return;

    unsigned char bpos = 2;
    while(data != 0){
        unsigned char digit = (unsigned char) ((data & 0xf0000000) >> 28);
        buffer[bpos++] = digit < 0xa ? digit + 0x30 : digit + (0x61 - 0xa);
        data = data << 4;
    }
    buffer[0] = '0';
    buffer[1] = 'x';
    buffer[11] = '\0';
}

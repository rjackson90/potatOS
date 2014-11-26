#include "video.h"

// Strings
const char * const welcome = "Welcome to PotatOS";
const char * const test = "Color test";

void main() {
    char attr = style(WHITE, BROWN);
    write_string(offset(8,22), welcome, attr);

    
    int color_test = offset(11,0);
    write_string(color_test, test, attr);
    /*
    for(char i = BLACK; i <= WHITE; i++){
        for(char j = BLACK; j <= WHITE; j++){
            write_char(offset(i,64+j), 'C', style(j,i));
        }
    }
    */

    int data = 0x0123face;
    char buf[11];
    htos(data, buf, 11);
    write_string(offset(16,0), buf, attr);
    
}

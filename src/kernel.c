#include "video.h"

void main() {
    char attr = style(WHITE, BROWN);
    write_string(offset(8,22), "Welcome to PotatOS", attr);

    int color_test = offset(11,0);
    write_string(color_test, "Color test", attr);
    
    for(char i = BLACK; i <= WHITE; i++){
        for(char j = BLACK; j <= WHITE; j++){
            write_char(offset(i,64+j), 'C', style(j,i));
        }
    }
}

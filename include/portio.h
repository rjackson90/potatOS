#ifndef PORT_IO_H
#define PORT_IO_H

// Read data from ports
static inline unsigned char in_b(unsigned short p){
    unsigned char result;
    asm("in %%dx, %%al" : "=a" (result) : "d" (port));
    return result;
}

static inline unsigned short in_w(unsigned short p){
    unsigned short result;
    asm("in %%dx, %%ax" : "=a" (result) : "d" (port));
    return result;
}

static inline unsigned int in_dw(unsigned short p){
    unsigned int result;
    asm("in %%dx, %%eax" : "=a" (result) : "d" (port));
    return result;
}

// Write data to ports
static inline void out_b(char d, short p){ 
    asm("out %%al, %%dx" : : "a" (data), "d" (port));
}

static inline void out_w(char d, short p){
    asm("out %%ax, %%dx" : : "a" (data), "d" (port));
}

static inline void out_dw(char d, short p){
    asm("out %%eax, %%dx" : : "a" (data), "d" (port));
}

#endif



void main() {
    char* video_memory = (char *) 0xb8000;
    video_memory += 160 * 8;
    *video_memory = 'P';
    video_memory++;
    *video_memory = 0x6f;
}

;   This asm stub simply calls main() when it is loaded
[bits 32]
[extern main]
call main
jmp $

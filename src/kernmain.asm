dw 0

lda 0x31
ota 0xf00000
lda {__cmd_string}
call {%GOT:softstack__push} {%GOT:softstack_fend}
lda {__peek}
call {%GOT:softstack__push} {%GOT:softstack_fend}
lda {%GOT:string_compare}
scall {%GOT:softstack__call}
ldb 0x1
CMP {garbage_scratch}
brch 0b10 {__peek_exec}





:garbage_scratch
dw 0

:__peek
dw 0x50
dw 0x45
dw 0x45
dw 0x4b

:__peek_exec
lda 0x45
ota 0xF00000
jmp {__wait_loop}




:__wait_loop
ie 
jmp {__wait_loop}



:__cmd_string_space_pointer_pointer
dw 0

:__cmd_string_space_pointer
dw 0 
dw 0 
dw 0 
dw 0 
dw 0
dw 0

:__cmd_string_pointer
dw {__cmd_string}

:__cmd_string
dw 0x50
dw 0x45
dw 0x45
dw 0x4b
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0 
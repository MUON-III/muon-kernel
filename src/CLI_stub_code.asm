
dw 0
brch 0b100000 {__inthandler_handleinterrupt_kybd}

jmp {__inthandler_nointerrupt}

jmp {__wait_loop}

:__inthandler_handleinterrupt_kybd
jmp {command_string_entry}

jmp {__wait_loop}

:fend
dw 0

:garbage_scratch
dw 0 


;; kernel starting from zero
:__inthandler_nointerrupt
jmp {__wait_loop}

:command_string_entry
ldai 0xF00002
ldb 0x0a
CMP {garbage_scratch}
brch 0b10 {command_interpreter}
ota 0xF00000
ldb 0x20
CMP {garbage_scratch}
brch 0b10 {__string_space_injection}
otaptr {__cmd_string_pointer}
ldai {__cmd_string_pointer}
ldb 0x1
ADD {__cmd_string_pointer}
jmp {__wait_loop}


:__string_space_injection
lda 0x0
otaptr {__cmd_string_pointer}
ldai {__cmd_string_pointer}
ldb 0x1
ADD {__cmd_string_pointer}
ADD {garbage_scratch}
ldai {garbage_scratch}
otaptr {__cmd_string_space_pointer_pointer}
ldai {__cmd_string_space_pointer_pointer}
ldb 0x1
ADD {__cmd_string_space_pointer_pointer}
jmp {__wait_loop}


:command_interpreter

;;resetting pointers to base
lda {__cmd_string_space_pointer}
ota {__cmd_string_space_pointer_pointer}
lda {__cmd_string}
ota {__cmd_string_pointer}

;;command comparison
lda {__cmd_string}
call {%GOT:softstack__push} {%GOT:softstack_fend}
lda {__peek}
call {%GOT:softstack__push} {%GOT:softstack_fend}
lda {%GOT:string_compare}
scall {%GOT:softstack__call}
ldb 0x1
CMP {garbage_scratch}
brch 0b10 {__peek_exec}



:__prompt
lda 0xa
ota 0xf00000
lda 0x3f
ota 0xf00000
lda 0x3a
ota 0xf00000
jmp {__wait_loop}


:__wait_loop
ie 
jmp {__wait_loop}





:__peek
dw 0x50
dw 0x45
dw 0x45
dw 0x4b
dw 0x00

:__peek_exec
lda 0xa
ota 0xf00000
ldai {__cmd_string_space_pointer}
call {%GOT:softstack__push} {%GOT:softstack_fend}
lda {%GOT:string_to_num}
scall {%GOT:softstack__call}
ota 0xf00001
ota {garbage_scratch}
ldaptr {garbage_scratch}
ota 0xf00001
call {%GOT:softstack__push} {%GOT:softstack_fend}
lda {%GOT:itoa}
scall {%GOT:softstack__call}
ota {garbage_scratch}
call {%GOT:softstack__push} {%GOT:softstack_fend}
lda {%GOT:kprint}
scall {%GOT:softstack__call}
jmp {__prompt}







:__cmd_string_space_pointer_pointer
dw {__cmd_string_space_pointer_pointer}

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
dw 0
dw 0
dw 0
dw 0 
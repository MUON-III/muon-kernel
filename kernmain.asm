dw 0
dw 0
;; interrupt stub
brch 0b100000 {__inthandler_handleinterrupt_kybd}
jmp {__inthandler_nointerrupt}

jmp {__wait_loop}

:__inthandler_handleinterrupt_kybd
jmp {__shell}

lda {__inthandler_notimplementedmsg}
call {kprint} {fend}

jmp {__wait_loop}

:__inthandler_notimplementedmsg
ds Error, interrupts are not implemented.
dw 0x0a
dw 0
:fend
dw 0

;; kernel starting from zero
:__inthandler_nointerrupt

jmp {__wait_loop}

:garbage_scratch
dw 0 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; kernel print function ;;;
;;; ptr to input string   ;;;
;;; stored in A register  ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:kprint_ptr
dw 0
:kprint

ota {kprint_ptr}

:kprint_loop
ldaptr {kprint_ptr}
ldb 0
cmp {__kern_scratch}
brch 2 {kprint_loopend}
ldaptr {kprint_ptr}
ota 0xF00000
ldai {kprint_ptr}
ldb 1
add {kprint_ptr}
jmp {kprint_loop}
:kprint_loopend

ijmp {fend}
jmp {__kern_err_crit}

;;;;;;;;;;;;;;;;;
:__kern_scratch
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0

:__kern_err_msg
ds ERR
:__kern_err_crit
mov {__kern_err_msg} 0xF00000
lda 0x0a
ota 0xF00000

jmp {__wait_loop}

:__shell
ldai 0xF00002
ota 0xF00000
ldb 0x0a
CMP {garbage_scratch}
brch 0b10 {_command_interpreter}
ldb 0x20
CMP {garbage_scratch}
brch 0b10 {__string_space_injection}
ota {__cmd_string}
ldai {__cmd_string}
ldb 0x1
ADD {__cmd_string_pointer}
jmp {__wait_loop}

:__string_space_injection
ota {__cmd_string}
ldai {__cmd_string}
ldb 0x1
ADD {__cmd_string_pointer}
ADD {__cmd_string_space_pointer_pointer}
ldai {__cmd_string_space_pointer_pointer}
ADD {__cmd_string_space_pointer_pointer}
lda 0x4f
ota 0xF00000
lda 0x4B
ota 0xF00000
jmp {__wait_loop}

:_command_interpreter
ldai {__cmd_string}
ota {__cmd_string_pointer}


:__wait_loop
ie
jmp {__wait_loop}

:__hex_lookup
dw 0x0
dw 0x1
dw 0x2
dw 0x3
dw 0x4
dw 0x5
dw 0x6
dw 0x7
dw 0x8
dw 0x9
;;skipped space
dw 0x0
dw 0x0
dw 0x0 
dw 0x0
dw 0x0 
dw 0x0
dw 0x0
;;skipped space
dw 0xa
dw 0xb
dw 0xc
dw 0xd
dw 0xe
dw 0xf

:__cmd_string_pointer
dw {__cmd_string}

:__cmd_string_space_pointer
dw 0 
dw 0 
dw 0 
dw 0 
dw 0 
dw 0

:__cmd_string_space_pointer_pointer
dw {__cmd_string_space_pointer}

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
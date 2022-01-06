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

:_command_interpreter
lda {__cmd_string}
ota {__cmd_string_pointer}
lda {__peek}
ota {__string_compare_secondary_pointer}
lda 0x32
ota 0xf00000
call {__string_compare} {fend}
lda {String_compare_bool}
ldb 0x1
cmp {garbage_scratch}
brch 0b10 {__peek}
ldb 0x30
ADD 0xf00000
lda {__cmd_string}
ota {__cmd_string_pointer}
jmp {__wait_loop}

:__string_compare
lda 0x32
ota 0xf00000
ldaptr {__cmd_string_pointer}
ota {garbage_scratch}
ldbi {garbage_scratch}
ldaptr {__string_compare_secondary_pointer}
CMP {garbage_scratch}
brch 0b10 {__string_compare_true}
lda 0x0
ota {String_compare_bool}
ijmp {fend}

:__string_compare_true
ldb 0x0
CMP {garbage_scratch}
brch 0b10 {string_compare_end_true}
ldai {__cmd_string_pointer}
ldb 0x1
ADD {__cmd_string_pointer}
ldai {__string_compare_secondary_pointer}
ldb 0x1
ADD {__string_compare_secondary_pointer}
lda 0x33
ota 0xf00000
jmp {__string_compare}

:string_compare_end_true
lda 0x1
ota {String_compare_bool}
lda 0x31
ota 0xf00000
ijmp {fend}

:__peek
lda 0x32
ota 0xf00000
ldai {__cmd_string_space_pointer}
ldb 0x1
ADD {__string_to_num_start_pointer}
call {__string_to_num} {fend}
ldai {string_to_num_output}
ota {num_to_string_value}
call {__num_to_string} {fend}
lda {__num_to_string_output} 
call {kprint} {fend}
jmp {__wait_loop}



:__num_to_string_output
dw 0
dw 0 
dw 0 
dw 0
dw 0
dw 0
dw 0

:__num_to_string_loop_escape
ijmp {fend}

:num_to_string_output_pointer
dw {__num_to_string_output}

:__num_to_string_loop
dw 0

:num_to_string_value
dw 0

:__num_to_string
ldai {__num_to_string_loop}
ldb 0x6
cmp {garbage_scratch}
brch 0b10 {__num_to_string_loop_escape}
ldai {num_to_string_value}
SHRA {garbage_scratch}
ldai {garbage_scratch}
SHRA {garbage_scratch}
ldai {garbage_scratch}
SHRA {garbage_scratch}
ldai {garbage_scratch}
SHRA {garbage_scratch}
ldai {garbage_scratch}
ldb 0x00000f
AND {garbage_scratch}
ldai {garbage_scratch}
ldb 0x30
ADD {garbage_scratch}
ldai {garbage_scratch}
otaptr {num_to_string_output_pointer}
ldai {num_to_string_output_pointer}
ldb 0x1
ADD {num_to_string_output_pointer}
ldai {__num_to_string_loop}
ADD {__num_to_string_loop}
jmp {__num_to_string}




:__string_to_num_start_pointer
dw 0

:__string_to_num_loop
dw 0 

:__string_to_num_loop_escape
lda 0x0 
ota {__string_to_num_loop}
ijmp {fend}

:string_to_num_output
dw 0

:__string_to_num
ldai {__string_to_num_loop}
ldb 0x5
CMP {garbage_scratch}
brch 0b10 {__string_to_num_loop_escape}
ldai {__string_to_num_start_pointer}
ldbi 0x31 
SUB {garbage_scratch}
ldai {garbage_scratch}
ldbi {__hex_lookup_pointer}
ADD {garbage_scratch}
ldai {garbage_scratch}
ldbi {string_to_num_output}
OR {string_to_num_output}
SHLA {garbage_scratch}
ldai {garbage_scratch}
SHLA {garbage_scratch}
ldai {garbage_scratch}
SHLA {garbage_scratch}
ldai {garbage_scratch}
SHLA {string_to_num_output}
;;DEBUG
ldai {string_to_num_output}
ota 0xf00000
;;DEBUG
ldai {__string_to_num_loop}
ldb 0x1
ADD {__string_to_num_loop}
ldai {__string_to_num_start_pointer}
ADD {__string_to_num_start_pointer}
jmp {__string_to_num}


:__string_compare_secondary_pointer
dw 0

:String_compare_bool
dw 0 

:__peek
dw 0x50
dw 0x45
dw 0x45
dw 0x4b
dw 0x00

:__wait_loop
ie
jmp {__wait_loop}

:__hex_lookup_pointer
dw {__hex_lookup}

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

:num_to_string_lookup
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
dw 0xa
dw 0xb
dw 0xc
dw 0xd
dw 0xe
dw 0xf

:__cmd_string_space_pointer
dw 0 
dw 0 
dw 0 
dw 0 
dw 0 
dw 0

:__cmd_string_space_pointer_pointer
dw {__cmd_string_space_pointer}

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
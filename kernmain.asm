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



;;;;;;STRING TO NUM;;;;;;

:__string_to_num_loop_escape
lda 0x0 
ota {__string_to_num_loop}
ldb {string_to_num_output}
jmp {softstack__ret}

:__string_to_num
ldai {__string_to_num_loop}
ldb 0x5
CMP {garbage_scratch}
brch 0b10 {__string_to_num_loop_escape}
ldaptr {__string_to_num_start_pointer}
ldb 0x2f
SUB {garbage_scratch}
ldb {__hex_lookup}
ldai {garbage_scratch}
ADD {garbage_scratch}
LDAPTR {garbage_scratch}
ldbi {string_to_num_output}
OR {string_to_num_output}
ldai {string_to_num_output}
SHLA {string_to_num_output}
ldai {string_to_num_output}
SHLA {string_to_num_output}
ldai {string_to_num_output}
SHLA {string_to_num_output}
ldai {string_to_num_output}
SHLA {string_to_num_output}
ldai {__string_to_num_loop}
ldb 0x1
ADD {__string_to_num_loop}
ldai {__string_to_num_start_pointer}
ADD {__string_to_num_start_pointer}
jmp {__string_to_num}

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

:garbage_scratch
dw 0

:__string_to_num_start_pointer
dw 0

:__string_to_num_loop
dw 0 

:string_to_num_output
dw 0


;;;;;;NUM TO String;;;;


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

;;;;;STRING COMPARE;;;;

:__string_compare
ldaptr {__cmd_string_pointer}
ota {garbage_scratch}
ldbi {garbage_scratch}
ldaptr {__string_compare_secondary_pointer}
CMP {garbage_scratch}
brch 0b10 {__string_compare_true}
ldb 0x0
jmp {softstack__ret}

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
ldb 0x1
lda 0x1 
ota {string_output_bool}
jmp {softstack__ret}

:string_output_bool
dw 0 

:__string_compare_secondary_pointer
dw 0


;;;;;;software stack;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; void softstack__pop(word)   ;;
;; A register - data to push   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:softstack__push
ota {softstack_data}
lda 1
ota {__ss_err_crit_code}
ldai {softstack_max}
ldbi {softstack_ptr}
cmp {softstack_scratch0}
brch 2 {__ss_err_crit}

ldai {softstack_data}
otaptr {softstack_ptr}

ldai {softstack_ptr}
ldb 1
add {softstack_ptr}

ijmp {softstack_fend}
jmp {__ss_err_crit}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; word softstack__pop()       ;;
;; A register -- data popped   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:softstack__pop
lda 2
ota {__ss_err_crit_code}
ldai {softstack_ptr}
ldb 1
add {softstack_scratch0}
ldai {softstack_scratch0}
ldbi {softstack_min}
cmp {softstack_scratch0}
brch 2 {__ss_err_crit}

ldai {softstack_ptr}
ldb 0
sub {softstack_ptr}

ldaptr {softstack_ptr}

ijmp {softstack_fend}
jmp {__ss_err_crit}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; void softstack__call(word)  ;;
;; A register - function ptr   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:softstack__call
ota {softstack_scratch2}
otb {softstack_scratch0}
ldai {softstack_scratch0}
call {softstack__push} {softstack_fend}
ijmp {softstack_scratch2}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; void softstack__ret()       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:softstack__ret
otb {softstack_scratch2}
call {softstack__pop} {softstack_fend}
ota {softstack_data}
lda {softstack_scratch2}
ijmp {softstack_data}

:softstack_min
dw 0x10000
:softstack_ptr
dw 0x10000
:softstack_max
dw 0x20000

:softstack_fend
dw 0

:softstack_data
dw 0

:softstack_scratch0
dw 0
:softstack_scratch1
dw 0
:softstack_scratch2
dw 0

:__ss_err_crit_code
dw 0

:__ss_err_crit
lda 0x53
ota 0xF00000
ota 0xF00000
lda 0x45
ota 0xF00000
ldai {__ss_err_crit_code}
ldb 0x30
add {softstack_scratch2}
ldai {softstack_scratch2}
ota 0xF00000
lda 0x0A
ota 0xF00000
hcf














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
lda {__cmd_string_space_pointer}
ota {__cmd_string_space_pointer_pointer}
lda {__cmd_string}
ota {__cmd_string_pointer}
lda {__peek}
ota {__string_compare_secondary_pointer}
lda {__string_compare}
scall {softstack__call}
ldai {string_output_bool}
ldb 0x1
ota 0x1000
cmp {garbage_scratch}
brch 0b10 {__peek_exec}
lda {__cmd_string}
ota {__cmd_string_pointer}
jmp {__wait_loop}



:__peek_exec
lda 0x35
ota 0xf00000
ldaptr {__cmd_string_space_pointer_pointer}
ota 0xf00000
jmp {__peek_exec}
jmp {__wait_loop}





:__peek
dw 0x50
dw 0x45
dw 0x45
dw 0x4b
dw 0x00


:__wait_loop
ie
jmp {__wait_loop}



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
dw 0 

:garbage_scratch
dw 0

:__string_to_num_start_pointer
dw 0

:__string_to_num_loop
dw 0 

:__string_to_num_loop_escape
lda 0x0 
ota {__string_to_num_loop}
ldbi {string_to_num_output}
jmp {softstack__ret1arg}

:%EXP:string_to_num
ldai {softstack_ptr}
ldb 1
sub {garbage_scratch}
ldaptr {garbage_scratch}
ota {__string_to_num_start_pointer}

:__string_to_num_loop_setup
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
ldai {__string_to_num_loop}
ldb 0x5
CMP {garbage_scratch}
brch 0b10 {__string_to_num_loop_escape}
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
jmp {__string_to_num_loop_setup}

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

:string_to_num_output
dw 0

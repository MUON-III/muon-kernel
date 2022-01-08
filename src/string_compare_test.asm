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
hcf

:__cmd_string_pointer
dw test_string

:__string_compare_secondary_pointer
dw test_String_2

:String_compare_bool
dw 0 

:test_string





:test_String_2
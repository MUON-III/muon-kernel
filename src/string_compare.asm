




:string_compare

ldai {softstack_ptr}
ldb 0x1
sub {garbage_scratch}
ldaptr {garbage_scratch}
ota {__string_compare_primary_pointer}


ldai {softstack_ptr}
ldb 0x2
sub {garbage_scratch}
ldaptr {garbage_scratch}
ota {__string_compare_secondary_pointer}

:string_compare_loop
ldaptr {__string_compare_primary_pointer}
ota {garbage_scratch}
ldbi {garbage_scratch}
ldaptr {__string_compare_secondary_pointer}
CMP {garbage_scratch}
brch 0b10 {__string_compare_true}
ldb 0x0
jmp {softstack__ret2arg}

:__string_compare_true
ldb 0x0
CMP {garbage_scratch}
brch 0b10 {string_compare_end_true}
ldai {__string_compare_primary_pointer}
ldb 0x1
ADD {__string_compare_primary_pointer}
ldai {__string_compare_secondary_pointer}
ldb 0x1
ADD {__string_compare_secondary_pointer}
jmp {string_compare_loop}

:string_compare_end_true
ldb 0x1
jmp {softstack__ret2arg}

:__string_compare_primary_pointer
dw 0 

:__string_compare_secondary_pointer
dw 0

:garbage_scratch
dw 0
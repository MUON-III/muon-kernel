



:kprint_ptr
dw 0

:%EXP:kprint
ldai {softstack_ptr}
ldb 1
sub {garbage_scratch}
ldaptr {garbage_scratch}
ota {kprint_ptr}
ota 0xf00001

:kprint_loop
ldaptr {kprint_ptr}
ldb 0
cmp {__kern_scratch}
brch 2 {kprint_loopend}
ldaptr {kprint_ptr}
ota 0xF00000
ldai {kprint_ptr}
ota 0xf00001
ldb 1
add {kprint_ptr}
jmp {kprint_loop}

:kprint_loopend
jmp {softstack__ret1arg}

;;;;;;;;;;;;;;;;
:__kern_scratch
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0

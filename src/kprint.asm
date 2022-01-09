



:kprint_ptr
dw 0

:kprint
ldai {softstack_ptr}
ldb 1
sub {garbage_scratch}
ldai {garbage_scratch}
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
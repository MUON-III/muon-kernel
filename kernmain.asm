dw 0
dw 0
;; interrupt stub
brch 0xFF {__inthandler_handleinterrupt}
jmp {__inthandler_nointerrupt}
hcf

:__inthandler_handleinterrupt

lda {__inthandler_notimplementedmsg}
call {kprint} {fend}

hcf

:__inthandler_notimplementedmsg
ds Error, interrupts are not implemented.
dw 0x0a
dw 0
:fend
dw 0

:__inthandler_handleinterrupt_msg1
ds Starting MUON-III kernel...
dw 0x0a
dw 0

:__inthandler_handleinterrupt_msg2
ds UwU
dw 0x0a
dw 0

;; kernel starting from zero
:__inthandler_nointerrupt

lda {__inthandler_handleinterrupt_msg2}
call {kprint} {fend}

lda 0x20300a
ota 0xf00000

lda {__inthandler_handleinterrupt_msg1}
call {kprint} {fend}

hcf


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
hcf
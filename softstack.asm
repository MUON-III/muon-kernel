
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
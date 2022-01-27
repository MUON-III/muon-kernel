:%EXP:softstack_fend
dw 0

:%EXP:softstack_data
dw 0

:softstack_scratch0
dw 0
:softstack_scratch1
dw 0
:softstack_scratch2
dw 0
:softstack_scratch3
dw 0

:__ss_err_crit_code
dw 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; void softstack__pop(word)   ;;
;; A register - data to push   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:%EXP:softstack__push
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
:%EXP:softstack__pop
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
:%EXP:softstack__call
ota {softstack_scratch2}
otb {softstack_scratch0}
ldai {softstack_scratch0}
call {softstack__push} {softstack_fend}
ijmp {softstack_scratch2}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; void softstack__ret()       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:%EXP:softstack__ret
otb {softstack_scratch2}
call {softstack__pop} {softstack_fend}
ota {softstack_data}
ldai {softstack_scratch2}
ijmp {softstack_data}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; void softstack__ret1arg()   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:%EXP:softstack__ret1arg
otb {softstack_scratch2}
call {softstack__pop} {softstack_fend}
ota {softstack_data}
call {softstack__pop} {softstack_fend}
ldai {softstack_scratch2}
ijmp {softstack_data}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; void softstack__ret2arg()   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:%EXP:softstack__ret2arg
otb {softstack_scratch2}
call {softstack__pop} {softstack_fend}
ota {softstack_data}
call {softstack__pop} {softstack_fend}
call {softstack__pop} {softstack_fend}
ldai {softstack_scratch2}
ijmp {softstack_data}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; void softstack__ret3arg()   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:%EXP:softstack__ret3arg
otb {softstack_scratch2}
call {softstack__pop} {softstack_fend}
ota {softstack_data}
call {softstack__pop} {softstack_fend}
call {softstack__pop} {softstack_fend}
call {softstack__pop} {softstack_fend}
ldai {softstack_scratch2}
ijmp {softstack_data}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; void softstack__ret4arg()   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:%EXP:softstack__ret4arg
otb {softstack_scratch2}
call {softstack__pop} {softstack_fend}
ota {softstack_data}
call {softstack__pop} {softstack_fend}
call {softstack__pop} {softstack_fend}
call {softstack__pop} {softstack_fend}
call {softstack__pop} {softstack_fend}
ldai {softstack_scratch2}
ijmp {softstack_data}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; void softstack__ret5arg()   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:%EXP:softstack__ret5arg
otb {softstack_scratch2}
call {softstack__pop} {softstack_fend}
ota {softstack_data}
call {softstack__pop} {softstack_fend}
call {softstack__pop} {softstack_fend}
call {softstack__pop} {softstack_fend}
call {softstack__pop} {softstack_fend}
call {softstack__pop} {softstack_fend}
ldai {softstack_scratch2}
ijmp {softstack_data}

:softstack_min
dw 0x10000
:%EXP:softstack_ptr
dw 0x10000
:softstack_max
dw 0x20000



hcf

:__ss_err_crit
lda 0x73
ota 0xF00000
ota 0xF00000
lda 0x45
ota 0xF00000
ldai {__ss_err_crit_code}
ldb 0x30
add {__ss_err_crit_code}
ldai {__ss_err_crit_code}
ota 0xF00000
lda 0x0A
ota 0xF00000
hcf

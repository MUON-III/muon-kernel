dw 0
:itoaval
dw 0
:itoaout
dp ******
dw 0
:itoactr
dw 0
:itoaidx
dw 0
:itoascr1
dw 0
:itoascr2
dw 0

:itoalookup
dp 0123456789abcdef


:___itoatest

elda 0xABCDEF
call {softstack__push} {softstack_fend}
lda {itoa}
scall {softstack__call}
ota {garbage_scratch}
ldaptr {garbage_scratch}
ota 0xF00000
ldai {garbage_scratch}
ldb 1
add {garbage_scratch}
ldaptr {garbage_scratch}
ota 0xF00000
ldai {garbage_scratch}
ldb 1
add {garbage_scratch}
ldaptr {garbage_scratch}
ota 0xF00000
ldai {garbage_scratch}
ldb 1
add {garbage_scratch}
ldaptr {garbage_scratch}
ota 0xF00000
ldai {garbage_scratch}
ldb 1
add {garbage_scratch}
ldaptr {garbage_scratch}
ota 0xF00000
ldai {garbage_scratch}
ldb 1
add {garbage_scratch}
ldaptr {garbage_scratch}
ota 0xF00000

hcf

;;;;;;;;;;;;;;; itoa ;;;;;;;;;;;;;;;
;; word* itoa(word)               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:%EXP:itoa

ldai {softstack_ptr}
ldb 1
sub {garbage_scratch}
ldaptr {garbage_scratch}
ota {itoaval}

ldai {itoaval}
ldb 0xF
and {garbage_scratch}
lda {itoalookup}
ldbi {garbage_scratch}
add {itoascr1}
lda 5
ldb {itoaout}
add {itoascr2}
ldaptr {itoascr1}
otaptr {itoascr2}

ldai {itoaval}
ldb 0xF0
and {garbage_scratch}
ldai {garbage_scratch}
call {softstack__push} {softstack_fend}
lda {_shr4}
scall {softstack__call}
ldb {itoalookup}
add {itoascr1}
lda 4
ldb {itoaout}
add {itoascr2}
ldaptr {itoascr1}
otaptr {itoascr2}

ldai {itoaval}
ldb 0xF00
and {garbage_scratch}
ldai {garbage_scratch}
call {softstack__push} {softstack_fend}
lda {_shr4}
scall {softstack__call}
call {softstack__push} {softstack_fend}
lda {_shr4}
scall {softstack__call}
ldb {itoalookup}
add {itoascr1}
lda 3
ldb {itoaout}
add {itoascr2}
ldaptr {itoascr1}
otaptr {itoascr2}

ldai {itoaval}
ldb 0xF000
and {garbage_scratch}
ldai {garbage_scratch}
call {softstack__push} {softstack_fend}
lda {_shr4}
scall {softstack__call}
call {softstack__push} {softstack_fend}
lda {_shr4}
scall {softstack__call}
call {softstack__push} {softstack_fend}
lda {_shr4}
scall {softstack__call}
ldb {itoalookup}
add {itoascr1}
lda 2
ldb {itoaout}
add {itoascr2}
ldaptr {itoascr1}
otaptr {itoascr2}

ldai {itoaval}
eldb 0xF0000
and {garbage_scratch}

lda 0
ota {itoactr}
:itoaloopd2st
ldai {garbage_scratch}
call {softstack__push} {softstack_fend}
lda {_shr4}
scall {softstack__call}
ota {garbage_scratch}
;;
ldai {itoactr}
ldb 3
cmp {garbage_scratch2}
brch 2 {itoaloopd2e}
ldai {itoactr}
ldb 1
add {itoactr}
jmp {itoaloopd2st}
:itoaloopd2e

ldai {garbage_scratch}
ldb {itoalookup}
add {itoascr1}
lda 1
ldb {itoaout}
add {itoascr2}
ldaptr {itoascr1}
otaptr {itoascr2}

ldai {itoaval}
eldb 0xF00000
and {garbage_scratch}

lda 0
ota {itoactr}
:itoaloopd1st
ldai {garbage_scratch}
call {softstack__push} {softstack_fend}
lda {_shr4}
scall {softstack__call}
ota {garbage_scratch}
;;
ldai {itoactr}
ldb 4
cmp {garbage_scratch2}
brch 2 {itoaloopd1e}
ldai {itoactr}
ldb 1
add {itoactr}
jmp {itoaloopd1st}
:itoaloopd1e

ldai {garbage_scratch}
ldb {itoalookup}
add {itoascr1}
ldaptr {itoascr1}
ota {itoaout}

ldb {itoaout}
jmp {softstack__ret1arg}

hcf



;;;;;;;;;;;;;;; _shr4 ;;;;;;;;;;;;;;;
;; word _shr4(word)                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:_shr4

ldai {softstack_ptr}
ldb 1
sub {garbage_scratch}
ldaptr {garbage_scratch}

shra {garbage_scratch}
ldai {garbage_scratch}
shra {garbage_scratch}
ldai {garbage_scratch}
shra {garbage_scratch}
ldai {garbage_scratch}
shra {garbage_scratch}
ldbi {garbage_scratch}
elda 0x0FFFFF
and {garbage_scratch}

ldbi {garbage_scratch}
jmp {softstack__ret1arg}
jmp {__ss_err_crit}

:garbage_scratch
dw 0
:garbage_scratch2
dw 0

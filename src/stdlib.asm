;; softstack ;;
$include src/softstack.asm
%GOT:softstack__call
%GOT:softstack__ret
%GOT:softstack__push
%GOT:softstack__pop
%GOT:softstack__ret1arg
%GOT:softstack_fend

;; itoa
$include src/itoa.asm
%GOT:itoa
;; softstack ;;
$include src/softstack.asm
%GOT:softstack__call
%GOT:softstack__ret
%GOT:softstack__push
%GOT:softstack__pop
%GOT:softstack__ret1arg
%GOT:softstack__ret2arg
%GOT:softstack__ret3arg
%GOT:softstack__ret4arg
%GOT:softstack__ret5arg
%GOT:softstack_ptr
%GOT:softstack_fend

;; itoa
$include src/itoa.asm
%GOT:itoa

;; string_to_num
$include src/string_to_num_working.asm
%GOT:__string_to_num
dw 0
dw 0
;; interrupt stub
brch 0b100000 {__inthandler_handleinterrupt_kybd}


jmp {__wait_loop}

:__inthandler_handleinterrupt_kybd
jmp {__shell}

jmp {__wait_loop}

:fend
dw 0

;; kernel starting from zero
:__inthandler_nointerrupt






:usr_task
jmp {__wait_loop}

;;currently set aside for later programming


:__wait_loop
ie 
jmp {__wait_loop}
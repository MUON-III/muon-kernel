
dw 0

brch 0b100000 {__inthandler_handleinterrupt_kybd}


:__inthandler_handleinterrupt_kybd
lda 0x31
ota 0xf00001 



:garbage_scratch
dw 0

:A_save
dw 0 

:B_save
dw 0

:flag_scratch
dw 0 

:page_number
dw 0 

:page_multiply_loop
dw 0

:page_lookup_pointer
dw 0

:return_address_pointer
dw 0





































;;saving the values in A and B plus flags. 

:save_flag_a_b
brch 0b01 {carry_true}
brch 0b10 {equals_true}
ota {A_save}
otb {B_save}
lda 0x0
ota {flag_scratch}
jmp {multiply_loop}

:carry_true
brch 0b10 {carry_equals_true}
ota {A_save}
otb {B_save}
lda 0b01
ota {flag_scratch}
jmp {multiply_loop}

:equals_true
ota {A_save}
otb {B_save}
lda 0b10
ota {flag_scratch}
jmp {multiply_loop}

:carry_equals_true
ota {A_save}
otb {B_save}
lda 0b11
ota {flag_scratch}
jmp {multiply_loop}

;saving the scratch values to the table. 
;muliplying it by 4 to get the offset
:multiply_loop
ldai {page_multiply_loop}
ldbi {page_number}
cmp {garbage_scratch}
brch 0b10 {multiply_loop_escape}
ldai {page_number}
shla {garbage_scratch}
ldai {garbage_scratch}
shla {page_output_pointer}

:multiply_loop_escape
lda {page_lookup}
ldbi {page_output_pointer}
ADD {page_output_pointer}
ldai {flag_scratch}
ldb 0b100
AND {flag_scratch}
ldai {flag_scratch}
otaptr {page_output_pointer}
ldai {page_output_pointer}
ldb 0x1 
ADD {page_output_pointer}
ldai {A_save}
otaptr {page_output_pointer}
ldai {page_output_pointer}
ldb 0x1 
ADD {page_output_pointer}
ldai {B_save}
otaptr {page_output_pointer}
ldai {page_output_pointer}
ldb 0x1 
ADD {page_output_pointer}
IRET 
otaptr {page_output_pointer}
jmp {kernel_housekeeping}




:kernel_housekeeping
jmp {task_switcher}


:task_switcher
ldai {page_number}
ldb 0x40
CMP {garbage_scratch}
bchk 0b10 {restart_round_robin}







:restart_round_robin
lda 0x0
ota {page_number}
lda {page_lookup}
ldb 0x3 
ADD {return_address_pointer}
ldai {return_address_pointer}
ldb 0x1
ADD {return_address}

SMMJMP {page_number} {return_address}








































;To read the flags and page status (in use or not). muliply the page number by 4.
;To read the A register add one
;to read B add two
;to read return address add three
:page_lookup
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
dw 0 
dw 0 
dw 0 
dw 0
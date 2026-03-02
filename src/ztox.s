# z to x - converter collection
.intel_syntax noprefix

# NOTE: base is up to 10

# uint to ascii
# rdi - base
# rsi - buf1 (tmp)
# rdx - buf2 (output)
# r10 - buf len
# r8 - uint
# rax = len
# rax = 0 if err
uitoa:
  # buf2
  mov r9, rdx
  # index
  mov rcx, 0

  Luitoa_loop0_beg:
    cmp rcx, r10
    je Luitoa_loop0_overflow

    # divide uint by base
    mov rdx, 0
    mov rax, r8
    div rdi
    # copy remainder + '0' to buf1
    mov r8, rax
    add rdx, '0'
    mov [rsi + rcx], rdx

    add rcx, 1

    # break if uint is 0
    cmp r8, 0
    je Luitoa_loop0_end
    
    jmp Luitoa_loop0_beg 
  Luitoa_loop0_overflow:
    mov rax, 0
    ret
  Luitoa_loop0_end:

  # buf2 index
  mov r11, 0
  # buf1 index
  mov r12, rcx
  sub r12, 1

  # reverse buf
  Luitoa_loop1_beg:
    cmp r11, rcx
    je Luitoa_loop1_end

    # copy char to buf2
    mov rax, [rsi + r12]
    mov [r9 + r11], rax
    
    add r11, 1
    sub r12, 1
    jmp Luitoa_loop1_beg
  Luitoa_loop1_end:

  mov rax, rcx
  ret

# ascii to uint
# rdi - base
# rsi - buf
# rdx - buf len
atoui:
  # buf len
  mov r8, rdx
  # buf index
  mov rcx, 0
  # uint
  mov rbx, 0
  # max base
  mov r9, '0'
  add r9, rdi

  Latoui_loop_beg:
    cmp rcx, r8
    je Latoui_loop_end
    
    # prepare next part
    movzx r10, byte ptr [rsi + rcx]
    # break if part less than '0' or greater than '0' + base
    cmp r10, '0'
    jb Latoui_loop_end
    cmp r10, r9
    jae Latoui_loop_end
    # part to uint
    sub r10, '0'

    # mul uint by base
    mov rdx, 0
    mov rax, rbx
    mul rdi
    # overflow check
    cmp rdx, 0
    jne Latoui_loop_end

    # add part to uint
    add rax, r10
    # overflow check
    jc Latoui_loop_end

    # copy result back to rbx
    mov rbx, rax
    
    add rcx, 1
    jmp Latoui_loop_beg
  Latoui_loop_end:

  mov rax, rbx

  ret


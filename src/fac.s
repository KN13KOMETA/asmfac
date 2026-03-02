.intel_syntax noprefix

# calc factorial
# rdi - n
# rax = result
# rax = 0 if err
fac:
  # return if n is 0, 1, 2
  cmp rdi, 0
  je Lfac_ret_1
  cmp rdi, 1
  je Lfac_ret_1
  cmp rdi, 2
  je Lfac_ret_2

  # index
  mov rcx, 3
  # result
  mov rsi, 2

  Lfac_beg:
    # mul result by index
    mov rdx, 0
    mov rax, rsi
    mul rcx

    # return if overflow
    cmp rdx, 0
    jne Lfac_ret_0

    # copy result back
    mov rsi, rax

    # return if index == n
    cmp rdi, rcx
    je Lfac_end

    add rcx, 1
    jmp Lfac_beg
  Lfac_end:

  mov rax, rsi
  ret

  Lfac_ret_0:
  mov rax, 0
  ret

  Lfac_ret_1:
  mov rax, 1
  ret

  Lfac_ret_2:
  mov rax, 2
  ret


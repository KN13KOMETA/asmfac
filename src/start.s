.global _start
.intel_syntax noprefix

.include "src/ztox.s"
.include "src/fac.s"



.section .bss

fac_input:
  .quad 0

fac_result:
  .quad 0

buf_input:
  .skip 8

buf_tmp:
  .skip 32

buf_output:
  .skip 32



.section .rodata

m_user_input:
  .ascii "Write positive int for calculating factorial: "
m_user_input_len = . - m_user_input

m_fac_result:
  .ascii "Factorial result: "
m_fac_result_len = . - m_fac_result

m_fac_result_error:
  .ascii "Error at calculating factorial.\n"
m_fac_result_error_len = . - m_fac_result_error



.section .text

prompt_user_input:
  # write
  mov rax, 1
  mov rdi, 1
  lea rsi, [m_user_input]
  mov rdx, m_user_input_len
  syscall

  # read
  mov rax, 0
  mov rdi, 0
  lea rsi, [buf_input]
  mov rdx, 8
  syscall

  # convert ascii to uint
  mov rdi, 10
  lea rsi, [buf_input]
  mov rdx, 8
  call atoui

  # move convert result to input
  mov [fac_input], rax
  ret

write_fac_result:
  # error if fac result is 0
  cmp byte ptr [fac_result], 0
  je Lwrite_fac_result_err

  # convert uint to ascii
  mov rdi, 10
  lea rsi, [buf_tmp]
  lea rdx, [buf_output]
  mov r10, 31
  mov r8, [fac_result]
  call uitoa

  mov r14, rax

  cmp r14, 0
  je Lwrite_fac_result_err
    mov byte ptr [buf_output + r14], '\n'

    # write
    mov rax, 1
    mov rdi, 1
    lea rsi, [m_fac_result]
    mov rdx, m_fac_result_len
    syscall

    # write
    mov rax, 1
    mov rdi, 1
    lea rsi, [buf_output]
    mov rdx, r14
    add rdx, 1
    syscall

    mov rax, 0
    jmp Lwrite_fac_result_end
  Lwrite_fac_result_err:
    # write
    mov rax, 1
    mov rdi, 1
    lea rsi, [m_fac_result_error]
    mov rdx, m_fac_result_error_len
    syscall
    
    mov rax, 1
  Lwrite_fac_result_end:
  ret

_start:
  call prompt_user_input

  mov rdi, [fac_input]
  call fac
  mov [fac_result], rax

  call write_fac_result
  mov r15, rax

  # exit
  mov rax, 60
  mov rdi, r15
  syscall


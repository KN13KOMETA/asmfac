.global _start
.intel_syntax noprefix

.include "src/ztox.s"



.section .bss

fac_input:
  .quad 0

fac_result:
  .quad 0

buf_input:
  .skip 8



.section .rodata

m_user_input:
  .ascii "Write positive int for calculating factorial: "
m_user_input_len = . - m_user_input



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

_start:
  call prompt_user_input

  # exit
  mov rax, 60
  mov rdi, [fac_input]
  syscall


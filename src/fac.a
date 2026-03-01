.global _start
.intel_syntax noprefix

.include "src/ztox.a"



.section .bss

buf_input:
  .skip 8



.section .rodata

message:
  .asciz "ECHO: "



.section .text

_start:
  #read
  mov rax, 0
  mov rdi, 0
  lea rsi, [buf_input]
  mov rdx, 8
  syscall

  # write
  mov rax, 1
  mov rdi, 1
  lea rsi, [message]
  mov rdx, 6
  syscall

  # write
  mov rax, 1
  mov rdi, 1
  lea rsi, [buf_input]
  mov rdx, 6
  syscall

  # exit
  mov rax, 60
  # mov rdi, 0
  mov rdi, rdx
  syscall


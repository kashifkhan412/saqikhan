.model small
.stack 100h

.data
msg1 db "Before Swap:",0Dh,0Ah,"Employee ID = $"
msg2 db 0Dh,0Ah,"Department Code = $"
msg3 db 0Dh,0Ah,0Dh,0Ah,"After Swap:",0Dh,0Ah,"Employee ID = $"
msg4 db 0Dh,0Ah,"Department Code = $"

.code
main proc

    mov ax, @data
    mov ds, ax

    ; Load values into registers
    mov ax, 1234        ; Employee ID
    mov bx, 5678        ; Department Code

    ; ----- Display Before Swap -----
    mov ah, 09h
    lea dx, msg1
    int 21h

    mov dx, ax          ; print AX
    call print_num

    mov ah, 09h
    lea dx, msg2
    int 21h

    mov dx, bx          ; print BX
    call print_num

    ; ----- Swap using XCHG -----
    xchg ax, bx

    ; ----- Display After Swap -----
    mov ah, 09h
    lea dx, msg3
    int 21h

    mov dx, ax
    call print_num

    mov ah, 09h
    lea dx, msg4
    int 21h

    mov dx, bx
    call print_num

    ; Exit
    mov ah, 4Ch
    int 21h

main endp

; Procedure to print number in DX
print_num proc
    mov ax, dx
    call print_ax
    ret
print_num endp

; EMU8086 built-in routine
print_ax proc
    push ax
    push bx
    push cx
    push dx

    mov cx, 0
    mov bx, 10

next_digit:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne next_digit

print_loop:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_loop

    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_ax endp

end main
(define INST_MASK_OPCODE  #x7f)
(define INST_MASK_RD      #xf80)
(define INST_MASK_FUNCT3  #x7000)
(define INST_MASK_RS1     #xf8000)
(define INST_MASK_RS2     #x1f00000)
(define INST_MASK_FUNCT7  #xfe000000)
(define INST_MASK_I_IMM   #xfff00000)
(define INST_MASK_S_IMM_1 #xf80)
(define INST_MASK_S_IMM_2 #xfe000000)
(define INST_MASK_U_IMM   #xfffff000)

(define (Get-Opcode isnt)
    (logand isnt)
)

;;; The R Type Instruction:
;  -------------------------------------------
; |31    25|24 20|19 15|14    12|11 7|6     0|
; -------------------------------------------
;| funct7 | rs2 | rs1 | funct3 | rd | opcode|
;-------------------------------------------

(define-record Instruction (
    opcode
    rd
    rs1
    rs2
    imm
    funct3
    funct7
    type
))

(define (Prase-R-Instruction ins)
    (let (
        (opcode (logand ins INST_MASK_OPCODE))
        (rd     (logand ins INST_MASK_RD))
        (funct3 (logand ins INST_MASK_FUNCT3))
        (rs1    (logand ins INST_MASK_RS1))
        (rs2    (logand ins INST_MASK_RS2))
        (funct7 (logand ins INST_MASK_FUNCT7))
    )
    (make-Instruction opcode rd rs1 rs2 '() funct3 funct7 'R)
))

(define (Prase-I-Instruction ins)
    (let (
        (opcode (logand ins INST_MASK_OPCODE))
        (rd     (logand ins INST_MASK_RD))
        (funct3 (logand ins INST_MASK_FUNCT3))
        (rs1    (logand ins INST_MASK_RS1))
        (imm    (logand ins INST_MASK_I_IMM))
    )
    (make-Instruction opcode rd rs1 '() imm funct3 '() 'I)
))

(define (Prase-S-Instruction ins)
    (let (
        (opcode (logand ins INST_MASK_OPCODE))
        (imm1   (logand ins INST_MASK_S_IMM_1))
        (funct3 (logand ins INST_MASK_FUNCT3))
        (rs1    (logand ins INST_MASK_RS1))
        (rs2    (logand ins INST_MASK_RS2))
        (imm2   (logand ins INST_MASK_S_IMM_2))
    )
    (make-Instruction opcode '() rs1 rs2 imm funct3 '() 'S)
))

(define (Prase-U-Instruction ins)
    (let (
        (opcode (logand ins INST_MASK_OPCODE))
        (rd     (logand ins INST_MASK_RD))
        (imm    (logand ins INST_MASK_U_IMM))
    )
    (make-Instruction opcode rd '() '() imm '() '() 'U)
))

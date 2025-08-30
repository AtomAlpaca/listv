(import scheme)

; 64 MB by default
(define DEFAULT_MEMORY_LEN (* 1024 1024 64))

(define-record Memory(
    memory
))

(define Crate-Memory
(
    case-lambda ( ()
        make-bytevector DEFAULT_MEMORY_LEN 0
    ) ( (len)
        make-bytevector len 0
    ))
)

(define (Memory-Load memory address bytes . endianness)
    (let ((endian (if (null? endianness) 'little endianness)))
        (case bytes
            (1 bytevector-u4-ref  memory address endian)
            (2 bytevector-u8-ref  memory address endian)
            (4 bytevector-u16-ref memory address endian)
            (8 bytevector-u32-ref memory address endian)
    )))


(define (Memory-Store memory address bytes . endianness)
    (let ((endian (if (null? endianness) 'little endianness)))
        (case bytes
            (1 bytevector-u4-set! memory address endian)
            (2 bytevector-u8-set! memory address endian)
            (4 bytevector-u16-set! memory address endian)
            (8 bytevector-u32-set! memory address endian)
    )))

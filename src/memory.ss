(import scheme)

; 64 MB by default
(define DEFAULT_MEMORY_LEN (* 1024 1024 64))

(define-record Memory (
    mem
))

(define Create-Memory (
    case-lambda 
    (()    (make-Memory (make-bytevector DEFAULT_MEMORY_LEN 0)))
    ((len) (make-Memory (make-bytevector len                0)))
))

(define (Memory-Load memory address bytes . endianness)
    (let ((endian (if (null? endianness) 'little endianness)))
        (case bytes
            (1 (bytevector-u8-ref  (Memory-mem memory) address))
            (2 (bytevector-u16-ref (Memory-mem memory) address endian))
            (4 (bytevector-u32-ref (Memory-mem memory) address endian))
            (8 (bytevector-u64-ref (Memory-mem memory) address endian))
    )))


(define (Memory-Store memory address bytes content . endianness)
    (let ((endian (if (null? endianness) 'little endianness)))
        (case bytes
            (1 (bytevector-u8-set!  (Memory-mem memory) address content))
            (2 (bytevector-u16-set! (Memory-mem memory) address content endian))
            (4 (bytevector-u32-set! (Memory-mem memory) address content endian))
            (8 (bytevector-u64-set! (Memory-mem memory) address content endian))
    )))

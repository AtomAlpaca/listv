(import scheme)

(load "memory.ss")

(define-record Bus (
    memory
))

(define Create-Bus ( 
    case-lambda 
    (()    (make-Bus (Create-Memory)))
    ((mem) (make-Bus mem))))

(define (Bus-Load bus address bytes . endianness)
    (let ( (memory (Bus-memory bus)) )
        (if (null? endianness)
            (Memory-Load memory address bytes)
            (Memory-Load memory address bytes endianness)
        )
    ))


(define (Bus-Store bus address bytes content . endianness)
    (let ( (memory (Bus-memory bus)) )
        (if (null? endianness)
            (Memory-Store memory address bytes content)
            (Memory-Store memory address bytes content endianness)
        )
    ))
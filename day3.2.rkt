#lang racket/base
(require racket/file)

; Read the file as lines
(define lines (file->lines "input3.txt"))

(define (y-to-x step-x y)
  (modulo (* step-x y) 31))

(define (tree-hit? line position)
  (equal? #\# (string-ref line position)))

(define (slide lines step-x step-y y)
  (let [(trimmed-lines (list-tail lines step-y))]
    (if (< (length trimmed-lines) step-y)
        0
        (+ (if (tree-hit? (car trimmed-lines) (y-to-x step-x y)) 1 0)
           (slide trimmed-lines step-x step-y (+ 1 y))))))

(*
 (slide lines 1 1 1)
 (slide lines 3 1 1)
 (slide lines 5 1 1)
 (slide lines 7 1 1)
 (slide lines 1 2 1)
)

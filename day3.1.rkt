#lang racket
(require racket/file)

; Read the file as lines
; The first line is ignored
(define lines (cdr (file->lines "input3.txt")))

(define (y-to-x y)
  (modulo (* 3 y) 31))

(define (tree-hit? line position)
  (equal? #\# (string-ref line position)))

(define (slide lines y)
  (if (empty? lines)
      0
      (+ (if (tree-hit? (car lines) (y-to-x y)) 1 0)
         (slide (cdr lines) (+ 1 y)))))

(slide lines 1)

(define data (list-tail lines 2))

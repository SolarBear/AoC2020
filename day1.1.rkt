#lang racket

; Read a file
(define (input-file filename)
  (port->string (open-input-file filename) #:close? #t))

; Read the file as lines, converting them to integers
(define (inputs-as-ints filename)
  (map string->number (string-split (input-file filename))))

; Given a sum, a number and a list of values, look
; for a number that gives the sum we're looking for
(define (match-sum total val lst)
  (cond
    [(empty? lst)
     lst]
    [(equal? (+ val (car lst)) total)
     (list val (car lst))]
    [else (match-sum total val (cdr lst))]))

; Given a sum and a list of numbers, find two numbers
; that add to the sum we're looking for
(define (find-pair-sum total lst)
  (if (empty? lst)
      "Err... oops!"
      (let ([match (match-sum total (car lst) (cdr lst))])
        (if (empty? match)
            (find-pair-sum total (cdr lst))
            match))))

; The pair we're looking for
(define pair (find-pair-sum 2020 (inputs-as-ints "input1.1.txt")))

; Multiply those numbers, this is the result we're looking for!
(* (first pair) (second pair))
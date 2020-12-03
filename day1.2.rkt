#lang racket

; Read a file
(define (input-file filename)
  (port->string (open-input-file filename) #:close? #t))

; Read the file as lines, converting them to integers
(define (inputs-as-ints filename)
  (map string->number (string-split (input-file filename))))

(define (n-plets n current lst)
  (cond
    [(empty? lst) '()]
    [(= n 1)
      (map (lambda (x) (append current (list x))) lst)]
    [else
      (append (n-plets (- n 1) (append current (list (car lst))) (cdr lst))
              (n-plets n current (cdr lst)))]))

;(define pairs (n-plets 2 '() (inputs-as-ints "input1.1.txt")))
(define triples (n-plets 3 '() (inputs-as-ints "input1.1.txt")))

;(apply * (car (filter (lambda (x) (= 2020 (apply + x))) pairs)))
(apply * (car (filter (lambda (x) (= 2020 (apply + x))) triples)))
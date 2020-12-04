#lang racket

(require racket/file)

; Read the file as lines
(define lines (file->lines "input2.txt"))

; Useful struct and its related regex
(struct password (min max char text))
(define password-regex #px"(\\d+)-(\\d+) (\\w): (\\w+)")

(define (read-password p)
  (apply password (cdr (regexp-match password-regex p))))

(define passwords (map read-password lines))

(define (count-character str char)
  (length (filter (lambda (c) (equal? char c)) (string->list str))))

(define (password-ok password)
  (let
      [(nb-char (count-character (password-text password) (string-ref (password-char password) 0)))]
    (and
     (>= nb-char (string->number (password-min password)))
     (<= nb-char (string->number (password-max password))))))

(define (password-really-ok password)
  (let [(chr1 (string-ref (password-text password) (- (string->number (password-min password)) 1)))
        (chr2 (string-ref (password-text password) (- (string->number (password-max password)) 1)))
        (test-chr (string-ref (password-char password) 0))]
    (xor
     (equal? chr1 test-chr)
     (equal? chr2 test-chr))))

(length (filter password-ok passwords))
(length (filter password-really-ok passwords))
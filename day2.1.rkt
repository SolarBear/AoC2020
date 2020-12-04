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

(length (filter password-ok passwords))

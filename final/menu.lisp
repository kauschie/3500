;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LISP menu Demo
;; CMPS 3500 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Menu Set Up
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun options ()
  (print "----------------------------")
  (print "---- Final test in LISP ----")
  (print "----------------------------")
  (print "Please pick an Option:      ")
  (print "----------------------------")
  (print "For problem 1 press 1.")
  (print "For problem 2 press 2.")
  (print "For problem 3 press 3.")
  (print "For problem 4 press 4.")
  (print "For problem 5 press 5.")
  (print "To Quit press 6.      ")
  (terpri)
  (let ((opt (read))) 
    (case opt
      (1 (problem_1))
      (2 (problem_2))
      (3 (problem_3))
      (4 (problem_4))
      (5 (problem_5))
      (6 (quit))
      (otherwise (options))))
)

;; Function Definintons
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Problem 1
(defun problem_1()
    (print "Code for problem 1 goes here")
    (terpri)
    (options)
)

;; Problem 2
(defun problem_2()
    (print "Code for problem 2 goes here")
    (terpri)
    (options)
)

;; Problem 3
(defun problem_3()
    (print "Code for problem 3 goes here")
    (terpri)
    (options)
)

;; Problem 4
(defun problem_4()
    (print "Code for problem 4 goes here")
    (terpri)
    (options)
)

;; Problem 5
(defun problem_5()
    (print "Code for problem 5 goes here")
    (terpri)
    (options)
)

;; Call menu here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(options)
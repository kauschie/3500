;CMPS 3555
;defining fibonacci function
(defun fib (n)
  ;Computes the nth Fibonacci number
  (cond ((or (not (integerp n)) (< n 0)) ; error case
         (error "~s must be an integer >= 0.~&" n))
        ((eql n 0) 0)        ; base case
        ((eql n 1) 1)        ; base case
        (t (+ (fib (- n 1))  ; recursively compute fib(n)
              (fib (- n 2))))))
;print some elements
(print "Printing some fibonacii numbers")
(print "*******************************")
(print (fib 2))
(print (fib 10))
(terpri) ; prints a new line
;printing first 10 fibonacci numbers
(print "Printing the first 20 fibonacci numbers")
(print "***************************************")
(loop for i from 1 to 20
   do (print (fib i))
)
(terpri) ; prints a new line

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
        (1  (unique-words "infile.data" "outfile2.data")
            (options))
        (2  (print-q2-header)
            (reverse-list '(1))
            (reverse-list '(1 2 3))
            (reverse-list '(1 (2 4 6) 3))
            (options))
        (3  (word_count "text.data")
            (options))
        (4  (print-q4-header)
            (power-set '(1))
            (power-set '(1 2 3))
            (power-set '(1 2 3 (4)))
            (options))
        (5  (print "Test intercalate")
            (print "--------------------")
            (print "print (intercalate '(1) '(3))")
            (print (intercalate '(1) '(3)))
            (terpri)
            (print "print (intercalate '(1 2) '(3 4))")
            (print (intercalate '(1 2) '(3 4)))
            (terpri)
            (print "print (intercalate '(1 3 5) '(2 4 6))")
            (print (intercalate '(1 3 5) '(2 4 6)))
            (terpri)
            (print "print (intercalate '(1 3 5) '(2))")
            (print (intercalate '(1 3 5) '(2)))
            (terpri)
            (options))
        (6  (quit))
        (otherwise (options))))
)

;; Function Definintons
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun unique-words (infile outfile)
    (print "Test unique-words")
    (print "-----------------")
    (terpri)
    (format t "(unique-words ~A ~A)~%" infile outfile)
    (let ((words nil)) 
        ; open input file
        (with-open-file (in infile :direction :input)
            ; open output file
            (with-open-file (out outfile :direction :output :if-exists :supersede)
                ; loop over every word (wont work if commas!)
                (loop for word = (read in nil nil)
                    while word do
                    (if (not (member word words))
                        (setq words (cons word words)))) ; append word if not in
                    ; (format out "~a~%" word))
                (dolist (word words)    ; write them all to outfile when done
                    (format out "~a~%" word))
            )
        )
    )
    (terpri)
    ; (options)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; helper to how i wanted to write the function
(defun reverse-list (list1)
    (format t "(reverse-list ~a)~%" list1)
    (let ((r-lst nil)) 
        (princ (rev-list2 list1 r-lst))
    )
    (terpri)
    ; (options)
)

;
(defun rev-list2 (lst r-lst)
    ; check if last element, return func with last element appended
    (cond ((null (cdr lst)) (cons (car lst) r-lst))
            ; otherwise recursively call with smaller lst while 
            ; appending to r-lst
            (t (rev-list2 (cdr lst) (cons (car lst) r-lst)))
    )
)

; prints the header 
(defun print-q2-header ()
    (print "Test Recursive Reverse:")
  (print "-----------------------"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun word_count (infile)
    (print "Test word_count:")
    (print "-----------------------")
    (terpri)
    (let ((htable (make-hash-table :test #'equal))
          (sorted_list ())
          (cleanline ())
          (subs ()))
        (with-open-file (in infile :direction :input)
            (loop for line = (read-line in nil)
                while line do
                (setq cleanline (remove-special-chars line))
                ; (print *cleanline*)
                (setq subs (remove-estring (split-line-by-spaces cleanline)))
                ; (print *subs*)
                (dolist (word subs)
                    (let ((count (gethash word htable 0)))
                        (setf (gethash word htable) (+ 1 count))
                    )
                )
            )
        )
        (setq sorted_list (sort-hash-table htable))
        (loop for (key . value) in sorted_list
            for index from 0
            ; when (>= index 1) ; Skip the first iteration
            below 11
            do (if (>= index 1)
                (format t "~a: ~d~%" key value)))


    )
    (terpri)
    ; (options)
)

(defun sort-hash-table (hash-table)
  (let ((sorted-list ()))
    (maphash (lambda (key value)
               (push (cons key value) sorted-list))
             hash-table)
    (sort sorted-list #'> :key #'cdr)))

(defun split-line-by-spaces (line)
  (loop with result = '()
        for start = 0 then (1+ end)
        for end = (position #\Space line :start start)
        while end
        do (push (subseq line start end) result)
        finally (return (nreverse (push (subseq line start) result)))))

(defun remove-special-chars (word)
    ; (format t "~a~%" word)
    ; (setf word (remove-apos word))
    ; (setf word (remove-comma word))
    (remove-comma (remove-apos (remove-dash (remove-dquotes (remove-squotes (remove-amp word))))
)))

(defun remove-apos (word)
    ; (format t "~a~%" word)
    (delete #\' word)
)

(defun remove-comma (word)
    ; (print word)
    (delete #\, word)
)

(defun remove-dash (word)
    ; (print word)
    (delete #\- word)
)

(defun remove-dquotes (word)
    ; (print word)
    (delete #\u201D (delete #\" word))
)

(defun remove-squotes (word)
    ; (print word)
    (delete #\' word)
)

(defun remove-estring (lst)
    ; (print "in estring")
    (delete "" lst :test #'equal)
)

(defun remove-amp (word)
    (delete #\& word)
)

;; Problem 4
(defun power-set (list1)
    (terpri)
    (format t "(print (power-set ~a))~%" list1)
    (princ (power-set2 list1))
    (terpri)
    ; (options)
)

(defun power-set2 (list1)
    ; (print "Code for problem 4 goes here")
    (cond ((null list1) (list nil)) ; return nil if reaching the base case
            ; otherwise, recursively call on the cdr of the list
            (t (let ((cdr-list (power-set2 (cdr list1))))
                ; combine subsets using mapcar
                (append cdr-list (mapcar (lambda (sub) (cons (car list1) sub)) cdr-list)))))
)

(defun print-q4-header ()
    (print "Test Recursive Power of a Set:")
  (print   "------------------------------"))



;; Problem 5
(defun print-q5-header ()
    (print "Test Recursive Power of a Set:")
  (print   "------------------------------"))

; helper function so that i can easily check if they were the right size
(defun intercalate (list1 list2)
    ; (format t "(print (intercalate ~a ~a))~%" list1 list2)
    (cond ((not (eq (length list1) (length list2)))
                "Lists must have the same length, please try again!")
            (t  
                (intercalate2 list1 list2 '()))))


(defun intercalate2 (list1 list2 concat)
    (cond ; if only 1 item in list, return a list with list1 then list2 appended
        ((null (cdr list1)) (cons (car list1) (cons (car list2) concat)))
        ; else build the 2 and tack on the rest
        (t 
            (intercalate2 (butlast list1) (butlast list2) (append (last list1) (append (last list2) concat))))))
            ; (intercalate2 (cdr list1) (cdr list2) (cons (car list1) (cons (car list2) concat))))))



;; Call menu here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(options)
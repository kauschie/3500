;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Michael Kausch
;; CMPS 3500  - Final Exam
;; 05/17/2023
;; description: Final Exam Questions executed
;;              using a menu driven main written in common-lisp using sbcl
;; odin username: mkausch
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
        (1  (unique-words "infile.data" "outfile.data")
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Function Definintons
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
                ; loop over every word 
                ; note to future mike: reading by each word
                ;                 will not work if there are commas in the file.
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; helper for tail recursive function call
(defun reverse-list (list1)
    (format t "(reverse-list ~a)~%" list1)
    (let ((r-lst nil)) 
        (princ (rev-list2 list1 r-lst))
    )
    (terpri)
    ; (options)
)

; tail-recursive reverse function
; recursively calls itself while pre-pending the first value of list to r-list
(defun rev-list2 (lst r-lst)
    ; check if last element, return from func with last element appended
    (cond ((null (cdr lst)) (cons (car lst) r-lst))
            ; otherwise recursively call with smaller lst while 
            ; appending to r-lst
            (t (rev-list2 (cdr lst) (cons (car lst) r-lst)))
    )
)

; prints the header for q2 (cleaner menu)
(defun print-q2-header ()
    (print "Test Recursive Reverse:")
  (print "-----------------------")
  (terpri)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; creates a sorted frequency distribution of words from a file by:
;   (1) reading file contents of infile line-by-line
;   (2) cleaning the line of all specified punctuation in remove-symbols
;   (3) splitting the words of the line into a list
;   (4) using a hashtable to accumulate the frequency of each word
;   (5) dumping the hash's k/v pairs to a sorted list of tuples with sort-hash-table
;   (6) printing out the top 10 words

(defun word_count (infile)
    (print "Test word_count:")
    (print "-----------------------")
    (terpri)


    (let ((htable (make-hash-table :test #'equal)); make hash table
          (sorted_list ()) ; holds sorted values
          (cleanline ()) ; holds cleaned version of line
          (subs ()))    ; holds list of words from line
        (with-open-file (in infile :direction :input)
            (loop for line = (read-line in nil) ; 
                while line do
                ; clean the line of *most* special chars
                ; removes both ascii and some unicode characters in the file
                ; this will result in empty strings so those need to be removed
                (setq cleanline (remove-symbols line))
                (setq subs (remove-estring (split-line cleanline)))
                
                ; loop through all words on a line
                ; equivalent to python's gets method
                (dolist (word subs)
                    (let ((count (gethash (string-upcase word) htable 0)))
                        (setf (gethash (string-upcase word) htable) (+ 1 count))
                    )
                )
            )
        )

        (setq sorted_list (sort-hash-table htable))
        (loop for (key . value) in sorted_list
            ; Skip the first iteration bc there's empty strings 
            for index from 0
            below 11
            do (if (>= index 1)
                (format t "~a: ~d~%" key value)))


        ; debug to print out all key:value pairs when looking for punctuation
        ; (maphash (lambda (key value) (format t "~a: ~a~%" key value)) htable)

    )
    (terpri)
    ; (options)
)

; sorts a hashtable by the value in the key : value pair
; uses maphash to operate on the hashtable and apply a lambda to all k/v pairs 
; pushes tuples of kv's into a sorted-list
; ==> returns the sorted list
(defun sort-hash-table (hash-table)
  (let ((sorted-list ()))
    (maphash (lambda (key value)
               (push (cons key value) sorted-list))
             hash-table)
    ; call native sort func to sort by a key (the values)
    (sort sorted-list #'> :key #'cdr)))

; There's a lot of comments on this one because I'm leaving myself
; notes so that I remember what this does in the future
; This took a while to figure this out and i'll probably need this
; if i every have to code in lisp again
(defun split-line (line)
  (loop with result = '()
        ; start at zero then after each iteration go to the index of end+1
        for start = 0 then (+ 1 end)
        ; the end position is going to be where the spaces are
        for end = (position #\Space line :start start)
        ; loop until end is nil
        while end
        ; grab substring from line and put in result
        do (push (subseq line start end) result)
        ; push the rest of the string on, reverse/return it
        finally (return (nreverse (push (subseq line start) result)))))


; parses string and removes any chars that are included in the 
; list of special characters 
(defun remove-symbols (word)
; unicode: left single quote, double quotes, long hypen, grave/acute accent
;       leaves the apostrophe that the text uses
    (let ((sp-chars '(#\, #\. #\; #\& #\' #\- #\" #\: #\! #\? 
                            #\u201C #\u201D #\u2014 #\u2018 #\u0060 #\u00B4)))
    
    (loop for char across word
          ; filter out special characters in the above list
          unless (member char sp-chars)

          ; add char to the newly cleaned word
          collect char into cleanword

          ; after iterating through the list, return  the string
          ; need to first  coerce the list to a string
          finally (return (coerce cleanword 'string))))
)

; function to delete empty strings from a list 
(defun remove-estring (lst)
    ; (print "in estring")
    (delete "" lst :test #'equal)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; question 4 header for cleaner menu
(defun print-q4-header ()
    (print "Test Recursive Power of a Set:")
  (print   "------------------------------"))

; used as a helper to make printing cleaner
(defun power-set (list1)
    (terpri)
    (format t "(print (power-set ~a))~%" list1)
    (princ (power-set2 list1))
    (terpri)
    ; (options)
)

; recursively calls until base case
; climbs back up and at each level will append subsets to create powerset
(defun power-set2 (list1)
    (cond ((null list1) (list nil)) ; return nil if reaching the base case
            ; otherwise, recursively call on the cdr of the list
            (t (let ((cdr-list (power-set2 (cdr list1))))
                ; combine subsets using mapcar
                (append cdr-list (mapcar (lambda (sub) (cons (car list1) sub)) cdr-list)))))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; question 5 header for cleaner menu
(defun print-q5-header ()
    (print "Test Recursive Power of a Set:")
  (print   "------------------------------"))

; helper function so that i can easily check if they were the right size
(defun intercalate (list1 list2)
    (cond ((not (eq (length list1) (length list2)))
                "Lists must have the same length, please try again!")
            (t  
                (intercalate2 list1 list2 '()))))

; continuously adds last of list and list2 to the concatonated list
; so that it cons's them from back to fron which makes it stable
; as it recursively calls the function
; returns concat at the bottom of the list
; wanted to make it tail-recursive
(defun intercalate2 (list1 list2 concat)
    (cond ; if only 1 item in list, return the final list with list1 then list2 appended
        ((null (cdr list1)) (cons (car list1) (cons (car list2) concat)))
        (t 
            (intercalate2 (butlast list1) (butlast list2) (append (last list1) (append (last list2) concat))))))
            ; (intercalate2 (cdr list1) (cdr list2) (cons (car list1) (cons (car list2) concat))))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Call menu here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(options)
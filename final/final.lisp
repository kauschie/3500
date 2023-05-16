;Michael Kausch
;CMPS 3500 Final
;5/15/23

(defun collect-numbers (s-exp)
  ;"check if null list."
  (cond ((null s-exp) 
            nil)
        ;"check if integer"
        ((integerp s-exp) 
            (list s-exp))
        ;"continue parsing"
        ((atom s-exp) 
            nil)
        (t 
            (mapcan #'collect-numbers s-exp))))

(defun permlist (list1)
    ;if empty return nothing
    (cond ((null list1) nil)
        ; if one integer return as a list
        ((null (cdr list1)) (list list1))
        (t 
            ;iterate over all vals in list
            (loop for val in list1
                ; make a new list by consing the permutation with the val
                append (mapcar (lambda (perm) (cons val perm)) 
                        (permlist (remove val list1)))))))


(defun sublen (list1)
    (getMaxLength list1 0 -1)
)

(defun getMaxLength (list1 current_length current_max)
    ;init biggest tree to 0
    (let ((biggest_tree current_max)) 
        ; if empty ret 0
        (cond ((null list1) (max current_length current_max))
            ; if just 1 atom return 1
            ((atom list1) (max (+ 1 current_length) current_max))
            ; if next list item is an atom add 1 to current max
            ((atom (car list1)) 
                (getMaxLength (cdr list1) (+ 1 current_length) (max (+ 1 current_length) current_max)))
            ; if car is another list, recursively call and compar size to biggest tree
            ((listp (car list1))
                ; set subt to size
                (let ((subt (getMaxLength (car list1) 0 current_max)))
                    (setq biggest_tree (max subt biggest_tree)))
                ; recursively call looking at next element
                (getMaxLength (cdr list1) (+ 1 current_length) biggest_tree)))))


; helper function so that i can easily check if they were the right size
(defun intercalate (list1 list2)
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


(print "Test collect-numbers")
(print "--------------------")
(print "Print (collect-numbers 1)")
(print (collect-numbers 1))
(terpri)
(print "Print (collect-numbers 'a)")
(print (collect-numbers 'a))
(terpri)
(print "Print (collect-numbers '(1 (b (2 c) ((3)))))")
(print (collect-numbers '(1 (b (2 c) ((3))))))
(terpri)

(print "Test permlist")
(print "--------------------")
(print "Print (permlist '(1 2))")
(terpri)
(princ (permlist '(1 2)))
(terpri)
(print "Print (permlist '(a b c))")
(terpri)
(princ (permlist '(a b c)))
(terpri)

(print "Test sublen")
(print "--------------------")
(print "Print (sublen '(1 2))")
(print (sublen '(1 2)))
(terpri)
(print "Print (sublen '(a (b c) c (a b c d)))")
(print (sublen '(a (b c) c (a b c d))))
(terpri)
(print "Print (sublen '(a (a b) (a b c) (a b c (d e) f)))")
(print (sublen '(a (a b) (a b c) (a b c (d e) f))))
(terpri)

(print "Test sublen")
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
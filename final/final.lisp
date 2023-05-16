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
        ((atom list1) (list list1))
        (t 
            ;iterate over all vals in list
            (loop for val in list1
                ; make a new list by consing the permutation with the val
                append (mapcar (lambda (perm) (cons val perm)) 
                        (permlist (remove val list1)))))))


(print "Test collect-numbers")
(terpri)
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
(let ((perms (permlist '(1 2))))
  (dolist (perm perms)
    (format t "~a~%" perm)))


(print "Print (permlist '(a b c))")
(princ (permlist '(1 2)))



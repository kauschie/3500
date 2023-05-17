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
    (remove-comma (remove-apos (remove-dash (remove-dquotes (remove-squotes word)))
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
    (delete #\" word)
)

(defun remove-squotes (word)
    ; (print word)
    (delete #\' word)
)

(defun remove-estring (lst)
    ; (print "in estring")
    (delete "" lst :test #'equal)
)



(with-open-file (in "test2.data" :direction :input)
  (loop for line = (read-line in nil)
        while line do
        (defparameter *cleanline* (remove-special-chars line))
        ; (print *cleanline*)
        (defparameter *subs* (remove-estring (split-line-by-spaces *cleanline*)))
        (print *subs*)
        (terpri)))


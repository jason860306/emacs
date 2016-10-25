(% (* #x15 (+ 8.2 (lsh 7 3))) 2)
?a
? 
?\\
#b10101111000011
#o377
#x15
most-positive-fixnum
most-negative-fixnum
t
nil
""
()
0
'false
[-2 0 2 4 6 8 10]
["no" "sir" "i" "am" "a" "horse"]
["hi" 22 120 89.6 2748 [3 "a"]]
(quote (1 2 3))
'(1 2 3)
(list 1 (+ 1 1) 3)
`(1 ,(+ 1 1) 3)
'( (apple . "red")
   (banana . "yellow")
   (orange . "orange") )
(= 2 (+ 1 1))
(/= 2 3)
(setq foo 2)
(eq 'foo 2)
(equal '(1 2 (3 4)) (list 1 2 (list 3 (* 2 2))))
(concat "foo" "bar" "baz")
(string= "foo" "baz")
(= "foo" "bar")
(equal "foo" "bar")
(substring "foobar" 0 3)
(upcase "foobar")
(if (>= 3 2)
    (message "hello there"))
(if nil
    (message "yay, friday")
    (message "boo, other day"))
(if nil
    (progn (message "yay, friday")
    (message "not friday!")
    (message "non-friday-stuff"))
    (message "more-non-friday-stuff"))
(if 'sunday
    (message "sunday!")
    (if 'saturday
    	(message "saturday!")
    (message ("weekday!"))))
(when (> 5 1)
      (message "5 > 1")
      (message "5 < 6"))
(unless (weekend-p)
	(message "anothrer day at work")
	(get-back-to-work))
(cond
	((equal value "foo")
	(message "got foo")
	(+ 2 2))
	((equal value "bar")
	nil)
	(t 'hello))

(require 'cl-lib)
(case 12
      (5 "five")
      (1 "one")
      (12 "twelve")
      (otherwise
      "I only know five, one and twelve."))
(setq x 10
      total 0)
(while (plusp x)
       (incf total x)
       (decf x))
(setq x 0 total 0)
(while (< x 100)
       (catch 'continue
       	      (incf x)
	      (if (zerop (% x 5))
	      	  (throw 'continue nil))
		(incf total x)))
(require 'cl-lib)
(loop do
      (setq x (1+ x))
      while
      (< x 10))
(loop for i in '(1 2 3 4 5 6)
      collect (* i i))
(defun square (x)
       "Return X squared."
       (* x x))
(defun hello ()
       "Print the string `hello' to the minibuffer."
       (message "hello!"))
(square 3)
(hello)
(defun foo ()
       (let ((x 6))
       (bar)
       x))
(defun bar ()
       (setq x 7))
(foo)

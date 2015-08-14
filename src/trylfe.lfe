(defmodule trylfe
  (export all))

(defun my-adder (x y)
  (+ x (+ y 1)))

(defun out (arg-data)
  "This is called by YAWS when the requested URL matches the URL specified in
  the YAWS config (see ./etc/yaws.conf) with the 'appmods' directive for the
  virtual host in question.

  In particular, this function is intended to handle all traffic for this
  app."
  (lfest:out-helper arg-data #'trylfe-routes:routes/3))

(defmodule trylfe-util
  (export all))

(defun get-version ()
  (lutil:get-app-version 'trylfe))

(defun get-versions ()
  (++ (lutil:get-versions)
      `(#(trylfe ,(get-version)))))

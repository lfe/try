(defmodule try.lfe.io-util
  (export all))

(defun get-version ()
  (lutil:get-app-version 'try.lfe.io))

(defun get-versions ()
  (++ (lutil:get-versions)
      `(#(try.lfe.io ,(get-version)))))

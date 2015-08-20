(defmodule trylfe-content
  (export all))

(include-lib "deps/exemplar/include/html-macros.lfe")

(defun base-page (title remaining)
  "A function to provide the base for all pages."
  (list
    (!doctype 'html)
    (html '(lang "en")
      (list
        (head
          (list
            (title title)
            (link '(rel "stylesheet" href "/css/bootstrap-min.css"))
            (link '(rel "stylesheet" href "/css/bootstrap-slate-min.css"))
            (link '(rel "stylesheet" href "/css/styles.css"))
            (link '(rel "stylesheet" href "/css/console.css"))
            (script '(src "/js/jquery.js"))
            (script '(src "/js/jquery-console.js"))
            (script '(src "/js/bootstrap-min.js"))
            (script '(src "/js/trylfe.js"))))
        (body
          (main
            (list
              (trylfe-nav:get-navbar)
              (div '(class "section")
                (div '(class "container")
                  (list
                    (div '(class "row well")
                         remaining)
                    (div '(id "changer") (start))
                    (div '(id "footer")
                      (trylfe-nav:get-footer-nav))))))))))))

(defun console-page ()
  (base-page
    "LFE Console"
    (div '(id "console" class "lfe-console"))))

(defun get-content (_)
  "2-arity content API.

  This function generates its HTML from scratch."
    (lfest-html-resp:ok
      (console-page)))

(defun start ()
  (list
    (p '(class "bottom")
       "Welcome to LFE!")
    (p '(class "bottom")
       (++ "You can see an LFE interpreter above - we call it a "
           (em "REPL") ". It's not actually a " (em "real")
           " LFE REPL -- it's a JavaScript wrapper for a real one. "
           "Which is good enough for trying things out in a "
           "web page :-)"))
    (p '(class "bottom")
       (++ "Type "
           (code "next")
           " in the REPL to begin."))))

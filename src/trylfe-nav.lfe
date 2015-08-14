(defmodule trylfe-nav
  (export all))

(include-lib "deps/exemplar/include/html-macros.lfe")

(defun get-side-menu ()
  (list
    (li (a '(href "http://docs.lfe.io/") "Docs"))
    (li (a '(href "http://blog.lfe.io/") "Blog"))
    (li (a '(href "http://docs.lfe.io/community.html") "Community"))
    (li (a '(href "http://lfe.io/") "Main Site"))
    (li (a '(href "http://help.exercism.io/getting-started-with-lfe.html") "Exercism.io"))
    (li (a '(href "http://rosettacode.org/wiki/LFE") "Rosetta Code"))))

(defun get-navbar()
  (nav '(class "navbar navbar-top" role "navigation" id "header-wrapper")
    (div '(id "header")
      (div '(class "container")
        (list
          (div
            (a '(class "logo" href "/")
               "Try LFE"))
          (div '(class "navbar-header")
            (div '(class "collapse navbar-collapse navbar-ex1-collapse")
              (ul '(class "nav navbar-nav navbar-right")
                (get-side-menu)))))))))


(defun get-footer-nav ()
  (list
    (div '(class "lower-footer")
      (list
        (ul '(class "footer-cell")
          (list
            (li (a '(href "https://www.gitbook.com/@lfe") "Books"))
            (li (a '(href "http://docs.lfe.io/presentations.html") "Presentations"))
            (li (a '(href "http://docs.lfe.io/history.html") "History"))
            (li (a '(href "https://github.com/lfex/") "LFE Exchange"))))
        (span '(class "footer-cell")
          (a '(href "http://lfe.io/")
            (img '(src "/images/tiny-grey-lfe-logo.png"))))
        (ul '(class "footer-cell")
          (list
            (li (a '(href "https://github.com/lfex/try.lfe.io/issues") "Issues"))
            (li (a '(href "http://docs.lfe.io/contributing.html") "Contributing"))
            (li (a '(href "http://blog.lfe.io/") "Blog"))
            (li (a '(href "http://twitter.com/ErlangLisp") "Twitter"))))))
    (div '(class "wrapper")
      (p "LFE Design & Content &copy; 2015 LFEuminati | Alien Alliance"))))
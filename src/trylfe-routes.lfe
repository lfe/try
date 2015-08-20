(defmodule trylfe-routes
  (export all))

(include-lib "exemplar/include/html-macros.lfe")
(include-lib "lfest/include/lfest-macros.lfe")

(defroutes
  ('GET "/"
    (trylfe-content:get-content arg-data))
  ('GET "/eval"
    (trylfe-rest:eval-lfe arg-data))
  ('NOTFOUND
   (let* ((joined-path (++ "/" (string:join path "/")))
          (msg (++ "Unmatched route!~n~n"
                   "Path-info: ~p~n"
                   "joined path: ~p~n"
                   "arg-data: ~p~n~n"))
          (msg-args `(,path ,joined-path ,arg-data)))
    (io:format msg msg-args)
    (trylfe-content:four-oh-four
      (++ (strong "Unmatched Route: ") joined-path)))))


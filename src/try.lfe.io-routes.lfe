(defmodule try.lfe.io-routes
  (export all))

(include-file "deps/exemplar/include/html-macros.lfe")
(include-file "deps/lfest/include/macros.lfe")

(defroutes
  ('GET "/"
    (try.lfe.io-content:get-sidebar-content arg-data))
  ('GET "/content/:id"
    (try.lfe.io-content:get-content id arg-data))
  ('GET "/relation/:userid/:accountid"
    (try.lfe.io-content:get-content userid accountid arg-data))
  ;; When nothing matches, do this
  ('NOTFOUND
   (let* ((joined-path (++ "/" (string:join path "/")))
          (msg (++ "Unmatched route!~n~n"
                   "Path-info: ~p~n"
                   "joined path: ~p~n"
                   "arg-data: ~p~n~n"))
          (msg-args `(,path ,joined-path ,arg-data)))
    (io:format msg msg-args)
    (try.lfe.io-content:four-oh-four
      (++ (strong "Unmatched Route: ") joined-path)))))


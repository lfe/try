(defmodule trylfe-rest
  (export (eval-lfe 1)))


(defun eval-lfe (arg-data)
  (let* ((query (yaws_api:parse_query arg-data))
         (expr (element 2 (lists:keyfind "expr" 1 query)))
         (`#(,result ,state) (lfe_shell:run_string expr '()))
         (str-result (lists:flatten (lfe_io:fwrite1 "~p~n" `(,result))))
         (json (ljson:encode `#(result ,(list_to_binary str-result)))))
    ;; XXX DEBUG
    (lfe_io:format "Got result: ~p~n" (list result))
    (lfe_io:format "Got string result: ~p~n" (list str-result))
    (io:format "Got json ~p~n" (list json))
    ;; XXX END DEBUG
    (lfest-resp:content "application/json" json)))

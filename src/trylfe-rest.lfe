(defmodule trylfe-rest
  (export (eval-lfe 1)))


(defun eval-lfe (arg-data)
  (let* ((query (yaws_api:parse_query arg-data))
         (expr (element 2 (lists:keyfind "expr" 1 query)))
         (`#(,result ,state) (lfe_shell:run_string expr '()))
         (json (ljson:encode `#(result ,result))))
    ;; XXX DEBUG
    (lfe_io:format "Got result: ~p~n" (list result))
    (io:format "Got json ~p~n" (list json))
    ;; XXX END DEBUG
    (lfest-resp:content "application/json" json)))

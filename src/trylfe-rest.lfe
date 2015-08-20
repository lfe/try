(defmodule trylfe-rest
  (export (eval-lfe 1)))

(include-lib "clj/include/compose.lfe")
(include-lib "yaws/include/yaws_api.hrl")

(defun eval-lfe (arg-data)
  (let* ((`#(,result ,state) (execute (get-expr arg-data)))
         (str-result (lists:flatten (lfe_io:fwrite1 "~p~n" `(,result))))
         (json (ljson:encode `#(result ,(list_to_binary str-result)))))
    ;; XXX DEBUG
    (lfe_io:format "Got client ip: ~p~n" (list (get-client-ip arg-data)))
    (lfe_io:format "Got result: ~p~n" (list result))
    (lfe_io:format "Got string result: ~p~n" (list str-result))
    (io:format "Got json ~p~n" (list json))
    ;; XXX END DEBUG
    (lfest-resp:content "application/json" json)))

(defun get-expr (arg-data)
  (lfe_io:format "Got arg-data: ~p~n" (list arg-data))
  (->> arg-data
       (yaws_api:parse_query)
       (lists:keyfind "expr" 1)
       (element 2)))

(defun execute (expr)
  ;; XXX get state from somewhere
  ;;     -- if undefined, use lfe_shell:run_string/2
  ;;     -- else, use the state in lfe_shell:run_string/3
  ;; XXX execute and get result + updated state
  ;; XXX extract env from state
  ;; XXX save env somewhere
  ;; XXX return value
  (lfe_io:format "Got expression: ~p~n" (list expr))
  (lfe_shell:run_string expr '()))

(defun get-client-ip (arg-data)
  (->> arg-data
       (arg-client_ip_port)
       (element 1)
       (tuple_to_list)
       (lists:map #'integer_to_list/1)
       (dot-join)))

(defun dot-join (strs)
  (string:join strs "."))


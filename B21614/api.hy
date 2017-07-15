

(defmacro B21614/API []
  (import [B21614.commands [*commands*]]
          [B21614.dsl [make-api-function]])
  (list (map (fn [(, function command)] (make-api-function function command)) *commands*)))


(B21614/API)

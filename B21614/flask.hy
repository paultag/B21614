(import json serial [flask [Flask request make-response]])

(setv app (Flask --name--))

(setv serial-line (serial.Serial  ; 115200 8N1
                      :port     "/dev/ttyUSB0"
                      :timeout  2
                      :bytesize serial.EIGHTBITS
                      :parity   serial.PARITY_NONE
                      :stopbits serial.STOPBITS_ONE
                      :baudrate 9600))



(defmacro defroute [name &rest methods]
  (import os.path)
  (defn generate-method [path method]
    `(with-decorator (app.route ~path) (fn []
       (import [B21614.api [~method]])
       (try (do (setv ret (~method serial-line))
                (json.dumps ret))
       (except [e ValueError]
          (setv response (make-response (.format "Fatal Error: ValueError: {}" (str e))))
          (setv response.status-code 500)
          response)))))

  (setv path (.format "/{}" name))
  (print path)

  (setv actions (dict methods))
  `(do ~@(list-comp (generate-method (os.path.join path method-path) method)
                    [(, method-path method) methods])))


(defroute source
  ("hdmi1" set-hdmi1)
  ("hdmi2" set-hdmi2)
  ("hdmi3" set-hdmi3)
  ("hdmi4" set-hdmi4))

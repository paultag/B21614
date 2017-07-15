(defn make-api-function [function command]
  `(defn ~function [serial] (serial.write (.encode ~command))))

(setf *allow-external-connections* t)

(defun run-node-env ()
  (let ((home (sb-ext:posix-getenv "HOME")))
    (run-program "/bin/sh" (list (concatenate 'string home "/actr7.x/run-node.sh")) :wait nil) ;; :output *standard-output* for debugging
  ))

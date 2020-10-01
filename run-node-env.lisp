(defun run-node-env ()
  (run-program "/bin/sh" '("/ACT-R/run-node.sh") :wait nil) ;; :output *standard-output* for debugging
  )
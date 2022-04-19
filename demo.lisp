(ql:quickload :cl-isl)
(in-package #:cl-isl)



(let* ((a (basic_set-read-from-str "{[i] : exists (a : i = 2a and i >= 10 and i <= 42)}"))
       (emp (create-empty-basic_set))
       )
  (print (empty-basic_set-p emp))
  (print (empty-basic_set-p a))
  (print (obj a))
  (assert (empty-basic_set-p emp))
  (assert (not (empty-basic_set-p a)))
  )




(print "---------------")



(when nil

  ;; Doesn't work with garbage collection -- need to fix errors so that memory is not free on a null pointer
  (let ((b (basic_set-read-from-str "vehvh")))
    (print "ok"))

  (let* ((b (isl_basic_set_read_from_str
             *context*
             "{[i] : exists (a : i = 2a and i >= 10 and i <= 42)}")))
    (print (isl_basic_set_to_str b)))

  (isl_basic_set_read_from_str *context* "error")
  (isl_basic_set_read_from_str *context* "{[i] : exists (a : i = 2a and i >= 10 and i <= 42)}")

  (let* ((map (isl_union_map_read_from_str
               *context*
               "[N] -> { S0[i] -> [i, 0] : 0 <= i < N; S1[i] -> [i, 1] : 0 <= i < N }"))
         (ast-build (isl_ast_build_from_context (isl_set_read_from_str *context* "[N] -> { : }")))
         (ast (isl_ast_build_node_from_schedule_map ast-build map))
         )
    (print (isl_ast_node_to_C_str ast)))

)







(let ((t1 "{TAB[I] -> [I,1] : 0 <= I < 100;T2[I] -> [I,2] : 0 <= I < 100;}")
      (t2 "{TAB[I,J] -> [I,2,J,3] : 0 <= I < 100 and 0 <= J < 100;}")
      (t3 "{TAB[I,J] -> [I,3,J,4] : 0 <= I < 100 and 0 <= J < 100;}")
      (t4 "{C[I,J] -> [I,4,J,5] : 0 <= I < 100 and 0 <= J < 100;C1[I,J] -> [I,4,J,5,K,6] : 0 <= I < 100 and 0 <= J < 100 and 0 <= K < 100;C2[I,J] -> [I,4,J,5,K,7] : 0 <= I < 100 and 0 <= J < 100 and 0 <= K < 100;A[I,K] -> [I,4,J,5,K,8] : 0 <= I < 100 and 0 <= J < 100 and 0 <= K < 100;B[K,J] -> [I,4,J,5,K,9] : 0 <= I < 100 and 0 <= J < 100 and 0 <= K < 100;}")
      (t5 "[N] -> { S0[i] -> [i, 0] : 0 <= i < N; S1[i] -> [i, 1] : 0 <= i < N }")
      )

  (let ((s t4))
    (print s)
    (let* ((map (union_map-read-from-str s))
           (ast-build (ast_build-from-context (set-read-from-str "[N] -> { : }")))
           (ast-node (ast_build-from-node-from-schedule-map ast-build map))
           )
      (print (ast_node-to-C-str ast-node))))

)

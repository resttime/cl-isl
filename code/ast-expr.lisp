(in-package #:cl-isl)

(define-isl-object ast-expr
  :free %isl-ast-expr-free
  :copy %isl-ast-expr-copy
  :abstract t)

(define-isl-object op-expr
  :superclass ast-expr
  :abstract t)

(define-isl-object id-expr
  :superclass ast-expr)

(define-isl-object int-expr
  :superclass ast-expr)

(defun %make-ast-expr (handle)
  (ecase (%isl-ast-expr-get-type handle)
    (:isl-ast-expr-error (isl-error))
    (:isl-ast-expr-op (%make-op-expr handle))
    (:isl-ast-expr-id (%make-id-expr handle))
    (:isl-ast-expr-int (%make-int-expr handle))))

(define-isl-object op-and
  :superclass op-expr)

(define-isl-object op-and-then
  :superclass op-expr)

(define-isl-object op-or
  :superclass op-expr)

(define-isl-object op-or-else
  :superclass op-expr)

(define-isl-object op-le
  :superclass op-expr)

(define-isl-object op-call
  :superclass op-expr)

(define-isl-object op-add
  :superclass op-expr)

(define-isl-object op-mul
  :superclass op-expr)


(defun %make-op-expr (handle)
  (ecase (%isl-ast-expr-op-get-type handle)
    (:isl-ast-expr-op-error (isl-error))
    (:isl-ast-expr-op-and (%make-op-and handle))
    (:isl-ast-expr-op-and-then (%make-op-and-then handle))
    (:isl-ast-expr-op-or (%make-op-or handle))
    (:isl-ast-expr-op-or-else (%make-op-or-else handle))
    (:isl-ast-expr-op-le (%make-op-le handle))
    (:isl-ast-expr-op-call (%make-op-call handle))
    (:isl-ast-expr-op-add (%make-op-add handle))
    (:isl-ast-expr-op-mul (%make-op-mul handle))
    ;; TODO
    ))

(defmethod print-object ((ast-expr ast-expr) stream)
  (print-unreadable-object (ast-expr stream :type t)
    (write-string (%isl-ast-expr-to-str (ast-expr-handle ast-expr)) stream)))

;; Expr op

(define-isl-function op-expr-get-n-arg %isl-ast-expr-op-get-n-arg
  (:give (unsigned-byte 32)) ;int
  (:keep ast-expr))

(define-isl-function op-expr-get-op-arg %isl-ast-expr-get-op-arg
  (:give ast-expr)
  (:keep ast-expr)
  (:keep (unsigned-byte 32)))

;;Returns a list of every son of the ast.
(defun op-expr-get-list-args (ast)
  ;; assert type ast-exp op
  (let ((n (op-expr-get-n-arg ast)))
    (loop for i below n do
      (op-expr-get-op-arg ast i))))


;; ID

(define-isl-function id-expr-get-id %isl-ast-expr-get-id
  (:give identifier)
  (:keep id-expr))

;; INT

(define-isl-function int-expr-get-value %isl-ast-expr-get-val
  (:give value)
  (:keep int-expr))

;; Creation of ast expr
(define-isl-function ast-from-value %isl-ast-expr-from-val
  (:give ast-expr)
  (:take value))
(define-isl-function ast-from-identifier %isl-ast-expr-from-id
  (:give ast-expr)
  (:take identifier))

(define-isl-function ast-add %isl-ast-expr-add
  (:give ast-expr)
  (:take ast-expr)
  (:take ast-expr))

(define-isl-function ast-mul %isl-ast-expr-mul
  (:give ast-expr)
  (:take ast-expr)
  (:take ast-expr))

(define-isl-function ast-access %isl-ast-expr-access
  (:give ast-expr)
  (:take ast-expr)
  (:take ast-expr))

(define-isl-function ast-call %isl-ast-expr-call
  (:give ast-expr)
  (:take ast-expr)
  (:take ast-expr))


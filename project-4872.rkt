#lang racket/base

;;==========================================================================
;;===                Code generated with MrEd Designer 3.17              ===
;;===              https://github.com/Metaxal/MrEd-Designer              ===
;;==========================================================================

;;; Call (project-4872-init) with optional arguments to this module

(require
 racket/gui/base
 racket/class
 racket/list
 )

(provide project-4872-init frame-5028)

(define (label-bitmap-proc l)
  (let ((label (first l)) (image? (second l)) (file (third l)))
    (or (and image?
             (or (and file
                      (let ((bmp (make-object bitmap% file 'unknown/mask)))
                        (and (send bmp ok?) bmp)))
                 "<Bad Image>"))
        label)))

(define (list->font l)
  (with-handlers
   ((exn:fail?
     (λ (e)
       (send/apply
        the-font-list
        find-or-create-font
        (cons (first l) (rest (rest l)))))))
   (send/apply the-font-list find-or-create-font l)))

(define project-4872 #f)
(define frame-5028 #f)
(define canvas-6341 #f)
(define (project-4872-init
         #:canvas-6341-code-gen-class
         (canvas-6341-code-gen-class canvas%)
         #:canvas-6341-paint-callback
         (canvas-6341-paint-callback (λ (canvas dc) (void)))
         #:canvas-6341-min-width
         (canvas-6341-min-width 800)
         #:canvas-6341-min-height
         (canvas-6341-min-height 300))
  (set! frame-5028
    (new
     frame%
     (parent project-4872)
     (label "Frame")
     (width #f)
     (height #f)
     (x #f)
     (y #f)
     (style '())
     (enabled #t)
     (border 0)
     (spacing 0)
     (alignment (list 'center 'top))
     (min-width 70)
     (min-height 30)
     (stretchable-width #f)
     (stretchable-height #f)))
  (set! canvas-6341
    (new
     canvas-6341-code-gen-class
     (parent frame-5028)
     (style '())
     (paint-callback canvas-6341-paint-callback)
     (label "Canvas")
     (gl-config #f)
     (enabled #t)
     (vert-margin 2)
     (horiz-margin 2)
     (min-width canvas-6341-min-width)
     (min-height canvas-6341-min-height)
     (stretchable-width #f)
     (stretchable-height #f)))
  (send frame-5028 show #t))

(module+ main (project-4872-init))

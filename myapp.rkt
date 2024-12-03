#lang racket
(require "project-4872.rkt")
(require racket/gui/base)

(define bg-image (make-object bitmap% "images/main/background.jpeg" 'jpeg))
(define message-font (make-object font% 50 'roman))
(define start-game-font (make-object font% 80 'script))
(define title-large-font (make-object font% 200 'script))
(define warning-font (make-object font% 80 'script))

; 開始ボタンのCanvas座標
(define start-button-canvas-w 0)
(define start-button-canvas-h 0)
(define start-button-canvas-x 300)
(define start-button-canvas-y 250)

(define press-start? #f)
(define under-construction? #f)

; 開始ボタンの範囲内かどうかの判定
(define (in-start-button-canvas-rect? x y)
  (and (<= start-button-canvas-x x (+ start-button-canvas-x start-button-canvas-w))
       (<= start-button-canvas-y y (+ start-button-canvas-y start-button-canvas-h))))

(project-4872-init
 #:canvas-6341-code-gen-class
 (class canvas% (super-new)
   (define/override (on-event event)
     (cond
       [(eq? (send event get-event-type) 'left-down)
        (begin
          (let [
                (x (send event get-x))
                (y (send event get-y))
                ]
            (when (in-start-button-canvas-rect? x y)
              (set! press-start? #t)
              (send this refresh)
              (sleep/yield 2)
              (set! under-construction? #t)
              )
            (send this refresh)
            )
          )]
       [else (super on-event event)]
       )
     )
   )
 #:canvas-6341-paint-callback
 (lambda (canvas dc)
   (define canvas-width (send canvas get-width))
   (define canvas-height (send canvas get-height))
   (define img-width (send bg-image get-width))
   (define img-height (send bg-image get-height))

   ; 画像が指定サイズ内に表示できるようにスケールを調整
   ; ここでスケール変換しているので、Canvas内の座標は画像サイズベースになる
   (send dc set-scale
         (/ canvas-width img-width)
         (/ canvas-height img-height))
   (send dc draw-bitmap bg-image 0 0)

   ; Touch Screen
   (let [
         (color (make-object color% 165 184 209 0.8))
         (text "Touch Screen")
         (font start-game-font)
         ]
     (send dc set-font font)
     (send dc set-text-foreground color)
     (let-values [
                  ((width height _ __) (send dc get-text-extent text))
                  ]
       (send dc get-text-extent text)
       (define img-to-canvas-ratio-w (/ canvas-width img-width))
       (define img-to-canvas-ratio-h (/ canvas-height img-height))
       (define start-button-img-x (truncate (/ (- img-width width) 2)))
       (define start-button-img-y (truncate (- img-height height 10)))
       ; イベント用にCanvas座標を保存しておく
       (set! start-button-canvas-w (* img-to-canvas-ratio-w width))
       (set! start-button-canvas-h (* img-to-canvas-ratio-h height))
       (set! start-button-canvas-x (truncate (* img-to-canvas-ratio-w start-button-img-x)))
       (set! start-button-canvas-y (truncate (* img-to-canvas-ratio-h start-button-img-y)))
       (send dc draw-text text start-button-img-x start-button-img-y)
       )
     )

   (let [
         (color (make-object color% 200 200 100 1))
         (text "フ◯イト")
         (font title-large-font)
         ]
     (send dc set-font font)
     (send dc set-text-foreground color)
     (let-values [
                  ((width height _ __) (send dc get-text-extent text))
                  ]
       (send dc get-text-extent text)
       (define x (truncate (/ (- img-width width) 5)))
       (define y (truncate (/ (- img-height height) 3)))
       (send dc draw-text text x y)
       )
     )

   (let [
         (color (make-object color% 200 200 100 1))
         (text "グランドオーダー")
         (font title-large-font)
         ]
     (send dc set-font font)
     (send dc set-text-foreground color)
     (let-values [
                  ((width height _ __) (send dc get-text-extent text))
                  ]
       (send dc get-text-extent text)
       (define x (truncate (/ (- img-width width) 3)))
       (define y (truncate (/ (- img-height height) 1.5)))
       (send dc draw-text text x y)
       )
     )

   (when press-start?
     (send dc set-brush (make-object color% 0 0 0 0.6) 'solid)
     (send dc draw-rectangle 0 (- img-height (* img-height 0.1)) img-width img-height)
     (let [
           (color (make-object color% 255 255 255 1))
           (text "Connecting...")
           (font message-font)
           ]
       (send dc set-font font)
       (send dc set-text-foreground color)
       (send dc draw-text text 1400 (- img-height (* img-height 0.07)))
       )
     )
   (when under-construction?
     (send dc set-brush (make-object color% 0 0 0 1) 'solid)
     (send dc draw-rectangle 100 100 (- img-width 200) (- img-height 200))
     (let [
           (color (make-object color% 255 255 255 1))
           (text "開発中（完成予定なし）")
           (font warning-font)
           ]
       (send dc set-font font)
       (send dc set-text-foreground color)
       (send dc draw-text text 500 (- (/ img-height 2) 50))
       )
     )
   (send dc flush)
   )
 )

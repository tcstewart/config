;;; define indentation style for c/c++

(defconst my-c-style
 '("My C style"
   (c-auto-newline . nil)
   (c-indent-level . 4)
   (c-continued-statement-offset . 0)
   (c-continued-brace-offset . 0)
   (c-brace-offset . 0)
   (c-brace-imaginary-offset . 0)
   (c-argdecl-indent . 0)
;;   (c-tab-always-indent           . true)
   (c-comment-only-line-offset    . 0)
   (c-hanging-braces-alist        . ((substatement-open after)
                                     (brace-list-open)))
   (c-hanging-colons-alist        . ((member-init-intro before)
                                     (inher-intro)
                                     (case-label after)
                                     (label after)
                                     (access-label after)))
   (c-cleanup-list                . (scope-operator
                                     empty-defun-braces
                                     defun-close-semi))
   (c-offsets-alist               . ((arglist-close     . c-lineup-arglist)
                                     (case-label        . 4)
                                     (block-open        . 0)
                                     (knr-argdecl-intro . -)))
   (c-echo-semantic-information-p . t)
   )
 "C/C++ Programming Style")

;; Customizations for both c-mode and c++-mode, etc
(defun my-c-mode-common-hook ()
  ;; set up for my preferred indentation style, but  only do it once
  (let ((my-style "My C style"))
    (or (assoc my-style c-style-alist)
 (setq c-style-alist (cons my-c-style c-style-alist)))
    (c-set-style my-style))
  ;; offset customizations not in my-style
  (c-set-offset 'substatement-open     0)
  (c-set-offset 'substatement          4)
  (c-set-offset 'statement-block-intro 4)
  (c-set-offset 'statement-case-intro  4)
  (c-set-offset 'defun-block-intro     4)
  (c-set-offset 'innamespace           4)
  (c-set-offset 'inclass               4)
  (c-set-offset 'inline-open           0)
  (c-set-offset 'inline-close          0)
  (c-set-offset 'access-label          -4)
  (c-set-offset 'comment-intro         0)
  (c-set-offset 'inextern-lang         4)
  (c-set-offset 'topmost-intro         0)
  (c-set-offset 'member-init-intro     4)
  ;; (c-set-offset 'member-init-intro     (* 3 c-basic-offset))
  ;; other customizations
  (setq
   tab-width        4                 
   indent-tabs-mode nil)     ;; forces use spaces instead of tabs
  ;;  (c-toggle-auto-hungry-state 1)  ;; auto-newline and hungry-delete
  ;; this will make sure spaces are used instead of tabs
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)


;; haskell setup
(remove-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;; Just use tab-stop indentation, 2-space tabs
(add-hook 'haskell-mode-hook
          (lambda ()
            (turn-on-haskell-doc-mode)
            (turn-on-haskell-simple-indent)
            (setq indent-line-function 'tab-to-tab-stop)
            (setq tab-stop-list

                 (loop for i from 2 upto 120 by 2 collect i))
            (local-set-key (kbd "RET") 'newline-and-indent-relative)))

(defun newline-and-indent-relative ()
  (interactive)
  (newline)
  (indent-to-column (save-excursion
                      (forward-line -1)
                      (back-to-indentation)
                      (current-column))))

(global-set-key [(meta backspace)] 'backward-kill-word)

(require 'tramp)

;; el-get
(require 'el-get)

;; rust-mode
(add-to-list 'load-path "~/.emacs.d/")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(defun remove-dos-eol ()
  "Do not show ^M in files"
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

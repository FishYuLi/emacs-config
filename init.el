;; list the packages you want
(setq package-list '(multiple-cursors js2-mode column-enforce-mode json-mode yaml-mode smart-tab dakrone-theme spacegray-theme fill-column-indicator magit powerline ibuffer-git projectile ibuffer-projectile nzenburn-theme zenburn-theme ctags ctags-update ggtags helm helm-projectile helm-gtags helm-themes lua-mode cmake-mode cmake-font-lock))

;; mmm-mode mmm-mako protobuf-mode
;; list the repositories containing them
(setq package-archives '(
			 ;; ("elpa" . "http://tromey.com/elpa/")
                         ;; ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))
;; activate all the packages (in particular autoloads)
(package-initialize)
;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))
;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(set-default-font "inconsolata 12")

(add-to-list 'load-path "~/.emacs.d/google")
(add-to-list 'load-path "~/.emacs.d/protobuf")

;; helm mode
(require 'helm)
(require 'helm-config)
(require 'helm-themes)

(helm-mode 1)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t)
(define-key minibuffer-local-map (kbd "C-c C-l") 'helm-minibuffer-history)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t)

(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)
(setq
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
)

(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)

;; ;; auto-complete
;; (setq ac-delay 0.1)
;; (ac-config-default)
;; (defun ac-c-init ()
;;   (require 'auto-complete-c-headers)
;;   (add-to-list 'ac-sources 'ac-source-c-headers)
;;   ;(require 'auto-complete-clang)
;;   ;(add-to-list 'ac-sources 'ac-source-clang)
;; )
;; (add-hook 'c++-mode-hook 'ac-c-init)
;; (add-hook 'c-mode-hook 'ac-c-init)


(global-set-key (kbd "M-n") 'mc/mark-next-like-this)
(global-set-key (kbd "M-N") 'mc/mark-next-word-like-this)
;; (global-set-key (kbd "M-[") 'mc/mark-previous-word-like-this)
;; (global-set-key (kbd "C-c w") 'mc/mark-all-words-like-this)
;;
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cc\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cxx\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cuh\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.def\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.param\\'" . sh-mode))

;; (load-theme 'tango-dark)
(load-theme 'zenburn t)
;; (load-theme 'spacegray t)

(setq TeX-PDF-mode t)
;; Turn on RefTeX for AUCTeX, http://www.gnu.org/s/auctex/manual/reftex/reftex_5.html
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; Make RefTeX interact with AUCTeX, http://www.gnu.org/s/auctex/manual/reftex/AUCTeX_002dRefTeX-Interface.html
(setq reftex-plug-into-AUCTeX t)
(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.

;; remove the trailing white spaces when emacs saves a buffer
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; remove the emacs startup page
(setq inhibit-startup-message t)

;; require the google c/c++ code style
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; define cpplint function to check the code style
(defun cpplint ()
  "check source code format according to Google Style Guide"
  (interactive)
  (compilation-start (concat "python ~/.emacs.d/google/cpplint.py " (buffer-file-name))))

;; enforce the line length to be 80
;; (require 'column-enforce-mode)
;; (add-hook 'c-mode-common-hook 'column-enforce-mode)
(add-hook 'c-mode-common-hook 'fci-mode)
(setq fci-rule-column 80)
(setq fci-rule-color "brightblack")
(setq fci-rule-width 1)

;; (require 'smart-tab)
(add-hook 'c-mode-common-hook 'smart-tab-mode)
(add-hook 'lua-mode-hook 'smart-tab-mode)
(add-hook 'latex-mode-common-hook 'smart-tab-mode)
(add-hook 'python-mode-hook 'smart-tab-mode)

;; load protobuf
(require 'protobuf-mode)
(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))

;; matlab/octave mode
(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))

;; define function to shutdown emacs server instance
(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )

(global-unset-key (kbd "C-z"))

;; backup dir
(setq backup-directory-alist '(("." . "/tmp/linmin/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )

(global-set-key (kbd "S-<up>") 'windmove-up)
(global-set-key (kbd "S-<down>") 'windmove-down)
(global-set-key (kbd "S-<right>") 'windmove-right)
(global-set-key (kbd "S-<left>") 'windmove-left)

;; ibuffer mode
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;; powerline
(require 'powerline)
(powerline-default-theme)

;; projectile
(projectile-global-mode)

;; c++11
(add-hook
 'c++-mode-hook
 '(lambda()
    ;; We could place some regexes into `c-mode-common-hook', but note that their evaluation order
    ;; matters.
    (font-lock-add-keywords
     nil '(;;  new C++11 keywords
           ("\\<\\(alignof\\|alignas\\|constexpr\\|decltype\\|noexcept\\|nullptr\\|static_assert\\|thread_local\\|override\\|final\\)\\>" . font-lock-keyword-face)
           ("\\<\\(char16_t\\|char32_t\\)\\>" . font-lock-keyword-face)
           ;; integer/float/scientific numbers
           ("\\<[\\-+]*[0-9]*\\.?[0-9]+\\([ulUL]+\\|[eE][\\-+]?[0-9]+\\)?\\>" . font-lock-constant-face)
           ))
    ) t)

;; disable menu
(menu-bar-mode -1)

;; show-paren-mode
(show-paren-mode 1)

;; elpy
;; (package-initialize)
(elpy-enable)
;; (defun bind-ido-keys ()
;;   "Keybindings for ido mode."
;;   (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
;;   (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
;; (add-hook 'ido-setup-hook 'bind-ido-keys)

;;(eval-after-load 'popup
;;  '(progn
;;     (define-key popup-menu-keymap (kbd "C-n") 'popup-next)
;;     (define-key popup-menu-keymap (kbd "TAB") 'popup-next)
;;     (define-key popup-menu-keymap (kbd "<tab>") 'popup-next)
;;     (define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
;;     (define-key popup-menu-keymap (kbd "C-p") 'popup-previous)))

;; save history
(setq history-length t)
(savehist-mode 1)
(setq history-delete-duplicates t)
(setq savehist-max-history-length 100000)
(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))

(require 'visual-regexp-steroids)
(global-set-key (kbd "M-%") 'vr/query-replace)
;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(ansi-color-names-vector
;;   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
;; '(custom-safe-themes
;;   (quote
;;    ("169ee6b64dd931541d4a7de1d626ea03a651bb7039b422b7de114455282ee7c6" "f5eb916f6bd4e743206913e6f28051249de8ccfd070eae47b5bde31ee813d55f" "3ff96689086ebc06f5f813a804f7114195b7c703ed2f19b51e10026723711e33" default)))
;; '(ecb-options-version "2.40")
;; '(fci-rule-color "#383838" t)
;; '(nrepl-message-colors
;;   (quote
;;    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
;; '(vc-annotate-background "#2B2B2B")
;; '(vc-annotate-color-map
;;   (quote
;;    ((20 . "#BC8383")
;;     (40 . "#CC9393")
;;     (60 . "#DFAF8F")
;;     (80 . "#D0BF8F")
;;     (100 . "#E0CF9F")
;;     (120 . "#F0DFAF")
;;     (140 . "#5F7F5F")
;;     (160 . "#7F9F7F")
;;     (180 . "#8FB28F")
;;     (200 . "#9FC59F")
;;     (220 . "#AFD8AF")
;;     (240 . "#BFEBBF")
;;     (260 . "#93E0E3")
;;     (280 . "#6CA0A3")
;;     (300 . "#7CB8BB")
;;     (320 . "#8CD0D3")
;;     (340 . "#94BFF3")
;;     (360 . "#DC8CC3"))))
;; '(vc-annotate-very-old-color "#DC8CC3"))
;; (custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(font-lock-comment-delimiter-face ((t (:foreground "color-243"))))
 ;;'(font-lock-comment-face ((t (:foreground "color-242")))))
(custom-theme-set-faces
 'zenburn
 '(font-lock-comment-face ((t (:foreground "color-242"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "color-243")))))
(put 'scroll-left 'disabled nil)

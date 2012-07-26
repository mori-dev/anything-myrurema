;;; anything-myrurema.el --- Anything Interface for myrurema

;; Copyright (C) 2012 mori-dev

;; Author: mori-dev <mori.dev.asdf@gmail.com>
;; Keywords: ruby

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Installation:

;; install requires libraries:
;; `myrurema'                  https://rubygems.org/gems/myrurema
;; `anything.el'               http://www.emacswiki.org/emacs/anything.el
;; `anything-config.el'        http://www.emacswiki.org/emacs/anything-config.el
;; `anything-match-plugin.el'  http://www.emacswiki.org/emacs/anything-match-plugin.el

;; `anything-myrurema.el'      http://github.com/mori-dev/anything-myrurema (this file)

;;; Usage
;;
;; (require 'anything-myrurema)
;;
;; M-x anything-myrurema

;;; Code:

(require 'cl)
(require 'anything)
(require 'anything-config)

(defvar anything-myrurema-index-path "~/.emacs.d/myrurema.index")

(defvar anything-c-source-myrurema
      `((name . "myrurema")
        (candidates-file . ,anything-myrurema-index-path)
        (candidate-number-limit . 100000)
        (action . (("emacs でるりまを見る" . (lambda (c) (anything-myrurema-show-rurema c)))
                   ("ブラウザでるりまサーチ" . (lambda (c) (anything-myrurema-rurema-search c)))))))

(defun anything-myrurema-get-docstring (s)
  (cond
   ((executable-find "rurema")
    (shell-command-to-string (format "rurema --no-ask %s" (shell-quote-argument s))))
   (t
    "can't find \"rurema\" command")))

(defun anything-myrurema-show-rurema (candidate)
    (let ((docstring (anything-myrurema-get-docstring candidate))
           (buf (get-buffer-create "*rurema-result*")))
      (with-current-buffer buf
        (erase-buffer)
        (insert docstring)
        (goto-char (point-min))
        (delete-region (point) (save-excursion (end-of-line) (point)))
        (delete-blank-lines))
      (switch-to-buffer buf)))

(defun anything-myrurema-rurema-search (candidate)
    (browse-url (format "http://rurema.clear-code.com/query:%s/" (url-hexify-string candidate))))

(defun anything-myrurema ()
  "anything myrurema"
  (interactive)
  (anything-other-buffer 'anything-c-source-myrurema "*anything myrurema*"))

(provide 'anything-myrurema)

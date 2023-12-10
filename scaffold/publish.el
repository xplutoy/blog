;;; publish.el --- notes setting. -*- lexical-binding: t no-byte-compile: t -*-
(require 'package)
(setq
 package-archives
 '(("melpa"         . "https://melpa.org/packages/")
   ("melpa-stable"  . "https://stable.melpa.org/packages/")
   ("gnu"           . "https://elpa.gnu.org/packages/")
   ("nongnu"        . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(dolist (pkg '(denote htmlize))
  (unless (package-installed-p pkg)
    (package-install pkg)))
(require 'htmlize)
(require 'denote)
(require 'ox-publish)
(setq org-roam-directory "../")

(setq org-export-with-section-numbers t
      org-export-htmlize-output-type 'css
      org-export-with-smart-quotes t
      org-export-with-footnotes t
      org-export-with-sub-superscripts nil)
(setq org-export-global-macros
      '(("timestamp" . "@@html:<span class=\"timestamp\">[$1]</span>@@")))
(setq org-html-doctype "html5"
      org-html-html5-fancy t
      org-html-checkbox-type 'html
      org-html-validation-link nil
      org-html-htmlize-output-type 'css
      org-html-container-element "section"
      org-html-head-include-default-style nil)

(defun yx/org-sitemap-date-entry-format (entry style project)
  "Format ENTRY in org-publish PROJECT Sitemap format ENTRY ENTRY STYLE format that includes date."
  (let ((filename (org-publish-find-title entry project)))
    (if (= (length filename) 0)
        (format "*%s*" entry)
      (format "{{{timestamp(%s)}}} [[file:%s][%s]]"
              (format-time-string "%Y-%m-%d"
                                  (org-publish-find-date entry project))
              entry
              filename))))

(defvar yx/html-head "<link rel='stylesheet' href='./css/org.css' type='text/css'/>")
(defvar yx/html-postamble "<div id='postamble' class='status'> <hr/> <p class='author'>Created with %c by %a <br\>Updated: %C<br/></p> </div>")
(setq org-publish-project-alist
      `(("yx-notes"
         :components ("yx-notes-page" "yx-notes-static"))
        ("yx-notes-page"
         :base-directory "../"
         :base-extension "org"
         :publishing-directory "./public_html/"
         :recursive nil
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :auto-preamble t
         :auto-sitemap t
         :sitemap-filename "index.org"
         :sitemap-title "Technical Notes"
         :sitemap-sort-files anti-chronologically ;sort the posts from newest to oldest.
         :sitemap-format-entry yx/org-sitemap-date-entry-format

         :html-link-home "/blog"
         :html-link-up "/blog"
         :html-head-include-scripts nil
         :html-head-include-default-style nil
         :html-head ,yx/html-head
         :html-postamble ,yx/html-postamble
         )
        ("yx-notes-static"
         :base-directory "./"
         :base-extension "css\\|js\\|png\\|jpg\\|gif"
         :publishing-directory "./public_html/"
         :recursive t
         :publishing-function org-publish-attachment
         ))
      )

(org-publish "yx-notes" t nil)

;;; publish.el ends here

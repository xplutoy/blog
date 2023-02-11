;;; publish.el --- notes setting. -*- lexical-binding: t no-byte-compile: t -*-
(require 'package)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(dolist (pkg '(denote htmlize))
  (unless (package-installed-p pkg)
    (package-install pkg)))
(require 'denote)
(require 'htmlize)
(require 'ox-publish)
(setq org-export-with-section-numbers nil
      org-export-with-smart-quotes t)
(setq org-html-doctype "html5"
      org-html-html5-fancy t
      org-html-checkbox-type 'html
      org-html-htmlize-output-type 'css
      org-html-container-element "section"
      )

(defvar yx/website-html-head "<link rel='stylesheet' href='/css/site.css?v=2' type='text/css'/>")

(setq org-publish-project-alist
      `(("yx-notes"
         :components ("yx-notes-page" "yx-notes-static"))
        ("yx-notes-page"
         :base-directory "../"
         :base-extension "org"
         :publishing-directory "./public_html/"
         :recursive nil
         :publishing-function org-html-publish-to-html
         :headline-levels 3
         :auto-preamble t
         :auto-sitemap t
         :sitemap-filename "index.org"

         :html-link-home "/"
         :html-link-up "/"
         :html-head-include-scripts t
         :html-head-include-default-style nil
         :html-head ,yx/website-html-head
         )
        ("yx-notes-static"
         :base-directory "./"
         :base-extension "css\\|js\\|png\\|jpg\\|gif"
         :publishing-directory "./public_html/"
         :recursive t
         :publishing-function org-publish-attachment
         ))
      )
(package-installed-p 'htmlize)

;;; publish.el ends here

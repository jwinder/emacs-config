(defun weather ()
  "Runs the `weather' shell command which delegates to https://github.com/jfrazelle/weather."
  (interactive)
  (jw--quick-run-cmd-line-process "weather -days=3" "*weather*"))

(defun twitter ()
  "This starts a buffer with the `rainbowstream' process. I really like `rainbowstream', so I use that instead of `twittering-mode'."
  (interactive)
  (jw--quick-run-cmd-line-process "rainbowstream" "*twitter*"))

(defun javascript-equality-table ()
  (interactive)
  (browse-url "http://zero.milosz.ca/"))

(defun soft-murmur-background-sound ()
  (interactive)
  (browse-url "http://asoftmurmur.com/?v=32632b490000"))

(defun img-jack-nicholson-creepy-nod ()
  (interactive)
  (browse-url "http://img.pandawhale.com/post-30824-Jack-Nicholson-Creepy-Nodding-SRXv.gif"))

(defun img-working-hard ()
  (interactive)
  (browse-url "http://i.imgur.com/Lkw5kmF.jpg"))

(defun img-run ()
  (interactive)
  (browse-url "http://replygif.net/i/1238.gif"))

(defun horse-books-dont-block ()
  (interactive)
  (browse-url "https://twitter.com/Horse_ebooks/status/364096530451410947"))

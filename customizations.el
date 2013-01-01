(put 'downcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(custom-safe-themes (quote ("624784ca64f53eb0d5bc4c9bbf7e70e878d2de2b88d1ffa83ea28385a06d9bd3" "45be0ffeadbbe7e24ba3a1e6672b51ce43ce43853c9d8915e708658a204f9b11" "e1327a5cdacf12dbd0e82e40ab4c47396083da766bcb592a7d441cff4f152c28" "a18c23840fd2d62800144cb1315eef213f2365876c90d948db9c7a6f665c0c4d" "8613fd326fe1541f12f29418b89d825ff9fe6f828b9ef4297e667e274a0cfa7a" "0e60ddf0e6aaf0b644abb34ff963d81b4bc9ab8716ba54d58c0969aaa18fecae" "49cf97003cd82241f8556100e7827a5870d677768353a1932eb77fe0e13ab9a6" "9f90abc58660721dc6934b0024a90c9b94720e22f11b79be579bb584f5b4b4bc" "93f19fd158dcc50d9c0ae94a8e7ddaa126a0b065147cc92d49cd9e7ba25d4377" "8ee6ada6026fe30c4bcac6127899d9b4992b58801b4695a5789f8458f62e128f" "af2229d128c1fe6ddc6a0c52bd7bbf9eb9125335d8915bd116a8d405c43218e2" "af6152372ec22656919a86afbd5196cc221e499fd2b0b32ccad7ec304eaf8207" "5163f77ed0a95aec460b9cd807a961e08ac7cf0bea2e62a37aa88e0aebf68423" "4a6197ad70ea3be97bb23a9e814e942f3a1b74255dd3983370b18f1e49f63ef9" "8aff2836494e2abd73cae84f016d5e2f76c756ffac3de4944f2e4aed01401295" "908d71b84175fd1a5059f45fadb8a384d43c7dd802b6c63bccdd40a2ee6cbb89" "d6a00ef5e53adf9b6fe417d2b4404895f26210c52bb8716971be106550cea257" "5e1d1564b6a2435a2054aa345e81c89539a72c4cad8536cfe02583e0b7d5e2fa" default)))
 '(haskell-mode-hook (quote (turn-on-haskell-indentation)))
 '(safe-local-variable-values (quote ((eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook" (add-hook (quote write-contents-functions) (lambda nil (delete-trailing-whitespace) nil)) (require (quote whitespace)) "Sometimes the mode needs to be toggled off and on." (whitespace-mode 0) (whitespace-mode 1)) (whitespace-line-column . 80) (whitespace-style face trailing lines-tail) (require-final-newline . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

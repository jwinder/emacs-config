(global-set-key [f8] 'pomodoro-start-or-void)

(add-hook 'pomodoro-start-hook 'mode-line-off)
(add-hook 'pomodoro-void-hook 'mode-line-reset)
(add-hook 'pomodoro-finished-hook 'mode-line-reset)

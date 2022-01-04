"" Following command is to disable annoying bell sound whenever an
"" invalid command is input
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set background=dark
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set si
set number
set showcmd
set t_u7= ""Fix bug that causes vim to open in replace mode https://github.com/microsoft/terminal/issues/1637

# syntax highlight
syntax on
:set laststatus=2
:set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

# virtually unfinite undo/redo (u/CTRL+r)
set undofile
set undodir=~/.vim/undodir

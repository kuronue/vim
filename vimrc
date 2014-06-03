" Basic
" --------------------------------------------------------------------------
" --------------------------------------------------------------------------
" just to make sure vim is loaded
set nocompatible

" Pathogen - vim package manager
" disable any plugins (need to call before activate it)
let g:pathogen_disabled = ['vjde']
" activate it
call pathogen#infect() 

" new style?
" call pathogen#runtime_append_all_bundles()


" Plugins/Syntax supports
" --------------------------------------------------------------------------
" --------------------------------------------------------------------------
" prereq for many plugins
syntax on
filetype plugin indent on

" --- NERDTree --- 
nnoremap <silent> <F2> :NERDTreeToggle<CR>

" --- Taglist ---
"let Tlist_Sort_Type = "name"
"let Tlist_Exit_OnlyWindow = 1
"nnoremap <silent> <F3> :TlistToggle<CR>
" we now use TagBar. It looks better
" --- Tagbar ----
nnoremap <silent> <F3> :TagbarToggle<CR>

" --- Supertab ---
"for c-x c-u and normal
let g:SuperTabDefaultCompletionType = 'context' 

" --- Xmledit ---
"can't set it to ',' because xml use it (it's a legal char)
let xml_jump_string = "`" 	

" --- vim-latex ---
" check http://vim-latex.sourceforge.net/documentation/latex-suite/recommended-settings.html for details
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
set sw=2
set iskeyword+=:

" --- eclim support --- 
"let g:EclimLogLevel = 10 -- disable this coz need to press enter
"everytime(annoying). The default behaviour is good enough (lvl4)

" coz of annoying html validation for jsp
au BufReadPre,BufNewFile *.jsp let g:EclimHtmlValidate=0

" --- bash/shell folding ---
let g:sh_fold_enabled = 3

" --- vjde --
" disable it
"let g:vjde_loaded = 1
" it uses pathogen now, so disable via pathogen


" Functions
" --------------------------------------------------------------------------
" dynamic syntax highlighting 
function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft

  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif

  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry

  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunction

call TextEnableCodeSnip(  'c',   '@begin=c@',   '@end=c@', 'SpecialComment')
call TextEnableCodeSnip(  'perl',   '@begin=perl@',   '@end=perl@', 'SpecialComment')
call TextEnableCodeSnip('cpp', '@begin=cpp@', '@end=cpp@', 'SpecialComment')
call TextEnableCodeSnip('sql', '@begin=sql@', '@end=sql@', 'SpecialComment')
call TextEnableCodeSnip('xml', '@begin=xml@', '@end=xml@', 'SpecialComment')
"does not work!
"call TextEnableCodeSnip('xml', '@xml@', '@xml@@', 'SpecialComment') 
call TextEnableCodeSnip('dtd', '@begin=dtd@', '@end=dtd@', 'SpecialComment')
call TextEnableCodeSnip('xsd', '@begin=xsd@', '@end=xsd@', 'SpecialComment')

" --------------------------------------------------------------------------
" rotating the colorscheme
let s:color_tot=2
let s:color_cur=0
function! Rotate_colorscheme()
	if s:color_cur % s:color_tot == 0
		colorscheme desert
	elseif s:color_cur % s:color_tot == 1
		colorscheme molokai
	endif
	let s:color_cur += 1
	echo s:color_cur
endfunction


" --------------------------------------------------------------------------
"  Mapping
" --------------------------------------------------------------------------
map <F5> :call Rotate_colorscheme()<CR>

" toggle :pasting
nnoremap <F4> :set invpaste paste?<CR>
set pastetoggle=<F4>
set showmode 

" --------------------------------------------------------------------------
" General config
" --------------------------------------------------------------------------
set mouse=r 		" 'a' mode is annoying coz easily mistakenly press 
set backupdir=~/.vimbakdir
set directory=~/.vimbakdir
set nocompatible
set expandtab 				" to use the space
set ts=4 tw=78 sw=4 sr
set number
set nohls 
set ignorecase smartcase 	" smart case is enable only when ic
set autoindent
set ffs=unix,dos

set completeopt=menuone,menu,longest,preview  "determine popup behaviour
set history=1000 			" default 20 is not enuf
"set title 					" terminal title
let maplocalleader = ','
set foldmethod=syntax
let perl_fold = 1
" Looks nice (vimwiki style). May want to remove this if interrupting
set fo=tnro

" command line autocompletion (bash is wildmode=longest,list)
set wildmode=longest,list,full
" crate the vim menu (like dmenu)
set wildmenu 


" --------------------------------------------------------------------------
"  Misc
" --------------------------------------------------------------------------
" autoclose the preview windows
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"
" --------------------------------------------------------------------------
" auto save/load view
" the *.* ensure that the view is not being saved for empty file
au BufWinLeave *.* mkview 
au BufWinEnter *.* silent loadview

" my hier 
au BufReadPre,BufNewFile *.hier set ft=hier

" pl .. remove the annoying include
au BufReadPre,BufNewFile *.pm set include=
au BufReadPre,BufNewFile *.pl set include=

" reduce space for yml from 4 --> 2
au BufReadPre,BufNewFile *.yml set ts=2 sw=2 ai

colorscheme molokai
if has("win32")
    se lines=999 columns=97
    se guifont=ProggyCleanTT\ CE:h12
    " override
    set backupdir=~/_vimbakdir
    set directory=~/_vimbakdir
    set noswapfile
endif

" change the theme (so that easier to see)
set background=dark


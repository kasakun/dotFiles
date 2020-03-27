" Plugs {

    call plug#begin('~/.vim/plugged')
    Plug 'mhinz/vim-startify'
    Plug 'mhinz/vim-signify'

    " defx
    if has('nvim')
        Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    else
         Plug 'Shougo/defx.nvim'
         Plug 'roxma/nvim-yarp'
         Plug 'roxma/vim-hug-neovim-rpc'
     endif

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'flazz/vim-colorschemes'
    Plug 'bling/vim-bufferline'
    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-indent'
    Plug 'reedes/vim-litecorrect'
    Plug 'reedes/vim-textobj-sentence'
    Plug 'reedes/vim-textobj-quote'
    Plug 'reedes/vim-wordy'
    Plug 'scrooloose/nerdcommenter'
    call plug#end()

" }

" Plug Setting {

    " defx {
        call defx#custom#option('_', {
            \ 'winwidth': 30,
            \ 'split': 'vertical',
            \ 'direction': 'botright',
            \ 'show_ignored_files': 0,
            \ 'buffer_name': 'defx',
            \ 'toggle': 1,
            \ 'resume': 1
            \ })

        call defx#custom#column('icon', {
            \ 'directory_icon': '▸',
            \ 'opened_icon': '▾',
            \ 'root_icon': ' ',
            \ })

        call defx#custom#column('filename', {
            \ 'min_width': 40,
            \ 'max_width': 40,
            \ })

        call defx#custom#column('mark', {
            \ 'readonly_icon': '✗',
            \ 'selected_icon': '✓',
            \ })

        " Keys {
            " Toggling defx
            nnoremap <silent> <Leader>e
                \ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()` <CR>

            nnoremap <silent> <Leader>a
                \ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()`
                \ -search=`expand('%:p')`<CR>

            " Key mapping inside defx
            autocmd FileType defx call s:defx_my_settings()
            function! s:defx_my_settings() abort
                nnoremap <silent><buffer><expr> <CR>
                    \ defx#is_directory() ?
                    \ defx#do_action('open_tree') :
                    \ defx#do_action('multi', [['drop', 'split']])
                nnoremap <silent><buffer><expr> c
                    \ defx#do_action('copy')
                nnoremap <silent><buffer><expr> m
                    \ defx#do_action('move')
                nnoremap <silent><buffer><expr> p
                    \ defx#do_action('paste')
                nnoremap <silent><buffer><expr> l
                    \ defx#do_action('open')
                nnoremap <silent><buffer><expr> E
                    \ defx#do_action('open', 'vsplit')
                nnoremap <silent><buffer><expr> P
                    \ defx#do_action('open', 'pedit')
                nnoremap <silent><buffer><expr> o
                    \ defx#do_action('open_or_close_tree')
                nnoremap <silent><buffer><expr> K
                    \ defx#do_action('new_directory')
                nnoremap <silent><buffer><expr> N
                    \ defx#do_action('new_file')
                nnoremap <silent><buffer><expr> C
                    \ defx#do_action('toggle_columns',
                    \ 'mark:indent:icon:filename:type:size:time')
                nnoremap <silent><buffer><expr> S
                    \ defx#do_action('toggle_sort', 'time')
                nnoremap <silent><buffer><expr> d
                    \ defx#do_action('remove')
                nnoremap <silent><buffer><expr> r
                    \ defx#do_action('rename')
                nnoremap <silent><buffer><expr> !
                    \ defx#do_action('execute_command')
                nnoremap <silent><buffer><expr> x
                    \ defx#do_action('execute_system')
                nnoremap <silent><buffer><expr> yy
                    \ defx#do_action('yank_path')
                nnoremap <silent><buffer><expr> .
                    \ defx#do_action('toggle_ignored_files')
                nnoremap <silent><buffer><expr> ;
                    \ defx#do_action('repeat')
                nnoremap <silent><buffer><expr> h
                    \ defx#do_action('cd', ['..'])
                nnoremap <silent><buffer><expr> ~
                    \ defx#do_action('cd')
                nnoremap <silent><buffer><expr> q
                    \ defx#do_action('quit')
                nnoremap <silent><buffer><expr> <Space>
                    \ defx#do_action('toggle_select') . 'j'
                nnoremap <silent><buffer><expr> *
                    \ defx#do_action('toggle_select_all')
                nnoremap <silent><buffer><expr> j
                    \ line('.') == line('$') ? 'gg' : 'j'
                nnoremap <silent><buffer><expr> k
                    \ line('.') == 1 ? 'G' : 'k'
                nnoremap <silent><buffer><expr> <C-l>
                    \ defx#do_action('redraw')
                nnoremap <silent><buffer><expr> <C-g>
                    \ defx#do_action('print')
                nnoremap <silent><buffer><expr> cd
                    \ defx#do_action('change_vim_cwd')
            endfunction
        " }
    "}

    " vim-airline {
        " Set configuration options for the statusline plugin vim-airline.
        " Use the powerline theme and optionally enable powerline symbols.
        " To use the symbols , , , , , , and .in the statusline
        " segments add the following to your .vimrc.before.local file:
        let g:airline_powerline_fonts=1
        " If the previous symbols do not render for you then install a
        " powerline enabled font.

        " See `:echo g:airline_theme_map` for some more choices
        " Default in terminal vim is 'dark'
        if isdirectory(expand("~/.vim/plugged/vim-airline-themes/"))
            if !exists('g:airline_theme')
                let g:airline_theme = 'fruit_punch'
            endif
            if !exists('g:airline_powerline_fonts')
                " Use the default set of separators with a few customizations
                let g:airline_left_sep='›'  " Slightly fancier than '>'
                let g:airline_right_sep='‹' " Slightly fancier than '<'
            endif
        endif
    " }

" }

" General {

    set background=dark         " Assume a dark background

    " Allow to trigger background
    function! ToggleBG()
        let s:tbg = &background
        " Inversion
        if s:tbg == "dark"
            set background=light
        else
            set background=dark
        endif
    endfunction
    noremap <leader>bg :call ToggleBG()<CR>

    " if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    " endif
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    " Most prefer to automatically switch to the current file directory when
    " a new buffer is opened; to prevent this behavior, add the following to
    " your .vimrc.before.local file:
    "   let g:spf13_no_autochdir = 1
    if !exists('g:spf13_no_autochdir')
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
        " Always switch to the current file directory
    endif

    "set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator
    set iskeyword-=_                    " '_' is an end of word designator

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    " To disable this, add the following to your .vimrc.before.local file:
    "   let g:spf13_no_restore_cursor = 1
    if !exists('g:spf13_no_restore_cursor')
        function! ResCur()
            if line("'\"") <= line("$")
                silent! normal! g`"
                return 1
            endif
        endfunction

        augroup resCur
            autocmd!
            autocmd BufWinEnter * call ResCur()
        augroup END
    endif

    " Setting up the directories {
        set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif

        " To disable views add the following to your .vimrc.before.local file:
        "   let g:spf13_no_views = 1
        if !exists('g:spf13_no_views')
            " Add exclusions to mkview and loadview
            " eg: *.*, svn-commit.tmp
            let g:skipview_files = [
                \ '\[example pattern\]'
                \ ]
        endif
    " }

" }

" UI {

    let g:solarized_visibility="normal"
    colorscheme gruvbox             " Set a colorscheme
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        if !exists('g:override_spf13_bundles')
            set statusline+=%{fugitive#statusline()} " Git Hotness
        endif
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number | set relativenumber " Hybrid line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    set textwidth=80                " Text width
    set colorcolumn=+1,+41          " Ruler

" }

" Formatting {

    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    " To disable the stripping of whitespace, add the following to your
    " .vimrc.before.local file:
    "   let g:spf13_keep_trailing_whitespace = 1
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:spf13_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
    "autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    " preceding line best in a plugin but here for now.

    autocmd BufNewFile,BufRead *.coffee set filetype=coffee

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell

" }

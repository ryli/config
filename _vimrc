" =============================================================================
"        << Beta 2014.3.1>>
" =============================================================================

" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:iswindows = 0
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif


" =============================================================================
"                          << 以下为软件默认配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Windows Gvim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if (g:iswindows && g:isGUI)
    " source $VIMRUNTIME/vimrc_example.vim
    " source $VIMRUNTIME/mswin.vim
    " behave mswin
    set diffexpr=MyDiff()
    set hlsearch        " 高亮搜索
    map ch :nohl<cr>	" 按Ctrl-h取消查找后的高亮显示
    set magic           " Set magic on, for regular expressions
    set incsearch       " 在输入要搜索的文字时，实时匹配
    set bsdir=buffer    " 设定文件浏览器目录为当前目录
    set autochdir       " 自动改变当前目录
    set wrapscan		" 文件的两端绕回搜索


    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

" -----------------------------------------------------------------------------
"  < Linux Gvim/Vim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if !g:iswindows
    set hlsearch        " 高亮搜索
    set magic           " Set magic on, for regular expressions
    set incsearch       " 在输入要搜索的文字时，实时匹配
    map ch :nohl<cr>	" 按Ctrl-h取消查找后的高亮显示

    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    if g:isGUI
        " Source a global configuration file if available
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        " This line should not be removed as it ensures that various options are
        " properly set to work with the Vim-related packages available in Debian.
        runtime! debian.vim
        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.
        if has("syntax")
            syntax on
        endif

        set mouse=a                    " 在任何模式下启用鼠标
		"set mousehide				   " 编辑时隐藏系统鼠标
        "set mouse=vss
        set selection=exclusive
        set selectmode=mouse,key
        set t_Co=256                   " 在终端启用256色
 "       set backspace=2                " 设置退格键可用

        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif


" =============================================================================
"                          << 以下为用户自定义配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Vundle 插件管理工具配置 >
" -----------------------------------------------------------------------------
" 用于更方便的管理vim插件，具体用法参考 :h vundle 帮助
" 安装方法为在终端输入如下命令
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

set nocompatible                                      "禁用 Vi 兼容模式
filetype off                                          "禁用文件类型侦测

if !g:iswindows
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
else
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
endif

" 使用Vundle来管理Vundle，这个必须要有。
Bundle 'gmarik/vundle'

" 以下为要安装或更新的插件，不同仓库都有（具体书写规范请参考帮助）
Bundle 'Align'
Bundle 'jiangmiao/auto-pairs'
"Bundle 'AutoClose'
"Bundle 'matchit.zip'
"bundle '_jsbeautify'
"Bundle 'bufexplorer.zip'
Bundle 'ccvext.vim'
" Bundle 'oblitum/cSyntaxAfter'
Bundle 'Yggdroot/indentLine'
Bundle 'breestealth/Mark-Karkat'
" Bundle 'minibufexpl.vim'
" Bundle 'fholgado/minibufexpl.vim' "这个上的6.4.4版本与 Vundle 插件有一些冲突
Bundle 'Shougo/neocomplcache'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
" Bundle 'FromtonRouge/OmniCppCmplete'
" Bundle  'Valloric/YouCompleteMe'
Bundle 'bling/vim-airline'
Bundle 'repeat.vim'
" Bundle 'msanders/snipmate.vim'
Bundle 'wesleyche/SrcExpl'
" Bundle 'ervandew/supertab'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'vim-php/tagbar-phpctags.vim'
Bundle 'netroby/taglist'
Bundle 'TxtBrowser'
Bundle 'winmanager'
Bundle 'ZoomWin'

Bundle 'a.vim'
Bundle 'ctrlp.vim'
Bundle 'std_c.zip'
" Bundle 'csscomb/CSScomb-for-vim'

" 新增
Bundle 'cespare/vim-golang'
Bundle 'dgryski/vim-godef'
Bundle 'Blackrush/vim-gocode'
Bundle 'jstemmer/gotags'
Bundle 'Zuckonit/vim-airline-tomato'
Bundle 'mattn/emmet-vim'
Bundle 'vim-scripts/vimwiki'
Bundle 'mattn/calendar-vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'lilydjwg/colorizer'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'playsticboy/vim-markdown'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'terryma/vim-smooth-scroll'
Bundle 'terryma/vim-expand-region'
Bundle 'walm/jshint.vim'
Bundle 'vim-scripts/Command-T'
Bundle 'EasyMotion'
Bundle 'DataWraith/auto_mkdir'

" Bundle 'dterei/VimBookmarking'
" Bundle 'Rykka/riv.vim'
" Bundle 'Rykka/colorv.vim'
" Bundle 'h2ero/phpcr'
" Bundle 'UltiSnips'
" Bundle 'Tabular'
" Bundle 'vim-scripts/visualMarks.vim'
" Bundle 'jaredly/vim-debug'
" Bundle 'tomtom/checksyntax_vim'
" Bundle 'arnaud-lb/vim-php-namespace'
" Bundle 'fabpot/PHP-CS-Fixer'
" Bundle 'stephpy/vim-php-cs-fixer'
" Bundle 'mageekguy/php.vim'

" Bundle 'samsonw/vim-task'
" Bundle 'hsitz/VimOrganizer'       " a clone of Emacs'Org-mode
" Bundle 'sjl/gundo.vim'            " visualize your Vim undo tree


" -----------------------------------------------------------------------------
"                   Editor 设置
" -----------------------------------------------------------------------------
" 行控制
set linebreak
" 设置自动折行（长行换折断，没有换行符）
set wrap
" set nowrap

" 换行时不把单词分成两截
set lbr
" 打开断行模块对亚洲语言支持。 m 表示允许在两个汉字之间断行， 即使汉字之间没有出现空格。 B 表示将两行合并为一行的时候， 汉字与汉字之间不要补空格。会导致自动换行！！
set fo+=mB
" 设置行字符数(最大列数)，超出后自动换行
"set textwidth=120
" tw=0并且没有设置g:leave_my_textwidth_alone时vim就会自动把tw改成78
" set textwidth=0
" let g:leave_my_textwidth_alone

" tab显示
" set list
"set listchars=eol:$,tab:>-,nbsp:~
"set listchars=tab:\|\ ,trail:.,extends:>,precedes:<
"set listchars=tab:\|\ ,        " 显示Tab符，使用一高亮竖线代替
"set listchars=tab:&gt;-,trail:-    " 显示Tab符，使用 &gt;-- 代替
"将空格转换为tab
set noexpandtab
" :%retab

"以下字符将被视为单词的一部分 (ASCII),不要被换行：
"set iskeyword+=33-47,58-64,91-96,123-128   " 有改变配色的bug
set iskeyword+=_,$,@,%,#,-

"标签页
set tabpagemax=9
" 只有1个标签页时隐藏标签栏， 0永不显示标签页
set showtabline=1

" 开启上一行下一行。b-backspace，s-space，h，i，~(反转字母大小写)，[-左方向键
" ，]-右方向键
"set whichwrap=b,s,,[,]
"set whichwrap=<,>,h,|

set cursorline                                        "突出显示当前行

"highlight CurrentLine guibg=darkgrey guifg=white
"au! Cursorhold * exe 'match CurrentLine /\%' . line('.') . 'l.*/'
"set ut=100

"hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
"hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

"将当前光标下的列高亮
"set cuc
" 设置第N列高亮 先设置textwidth
" set textwidth=80
" 再设置
"set cc=+1

" 在被分割的窗口间显示空白，便于阅读
"set fillchars=vert:\ ,stl:\ ,stlnc:\
" 分割窗口时保持相等宽/高
set equalalways


" -----------------------------------------------------------------------------
"  < 编码配置 >
" -----------------------------------------------------------------------------
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                                    "设置gvim内部编码
set fileencoding=utf-8                                "设置当前文件编码
" set fileencodings=utf-8,gbk,chinese,cp936,gb2312,ucs-bom,euc-tw,big5,euc-jp,euc-kr,latin-1     "设置支持打开的文件的编码
set fileencodings=ucs-bom,utf-8,gb2312,euc-cn,euc-tw,gb18030,gbk,cp936

if has('win32')
    language chinese
    let &termencoding=&encoding
endif

set helplang=cn                                       "设置帮助信息

" 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新文件的<EOL>格式
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型
" set formatoptions+=mM                                 "正确地处理中文字符的折行和拼接
set formatoptions-=r
set fencs=utf-8,gbk,chinese,latin1


"显示中文引号
if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
    " 设置宽度不明的文字(如 “”①②→ )为双宽度文本
    set ambiwidth=double
endif

if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "解决consle输出乱码
    language messages zh_CN.utf-8
endif

" 保留历史记录
set history=1024

" 永久撤销，Vim7.3 新特性
if has('persistent_undo')
    set undofile

    " 设置撤销文件的存放的目录
    if has("unix")
        set undodir=/tmp/,~/tmp,~/Temp
    else
        set undodir=d:/temp/
    endif
    set undolevels=1000
    set undoreload=10000
endif

" Diff 模式的时候鼠标同步滚动 for Vim7.3
if has('cursorbind')
"    set cursorbind
end
" 设置 <F7> 和 <F8> 分别跳转到上一个不同、下一个不同处，如果不是 diff 模式， 则分别设置为 QucikFix 的上一条、下一条信息行
if &diff
    nmap <F7> [c
    nmap <F8> ]c
else
    map <F7> :cp<cr>
    map <F8> :cn<cr>
endif

" -----------------------------------------------------------------------------
"  < 编写文件时的配置 >
" -----------------------------------------------------------------------------

" 获取当前目录
func! GetPWD()
    return substitute(getcwd(), "", "", "g")
endf

" 返回当前时期
func! GetDateStamp()
    return strftime('%Y-%m-%d')
endfunction


filetype on                                           "启用文件类型侦测
filetype plugin on                                    "针对不同的文件类型加载对应的插件
 filetype indent on                                   " 针对不同的文件类型加载对应的插件
filetype plugin indent on                             "启用缩进
"set autoindent
set smartindent                                       "启用智能对齐方式
"set indentexpr                                       "最灵活的缩进，自己设置文件
"set expandtab                                         "将Tab键转换为空格
set tabstop=4                                         "设置Tab键的宽度
set shiftwidth=4                                      "换行时自动缩进4个空格
set smarttab                                          "指定按一次backspace就删除shiftwidth宽度的空格
set backspace=indent,eol,start                        "插入模式下，“←”如何删除光标前的字符：行首空白、换行符、插入点之前的字符

set cino=                                             " C/C++ 缩进风格

set foldenable                                        "启用折叠
set softtabstop=4
set cindent shiftwidth=4                              " 自动缩进4空格
"set foldmethod=indent                                 "indent 折叠方式
set foldmethod=marker                                "marker 折叠方式
" set foldmethod=syntax
" set showmatch                                         "在输入括号时光标会短暂地跳到与之相匹配的括号处，不影响输入
" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 当文件在外部被修改，自动更新该文件
set autoread

" 常规模式下输入 ce 清除行尾空格
nmap ce :%s/\s\+$//g<cr>:noh<cr>

" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<cr>:noh<cr>
nmap cR :%s/\r/\r/g<cr>:noh<cr>

" 常规模式下注释
nmap cm I/*<space><ESC>A<space>*/<ESC>j
nmap cc I//<space><ESC>j
nmap ci I<!--<space><ESC>A<space>--><ESC>j
nmap ca A<space>//<space>

set ignorecase                                        "搜索模式里忽略大小写
set smartcase                                         "如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用
" set noincsearch                                       "在输入要搜索的文字时，取消实时匹配

" Ctrl + K 插入模式下光标向上移动
imap <c-k> <Up>

" Ctrl + J 插入模式下光标向下移动
imap <c-j> <Down>

" Ctrl + H 插入模式下光标向左移动
inoremap <c-h> <Left>
" imap <c-h> <esc>ha

" Ctrl + L 插入模式下光标向右移动
imap <c-l> <Right>

" 每行超过80个的字符用下划线标示
"au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)

try
  set matchpairs=(:),{:},<:>,[:],《:》,〈:〉,［:］,（:）,「:」,『:』,‘:’,“:”
catch /^Vim\%((\a\+)\)\=:E474/
endtry


"设置 python 里面 = + - * 前后自动空格
au FileType python inoremap <buffer>= <c-r>=EqualSign('=')<CR>
au FileType python inoremap <buffer>+ <c-r>=EqualSign('+')<CR>
au FileType python inoremap <buffer>- <c-r>=EqualSign('-')<CR>
au FileType python inoremap <buffer>* <c-r>=EqualSign('*')<CR>
au FileType python inoremap <buffer>/ <c-r>=EqualSign('/')<CR>
au FileType python inoremap <buffer>> <c-r>=EqualSign('>')<CR>
au FileType python inoremap <buffer>< <c-r>=EqualSign('<')<CR>
au FileType python inoremap <buffer>: <c-r>=Swap()<CR>
au FileType python inoremap <buffer>, ,<space>

" -----------------------------------------------------------------------------
"  < 界面配置 >
" -----------------------------------------------------------------------------
"au GUIEnter * simalt ~x							  "自动最大化窗口
set number                                            "显示行号
set numberwidth=1                                     "行号栏宽度
set laststatus=2                                      "启用状态栏信息
set ruler                                             "在右下角显示光标位置的状态行
set rulerformat=%15(%c%V\ %p%%%)
set cmdheight=1                                       "设置命令行的高度为2，默认为1
set wildmenu                                          "命令行显示匹配
set showcmd                                           " 状态栏显示目前所执行的指令
set wildignore=*.o,*.obj,*.bak,*.exe,*.bin            "文件路径补全时忽略这些文件
set wildmode=list:full,full                           " 首先尝试最长的，接着轮换补全项
"set wildmode=longest:full,full

" 字体配置
    exec 'set guifont='.iconv('Consolas', &enc, 'gbk').':h14:cANSI'
	exec 'set guifontwide='.iconv('Microsoft\ Yahei\ Mono', &enc, 'gbk',).':h14:cGB2312'
	"exec 'set guifontwide=Microsoft\ Yahei\ Mono:h12:cGB2312'
    "set guifont=Microsoft\ YaHei\ Mono:h12                 "设置字体:字号（字体名称空格用下划线代替）
"set guifont=YaHei_Consolas_Hybrid:h11                 "设置字体:字号（字体名称空格用下划线代替）

set shortmess=atI                                     "去掉欢迎界面
" au GUIEnter * simalt ~x                              "窗口启动时自动最大化
"winpos 100 10                                         "指定窗口出现的位置，坐标原点在屏幕左上角
set lines=24 columns=88                              "指定窗口大小，lines为高度，columns为宽度

" 设置代码配色方案
syntax on
syntax enable

if g:isGUI          "Gvim配色方案
    "colorscheme zenburn
    " colorscheme Tomorrow-Night-Eighties
    " au BufNewFile,BufRead,BufEnter,WinEnter * colo molokai
    " au BufNewFile,BufRead,BufEnter,WinEnter *.wiki colo lucius " 各不同类型的文件配色不同

    " set background=dark     " light

    "colorscheme   molokai
    colorscheme solarized

else
    colorscheme solarized
    "colorscheme   molokai
    "colorscheme Tomorrow-Night-Eighties               "终端配色方案
endif

hi Cursor guifg=grey20 guibg=#00A9EC gui=NONE        "光标所在的字符

" 能够漂亮的显示.NFO文件
"     function! SetFileEncodings(encodings)
" 		let b:myfileencodingsbak=&fileencodings
" 		let &fileencodings=a:encodings
"     endfunction
"     function! RestoreFileEncodings()
" 		let &fileencodings=b:myfileencodingsbak
" 		unlet b:myfileencodingsbak
"     endfunction
"     au BufReadPre *.nfo call SetFileEncodings('cp437')|set ambiwidth=single
"     au BufReadPost *.nfo call RestoreFileEncodings()

hi link phpheredoc string                   "使PHP识别EOT字符串


" 个性化状栏（这里提供两种方式，要使用其中一种去掉注释即可，不使用反之）
" let &statusline=' %t %{&mod?(&ro?"*":"+"):(&ro?"=":" ")} %1*|%* %{&ft==""?"any":&ft} %1*|%* %{&ff} %1*|%* %{(&fenc=="")?&enc:&fenc}%{(&bomb?",BOM":"")} %1*|%* %=%1*|%* 0x%B %1*|%* (%l,%c%V) %1*|%* %L %1*|%* %P'
" set statusline=%t\ %1*%m%*\ %1*%r%*\ %2*%h%*%w%=%l%3*/%L(%p%%)%*,%c%V]\ [%b:0x%B]\ [%{&ft==''?'TEXT':toupper(&ft)},%{toupper(&ff)},%{toupper(&fenc!=''?&fenc:&enc)}%{&bomb?',BOM':''}%{&eol?'':',NOEOL'}]

" set statusline=
" set statusline+=%2*%-3.3n%0*\ " buffer number
" set statusline+=%f\ " file name
" set statusline+=%h%1*%m%r%w%0* " flag
" set statusline+=[
" if v:version >= 600
"     set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
"     set statusline+=%{&fileencoding}, " encoding
" endif
" set statusline+=%{&fileformat}] " file format
" set statusline+=%= " right align
" set statusline+=%2*0x%-8B\ " current char
" set statusline+=0x%-8B\ " current char
" set statusline+=%-14.(%l,%c%V%)\ %<%P " offset
" if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
"    set statusline+=\ %{VimBuddy()} " vim buddy
" endif




"状态行颜色
" highlight StatusLine guifg=SlateBlue guibg=Yellow
" highlight StatusLineNC guifg=Gray guibg=White



" 默认样式
set guioptions=1
" 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r   " 显示滚动条
    set guioptions-=L
    map <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif


" -----------------------------------------------------------------------------
"  < 快捷键 >
" -----------------------------------------------------------------------------
nmap <C-t>   :tabnew<cr>
nmap <C-p>   :tabprevious<cr>
nmap <C-Tab> :tabnext<cr>
"nmap <C-n>   :tabnext<cr>
nmap <C-k>   :tabclose<cr>


" 插入模式按 F4 插入当前时间
imap <f4> <C-r>=GetDateStamp()<cr>

" 普通模式，可视模式和选择模式下
" 使用 <Tab> 和 <Shift-Tab> 键来缩进文本。
" 在可视模式和选择模式下，可以自动恢复选中的文本。
nmap <tab> v>
nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

" 选中一段文字并全文搜索这段文字
vnoremap  *  y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap  #  y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" 在保存文件时自动去除无效空白，包括行尾空白和文件最后的空行
function RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()



" -----------------------------------------------------------------------------
"  < 编译、连接、运行配置 >
" -----------------------------------------------------------------------------
" F9 一键保存、编译、连接存并运行
map <F9> :call Run()<CR>
imap <F9> <ESC>:call Run()<CR>

" Ctrl + F9 一键保存并编译
map <c-F9> :call Compile()<CR>
imap <c-F9> <ESC>:call Compile()<CR>

" Ctrl + F10 一键保存并连接
map <c-F10> :call Link()<CR>
imap <c-F10> <ESC>:call Link()<CR>

let s:LastShellReturn_C = 0
let s:LastShellReturn_L = 0
let s:ShowWarning = 1
let s:Obj_Extension = '.o'
let s:Exe_Extension = '.exe'
let s:Sou_Error = 0

let s:windows_CFlags = 'gcc\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CFlags = 'gcc\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

let s:windows_CPPFlags = 'g++\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CPPFlags = 'g++\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

func! Compile()
    exe ":ccl"
    exe ":update"
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let s:Sou_Error = 0
        let s:LastShellReturn_C = 0
        let Sou = expand("%:p")
        let Obj = expand("%:p:r").s:Obj_Extension
        let Obj_Name = expand("%:p:t:r").s:Obj_Extension
        let v:statusmsg = ''
        if !filereadable(Obj) || (filereadable(Obj) && (getftime(Obj) < getftime(Sou)))
            redraw!
            if expand("%:e") == "c"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CFlags
                else
                    exe ":setlocal makeprg=".s:linux_CFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CPPFlags
                else
                    exe ":setlocal makeprg=".s:linux_CPPFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            endif
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""Obj_Name"is up to date"
        endif
    else
        let s:Sou_Error = 1
        echohl WarningMsg | echo " please choose the correct source file"
    endif
    exe ":setlocal makeprg=make"
endfunc

func! Link()
    call Compile()
    if s:Sou_Error || s:LastShellReturn_C != 0
        return
    endif
    let s:LastShellReturn_L = 0
    let Sou = expand("%:p")
    let Obj = expand("%:p:r").s:Obj_Extension
    if g:iswindows
        let Exe = expand("%:p:r").s:Exe_Extension
        let Exe_Name = expand("%:p:t:r").s:Exe_Extension
    else
        let Exe = expand("%:p:r")
        let Exe_Name = expand("%:p:t:r")
    endif
    let v:statusmsg = ''
	if filereadable(Obj) && (getftime(Obj) >= getftime(Sou))
        redraw!
        if !executable(Exe) || (executable(Exe) && getftime(Exe) < getftime(Obj))
            if expand("%:e") == "c"
                setlocal makeprg=gcc\ -o\ %<\ %<.o
                echohl WarningMsg | echo " linking..."
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                setlocal makeprg=g++\ -o\ %<\ %<.o
                echohl WarningMsg | echo " linking..."
                silent make
            endif
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_L = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_L != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " linking failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " linking successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " linking successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""Exe_Name"is up to date"
        endif
    endif
    setlocal makeprg=make
endfunc

func! Run()
    let s:ShowWarning = 0
    call Link()
    let s:ShowWarning = 1
    if s:Sou_Error || s:LastShellReturn_C != 0 || s:LastShellReturn_L != 0
        return
    endif
    let Sou = expand("%:p")
    let Obj = expand("%:p:r").s:Obj_Extension
    if g:iswindows
        let Exe = expand("%:p:r").s:Exe_Extension
    else
        let Exe = expand("%:p:r")
    endif
    if executable(Exe) && getftime(Exe) >= getftime(Obj) && getftime(Obj) >= getftime(Sou)
        redraw!
        echohl WarningMsg | echo " running..."
        if g:iswindows
            exe ":!%<.exe"
        else
            if g:isGUI
                exe ":!gnome-terminal -e ./%<"
            else
                exe ":!./%<"
            endif
        endif
        redraw!
        echohl WarningMsg | echo " running finish"
    endif
endfunc

" 使用 colorpicker 程序获取颜色值(hex/rgba)[[[2
function Lilydjwg_colorpicker()
  if exists("g:last_color")
    let color = substitute(system("colorpicker ".shellescape(g:last_color)), '\n', '', '')
  else
    let color = substitute(system("colorpicker"), '\n', '', '')
  endif
  if v:shell_error == 1
    return ''
  elseif v:shell_error == 2
    " g:last_color 值不对
    unlet g:last_color
    return Lilydjwg_colorpicker()
  else
    let g:last_color = color
    return color
  endif
endfunction
inoremap <M-c> <C-R>=Lilydjwg_colorpicker()<CR>


" 在浏览器预览 for win32 -- 命令模式下 F4(c,f,o,i)
function! ViewInBrowser(name)
    let file = expand("%:p")
    exec ":update " . file
    let l:browsers = {
        \"cr":"C:/progra~2/Google/Chrome/Application/chrome.exe",
        \"ff":"C:/progra~2/Mozill~1/firefox.exe",
        \"op":"C:/progra~2/Opera/opera.exe",
        \"ie":"C:/progra~2/intern~1/iexplore.exe",
        \"ie6":"C:/progra~2/Cor~1/IETester/IETester.exe -ie6",
        \"ie7":"C:/progra~2/Cor~1/IETester/IETester.exe -ie7",
        \"ie8":"C:/progra~2/Cor~1/IETester/IETester.exe -ie8",
        \"ie9":"C:/progra~2/Cor~1/IETester/IETester.exe -ie9",
        \"ie10":"C:/progra~2/Cor~1/IETester/IETester.exe -ie10",
        \"iea":"C:/progra~2/Cor~1/IETester/IETester.exe -all"
    \}
    let htdocs='D:\\doc\\'
    let strpos = stridx(file, substitute(htdocs, '\\\\', '\', "g"))
    if strpos == -1
       exec ":silent !start ". l:browsers[a:name] ." file://" . file
    else
        let file=substitute(file, htdocs, "http://127.0.0.1/", "g")
        let file=substitute(file, '\\', '/', "g")
        exec ":silent !start ". l:browsers[a:name] file
    endif
endfunction
nmap <f4>c :call ViewInBrowser("cr")<cr>
nmap <f4>f :call ViewInBrowser("ff")<cr>
nmap <f4>o :call ViewInBrowser("op")<cr>
nmap <f4>i :call ViewInBrowser("ie")<cr>
nmap <f4>ie6 :call ViewInBrowser("ie6")<cr>

" -----------------------------------------------------------------------------
"  < 其它配置 >
" -----------------------------------------------------------------------------
set writebackup                             "保存文件前建立备份，保存成功后删除该备份
set nobackup                                "设置无备份文件
set noswapfile                              "设置无临时文件
set vb t_vb=                                "关闭提示音
set novisualbell                            "不要闪烁
set noerrorbells                            " 关闭错误声音




" =============================================================================
"                          << 以下为常用插件配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < a.vim 插件配置 >
" -----------------------------------------------------------------------------
" 用于切换C/C++头文件
" :A     ---切换头文件并独占整个窗口
" :AV    ---切换头文件并垂直分割窗口
" :AS    ---切换头文件并水平分割窗口

" -----------------------------------------------------------------------------
"  < Align 插件配置 >
" -----------------------------------------------------------------------------
" 一个对齐的插件，用来——排版与对齐代码，功能强大，不过用到的机会不多

" -----------------------------------------------------------------------------
"  < auto-pairs 插件配置 >
" -----------------------------------------------------------------------------
" 用于括号与引号自动补全，不过会与函数原型提示插件echofunc冲突
" 所以我就没有加入echofunc插件
" inoremap = <space>=<space> <ESC>a
" let g:AutoPairsFlyMode = 1

" -----------------------------------------------------------------------------
"  < BufExplorer 插件配置 >
" -----------------------------------------------------------------------------
" 快速轻松的在缓存中切换（相当于另一种多个文件间的切换方式）
" <Leader>be 在当前窗口显示缓存列表并打开选定文件
" <Leader>bs 水平分割窗口显示缓存列表，并在缓存列表窗口中打开选定文件
" <Leader>bv 垂直分割窗口显示缓存列表，并在缓存列表窗口中打开选定文件

" -----------------------------------------------------------------------------
"  < ccvext.vim 插件配置 >
" -----------------------------------------------------------------------------
" 用于对指定文件自动生成tags与cscope文件并连接
" 如果是Windows系统, 则生成的文件在源文件所在盘符根目录的.symbs目录下(如: X:\.symbs\)
" 如果是Linux系统, 则生成的文件在~/.symbs/目录下
" 具体用法可参考www.vim.org中此插件的说明
" <Leader>sy 自动生成tags与cscope文件并连接
" <Leader>sc 连接已存在的tags与cscope文件

" -----------------------------------------------------------------------------
"  < cSyntaxAfter 插件配置 >
" -----------------------------------------------------------------------------
" 高亮括号与运算符等
" au! BufRead,BufNewFile,BufEnter *.{c,cpp,css,h,html,javascript,php} call CSyntaxAfter()

" -----------------------------------------------------------------------------
"  < CtrlP 插件配置 >
" -----------------------------------------------------------------------------
"
let g:ctrlp_map = ',,'
let g:ctrlp_open_multiple_files = 'v'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.rar
let g:ctrlp_custom_ignore = {
	\'dir': '\v[\/]\.(git|svn)$',
	\'file': '\v\.(log|jpg|png|jpeg)$',
	\}



" -----------------------------------------------------------------------------
"  < indentLine 插件配置 >
" -----------------------------------------------------------------------------
" 用于显示对齐线，与 indent_guides 在显示方式上不同，根据自己喜好选择了
" 在终端上会有屏幕刷新的问题，这个问题能解决就更好了
" 开启/关闭对齐线
nmap <leader>il :IndentLinesToggle<CR>
" let g:indent_guides_guide_size = 0

" 设置Gvim的对齐线样式
if g:isGUI
    let g:indentLine_first_char = "┊"
    let g:indentLine_char = "┊"
    " 设置 GUI 对齐线颜色
    let g:indentLine_color_gui = '#284954'
endif

" 设置终端对齐线颜色
" let g:indentLine_color_term = 239


" -----------------------------------------------------------------------------
"  < Mark--Karkat（也就是 Mark） 插件配置 >
" -----------------------------------------------------------------------------
" 给不同的单词高亮，表明不同的变量时很有用，详细帮助见 :h mark.txt

"  -----------------------------------------------------------------------------
"   < MiniBufExplorer 插件配置 >
"  -----------------------------------------------------------------------------
"  快速浏览和操作Buffer
"  主要用于同时打开多个文件并相与切换

"  let g:miniBufExplMapWindowNavArrows = 1     "用Ctrl加方向键切换到上下左右的窗口中去
" let g:miniBufExplMapWindowNavVim = 1        "用<C-k,j,h,l>切换到上下左右的窗口中去
" let g:miniBufExplMapCTabSwitchBufs = 1      "功能增强（不过好像只有在Windows中才有用）
"                                             <C-Tab> 向前循环切换到每个buffer上,并在当前窗口打开
"                                             <C-S-Tab> 向后循环切换到每个buffer上,并在当前窗口打开

" 在不使用 MiniBufExplorer 插件时也可用<C-k,j,h,l>切换到上下左右的窗口中去
" noremap <c-k> <c-w>k
" noremap <c-j> <c-w>j
" noremap <c-h> <c-w>h
" noremap <c-l> <c-w>l

" -----------------------------------------------------------------------------
"  < neocomplcache 插件配置 >
" -----------------------------------------------------------------------------
" 关键字补全、文件路径补全、tag补全等等，各种，非常好用，速度超快。
let g:neocomplcache_enable_at_startup = 1     "vim 启动时启用插件
let g:neocomplcache_disable_auto_complete = 1 "不自动弹出补全列表
" 在弹出补全列表后用 <c-p> 或 <c-n> 进行上下选择效果比较好

" -----------------------------------------------------------------------------
"  < nerdcommenter 插件配置 >
" -----------------------------------------------------------------------------
" 我主要用于C/C++代码注释(其它的也行)，这个插件我做了小点修改，也就是在注释符
" 与注释内容间加一个空格
" 以下为插件默认快捷键，其中的说明是以C/C++为例的
" <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
" <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
" <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
" <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
" <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
" <Leader>cA 行尾注释
let NERDSpaceDelims = 1                     "在左注释符之后，右注释符之前留有空格

" -----------------------------------------------------------------------------
"  < nerdtree 插件配置 >
" -----------------------------------------------------------------------------
" 有目录村结构的文件浏览插件
let g:nerdtree_tabs_open_on_console_startup=0       "设置打开vim的时候默认打开目录树
let g:nerdtree_tabs_open_on_gui_startup=0

let NERDTreeMinimalUI=1     "默认不显示 ？帮助
let NERDTreeDirArrows=1     "显示特殊分割字符
let NERDTreeMouseMode=3     "鼠标点击模式

" 常规模式下输入 F2 调用插件
nmap <F2> :NERDTreeToggle<CR>


" -----------------------------------------------------------------------------
"  < omnicppcomplete 插件配置 >
" -----------------------------------------------------------------------------
" 用于C/C++代码补全，这种补全主要针对命名空间、类、结构、共同体等进行补全，详细
" 说明可以参考帮助或网络教程等
" 使用前先执行如下 ctags 命令（本配置中可以直接使用 ccvext 插件来执行以下命令）
" ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
" 我使用上面的参数生成标签后，对函数使用跳转时会出现多个选择
" 所以我就将--c++-kinds=+p参数给去掉了，如果大侠有什么其它解决方法希望不要保留呀
set complete=.,w,b,k,t,i                                " 自动完成
"set completeopt=menu,preview,longest                    "关闭预览窗口

" -----------------------------------------------------------------------------
"  < airline 插件配置 >
" -----------------------------------------------------------------------------
" 状态栏插件，更好的状态栏效果
"  let g:airline_theme='laederon'
"  let g:airline_theme='tomorrow'
"  let g:airline_theme='luna'
"  let g:airline_theme='solarized'
"  let g:airline_theme='badwolf'
  let g:airline_theme='powerlineish'
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
"  let g:airline_enable_syntstic = 1
"  let g:girline_enable_branch = 1
"  let g:airline_exclude_preview = 1
"  set noshowmode
"  let g:bufferline = 0
 let g:airline_detect_whitespace = 0



" -----------------------------------------------------------------------------
"  < repeat 插件配置 >
" -----------------------------------------------------------------------------
" 主要用"."命令来重复上次插件使用的命令

" -----------------------------------------------------------------------------
"  < snipMate 插件配置 >
" -----------------------------------------------------------------------------
" 用于各种代码补全，这种补全是一种对代码中的词与代码块的缩写补全，详细用法可以参
" 考使用说明或网络教程等。不过有时候也会与 supertab 插件在补全时产生冲突，如果大
" 侠有什么其它解决方法希望不要保留呀

" -----------------------------------------------------------------------------
"  < SrcExpl 插件配置 >
" -----------------------------------------------------------------------------
" 增强源代码浏览，其功能就像Windows中的"Source Insight"
" :SrcExpl                                   "打开浏览窗口
" :SrcExplClose                              "关闭浏览窗口
" :SrcExplToggle                             "打开/闭浏览窗口

" -----------------------------------------------------------------------------
"  < supertab 插件配置 >
" -----------------------------------------------------------------------------
" 我主要用于配合 omnicppcomplete 插件，在按 Tab 键时自动补全效果更好更快
" let g:supertabdefaultcompletiontype = "<c-x><c-u>"

" -----------------------------------------------------------------------------
"  < std_c 插件配置 >
" -----------------------------------------------------------------------------
" 用于增强C语法高亮

" 启用 // 注视风格
let c_cpp_comments = 0

" -----------------------------------------------------------------------------
"  < surround 插件配置 >
" -----------------------------------------------------------------------------
" 快速给单词/句子两边增加符号（包括html标签），缺点是不能用"."来重复命令
" 不过 repeat 插件可以解决这个问题，详细帮助见 :h surround.txt

" -----------------------------------------------------------------------------
"  < Syntastic 插件配置 >
" -----------------------------------------------------------------------------
" 用于保存文件时查检语法
"let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_checkers = ['php','phpmd']
"let g:syntastic_javascript_checkers = ['closurecompiler', 'jshint', 'jslint', 'jsl', 'gjslint']

" let g:syntastic_check_on_open = 1
"let g:syntastic_enable_signs = 1
"let g:syntastic_debug = 1


" -----------------------------------------------------------------------------
"  < Tagbar 插件配置 >
" -----------------------------------------------------------------------------
" 相对 TagList 能更好的支持面向对象

" 常规模式下输入 tb 调用插件，如果有打开 TagList 窗口则先将其关闭
nmap tb :TlistClose<cr>:TagbarToggle<cr>

let g:tagbar_width=30                       "设置窗口宽度
" let g:tagbar_left=1                         "在左侧窗口中显示
let g:tagbar_expand = 2                     "以扩展窗口的方式打开

" tagbar-phpctags
let g:tagbar_phpctags_bin='C:\Program\ Files\ (x86)\Vim\vimfiles\bundle\tagbar-phpctags.vim\plugin\'
let g:tagbar_phpctags_memory_limit = '512M'

" tagbar gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


" -----------------------------------------------------------------------------
"  < TagList 插件配置 >
" -----------------------------------------------------------------------------
" 高效地浏览源码, 其功能就像vc中的workpace
" 那里面列出了当前文件中的所有宏,全局变量, 函数名等

" 常规模式下输入 tl 调用插件，如果有打开 Tagbar 窗口则先将其关闭
nmap tl :TagbarClose<cr>:Tlist<cr>

let Tlist_Show_One_File=1                   "只显示当前文件的tags
let Tlist_Enable_Fold_Column=0              "使taglist插件不显示左边的折叠行
let Tlist_Exit_OnlyWindow=1                 "如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_File_Fold_Auto_Close=1            "自动折叠
let Tlist_WinWidth=30                       "设置窗口宽度
let Tlist_Use_Right_Window=1                "在右侧窗口中显示

" -----------------------------------------------------------------------------
"  < txtbrowser 插件配置 >
" -----------------------------------------------------------------------------
" 用于文本文件生成标签与与语法高亮（调用TagList插件生成标签，如果可以）
au BufRead,BufNewFile *.txt setlocal ft=txt

"  -----------------------------------------------------------------------------
"   < WinManager 插件配置 >
"  -----------------------------------------------------------------------------
"  管理各个窗口, 或者说整合各个窗口

"  常规模式下输入 F3 调用插件
 nmap <F3> :WMToggle<cr>

" 这里可以设置为多个窗口, 如'FileExplorer|TagList'
let g:winManagerWindowLayout='FileExplorer'

let g:persistentBehaviour=0                 "只剩一个窗口时, 退出vim
let g:winManagerWidth=30                    "设置窗口宽度

" -----------------------------------------------------------------------------
"  < ZoomWin 插件配置 >
" -----------------------------------------------------------------------------
" 用于分割窗口的最大化与还原
" 快捷键 <c-w>o 在最大化与还原间切换

" =============================================================================
"                          << 以下为常用工具配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < cscope 工具配置 >
" -----------------------------------------------------------------------------
" 用Cscope自己的话说 - "你可以把它当做是超过频的ctags"
if has("cscope")
    "设定可以使用 quickfix 窗口来查看 cscope 结果
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    "使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
    set cscopetag
    "如果你想反向搜索顺序设置为1
    set csto=0
    "在当前目录中添加任何数据库
    if filereadable("cscope.out")
        cs add cscope.out
    "否则添加数据库环境中所指出的
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set cscopeverbose
    "快捷键设置
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

" -----------------------------------------------------------------------------
"  < ctags 工具配置 >
" -----------------------------------------------------------------------------
" 对浏览代码非常的方便,可以在函数,变量之间跳转等
set tags=./tags;                            "向上级目录递归查找tags文件（好像只有在Windows下才有用）

"Ctrl + F12删除&&更新tags文件
function! DeleteTagsFile()
    "Linux下的删除方法
    "silent !rm tags
    "Windows下的删除方法
    silent !del /F /Q tags
    silent !ctags -R --languages=php,c --c-kinds=+p --fields=+ianS --extra=+q
endfunction
nmap <C-F12> :call DeleteTagsFile()<CR>
"退出VIM之前删除tags文件
"au VimLeavePre * call DeleteTagsFile()

" -----------------------------------------------------------------------------
"  < fencview 自动识别编码工具配置 >
" -----------------------------------------------------------------------------
let g:fencview_auto_patterns='*'
let g:fencview_autodetect = 0		"打开文件时自动识别编码
let g:fencview_checklines = 10		"检查前后10行来判断编码


" -----------------------------------------------------------------------------
"  < gvimfullscreen 工具配置 > 请确保已安装了工具
" -----------------------------------------------------------------------------
" 用于 Windows Gvim 全屏窗口，可用 F11 切换
" 全屏后再隐藏菜单栏、工具栏、滚动条效果更好
"
" {{{ Win平台下窗口全屏组件 gvimfullscreen.dll
" Alt + Enter 全屏切换
" Shift + t 降低窗口透明度
" Shift + y 加大窗口透明度
" Shift + r 切换Vim是否总在最前面显示
" Vim启动的时候自动使用当前颜色的背景色以去除Vim的白色边框
if has('gui_running') && has('gui_win32') && has('libcall')
    let g:MyVimLib = 'gvimfullscreen.dll'

    function! ToggleFullScreen()
        call libcall(g:MyVimLib, 'ToggleFullScreen', 1)
    endfunction

    let g:VimAlpha = 245
    function! SetAlpha(alpha)
        let g:VimAlpha = g:VimAlpha + a:alpha
        if g:VimAlpha < 180
            let g:VimAlpha = 180
        endif
        if g:VimAlpha > 255
            let g:VimAlpha = 255
        endif
        call libcall(g:MyVimLib, 'SetAlpha', g:VimAlpha)
    endfunction

    let g:VimTopMost = 0
    function! SwitchVimTopMostMode()
        if g:VimTopMost == 0
            let g:VimTopMost = 1
        else
            let g:VimTopMost = 0
        endif
        call libcall(g:MyVimLib, 'EnableTopMost', g:VimTopMost)
    endfunction
    "映射 Alt+Enter 切换全屏vim
    map <f11> <esc>:call ToggleFullScreen()<cr>
    "切换Vim是否在最前面显示
    nmap <s-r> <esc>:call SwitchVimTopMostMode()<cr>
    "增加Vim窗体的不透明度
    "nmap <s-t> <esc>:call SetAlpha(10)<cr>
    "增加Vim窗体的透明度
    "nmap <s-y> <esc>:call SetAlpha(-10)<cr>
    " 默认设置透明
    autocmd GUIEnter * call libcallnr(g:MyVimLib, 'SetAlpha', g:VimAlpha)
endif
" }}}


" ============================================================================
"                               << Emmet >>
" ============================================================================
let g:user_emmet_mode = 'a'    "enable all function in all mode.
let g:user_emmet_expandabbr_key = '<c-e>'

  let g:user_emmet_settings = {
  \  'lang' : 'en',
  \  'indentation' : '    ',
  \  'html' : {
  \    'filters' : 'html',
  \    'indentation' : '    '
  \  },
  \  'perl' : {
  \    'indentation' : '    ',
  \    'aliases' : {
  \      'req' : "require '|'"
  \    },
  \    'snippets' : {
  \      'use' : "use strict\nuse warnings\n\n",
  \      'w' : "warn \"${cursor}\";",
  \    },
  \  },
  \  'php' : {
  \    'extends' : 'html',
  \    'filters' : 'html,c',
  \  },
  \  'css' : {
  \    'filters' : 'fc',
  \  },
  \  'javascript' : {
  \    'snippets' : {
  \      'jq' : "$(function() {\n\t${cursor}${child}\n});",
  \      'jq:each' : "$.each(arr, function(index, item)\n\t${child}\n});",
  \      'fn' : "(function() {\n\t${cursor}\n})();",
  \      'tm' : "setTimeout(function() {\n\t${cursor}\n}, 100);",
  \    },
  \  },
  \ 'java' : {
  \  'indentation' : '    ',
  \  'snippets' : {
  \   'main': "public static void main(String[] args) {\n\t|\n}",
  \   'println': "System.out.println(\"|\");",
  \   'class': "public class | {\n}\n",
  \  },
  \ },
  \}

" -----------------------------------------------------------------------------
"  << vimwiki >>
" -----------------------------------------------------------------------------
" 多个维基项目的配置
let g:vimwiki_use_mouse = 1
let g:vimwiki_list = [{'path': 'D:/Document/vimwiki/',
\ 'path_html': 'D:/Document/vimwiki/html/',
\ 'html_header': 'D:/Document/vimwiki/template/header.htm',
\ 'html_footer': 'D:/Document/vimwiki/template/footer.htm',
\ 'syntax': 'markdown',
\ 'auto_export': 0,
\ 'diary_link_count': 5}]

" 是否在词条文件保存时就输出html，慢，需要的话就把这一行复制到上面面去
"     \ 'auto_export': 1,
" 使用markdown语法
"   \ 'syntax': 'markdown',
let g:vimwiki_use_mouse = 1
" 对中文用户来说，我们并不怎么需要驼峰英文成为维基词条
let g:vimwiki_camel_case = 0
" 标记为完成的 checklist 项目会有特别的颜色
let g:vimwiki_hl_cb_checked = 1
" 我的 vim 是没有菜单的，加一个 vimwiki 菜单项也没有意义
let g:vimwiki_menu = ''
" 是否开启按语法折叠  会让文件比较慢
"let g:vimwiki_folding = 1
" 是否在计算字串长度时用特别考虑中文字符
let g:vimwiki_CJK_length = 1
" 生成HTML的目录下手工hack的html文件不被自动删除
let g:vimwiki_user_htmls = 'contact.html, canvas-1.html, html.html'
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1'
" 设置Vimwiki支持的文件后缀
" let g:vimwiki_file_exts = 'c, cpp, wav, txt, h, hpp, zip, sh, awk, ps, php, py, pdf'
let g:vimwiki_file_exts = 'wiki'
let g:vimwiki_use_calendar = 0
map <F5> <Plug>Vimwiki2HTML
map <S-F5> <Plug>VimwikiAll2HTML

" -----------------------------------------------------------------------------
"  << calendar-vim >>
" -----------------------------------------------------------------------------
let g:calendar_diary = "D:/Document/notes/diary"  " 设置日记的存储路径
let g:calendar_monday = 1           " 以星期一为开始
" let g:calendar_sun = 1           " 以星期日为开始
let g:calendar_focus_today = 1      " 光标在当天的日期上
"let g:calendar_mark = 'left-fit' "可以让*和数字可靠近
let g:calendar_mark = 'right' "可以让*和数字可靠近
let g:calendar_mruler = '一月,二月,三月,四月,五月,六月,七月,八月,九月,十月,十一月,十二月'
let g:calendar_wruler = '日 一 二 三 四 五 六'
let g:calendar_navi_label = '向前,今日,向后'
map <F8> :Calendar<cr>              " 快捷键，默认 <leader>cal,水平方向：<leader>caL


" -----------------------------------------------------------------------------
"  << phpcomplete >>
" -----------------------------------------------------------------------------
let g:phpcomplete_relax_static_constraint = 1
let g:phpcomplete_complete_for_unknown_classes = 1
let g:phpcomplete_min_num_of_chars_for_namespace_completion = 3 " Requires patched ctags
let g:phpcomplete_parse_docblock_comments = 1	" include information extracted from docblock comments of the completions


" =============================================================================
"                          << vim-multiple-cursors >>
" =============================================================================
" Default mapping
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_start_key='<F6>'
" Setting
let g:multi_cursor_exit_from_visual_mode = 1
let g:multi_cursor_exit_from_insert_mode = 1
" Highlight
"highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
"highlight link multiple_cursors_visual Visual

" =============================================================================
"                          << vim-smooth-scroll >>
" =============================================================================
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" =============================================================================
"                          << 以下为常用自动命令配置 >>
" =============================================================================

" 自动切换目录为当前编辑文件所在目录
au BufRead,BufNewFile,BufEnter * cd %:p:h

" =============================================================================
"                          << 其它 >>
" =============================================================================
" 默认为“\”， 重新定义，前两个会出现卡顿2014.3.2
"let mapleader = "`"
"let g:mapleader="`"
"let maplocalleader = ","
" 注：上面配置中的"<Leader>"在本软件中设置为","键（引号里的反斜杠），如<Leader>t
" 指在常规模式下按","键加"t"键，这里不是同时按，而是先按","键后按"t"键，间隔在一
" 秒内，而<Leader>cs是先按","键再按"c"又再按"s"键


" -----------------------------------------------------------------------------
"  << Markdown >>
" -----------------------------------------------------------------------------
nnoremap <F7> :!cmd /c c:\Bin\Python33\python c:\Bin\Python33\Scripts\markdown %:t > %:r.html<CR>
noremap <leader>e  :!cmd /c start ./%:r.html<CR>



" For Haskell
let hs_highlight_delimiters=1            " 高亮定界符
let hs_highlight_boolean=1               " 把True和False识别为关键字
let hs_highlight_types=1                 " 把基本类型的名字识别为关键字
let hs_highlight_more_types=1            " 把更多常用类型识别为关键字
let hs_highlight_debug=1                 " 高亮调试函数的名字
let hs_allow_hash_operator=1             " 阻止把#高亮为错误

"blank      空白
"buffers    缓冲区
"curdir     当前目录
"folds      折叠
"help       帮助
"options    选项
"tabpages   选项卡
"winsize    窗口大小
"slash      转换文件路径中的\为/以使session文件兼容unix
"unix       设置session文件中的换行模式为unix
set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize,slash,unix,resize

"进入当前编辑的文件的目录
autocmd BufEnter * exec "cd %:p:h"

" 与windows共享剪贴板
set clipboard+=unnamed

" 解决自动换行格式下, 如高度在折行之后超过窗口高度结果这一行看不到的问题
set display=lastline

" 上下可视行数
set scrolloff=5

" 启动时自动进入插入模式
"exe "startinsert"

" 不在最后添加新行
" set noendofline binary

"改变VIm默认路径
cd d:\doc\


"括号自动补全
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<CR>}<Esc>O
"autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endf

function CloseBracket()
  if match(getline(line('.') + 1), '\s*}') < 0
    return "\<CR>}"
  else
    return "\<Esc>j0f}a"
  endif
endf

function QuoteDelim(char)
  let line = getline('.')
  let col = col('.')
  if line[col - 2] == "\\"
    "Inserting a quoted quotation mark into the string
    return a:char
  elseif line[col - 1] == a:char
    "Escaping out of the string
    return "\<Right>"
  else
    "Starting a string
    return a:char.a:char."\<Esc>i"
  endif
endf

" auto save vim session
"
" GO语言 文件保存前，调用goimports排版并插入/删除相应的import语句
" autocmd BufWritePre *.go :Fmt

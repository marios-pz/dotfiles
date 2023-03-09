" Yank to system clipboard
set clipboard=unnamed

" Set ignore case
" set ignorecase=true
"set smartcase=true

" Have j and k navigate visual lines rather than logical ones
"nmap j gj
"nmap k gk
nmap Y y$ " Better yank

unmap <Space>                   " Require by <Space>

exmap back obcommand app:go-back
exmap forward obcommand app:go-forward 
exmap followLink :obcommand editor:follow-link
exmap toggleFold :obcommand editor:toggle-fold
exmap foldAll :obcommand editor:fold-all
exmap unfoldAll :obcommand editor:unfold-all
exmap switcher :obcommand switcher:open
exmap saveFile :obcommand editor:save-file
exmap focusBottom :obcommand editor:focus-bottom
exmap focusTop :obcommand editor:focus-top
exmap focusLeft :obcommand editor:focus-left
exmap focusRight :obcommand editor:focus-right
exmap togglePin :obcommand workspace:toggle-pin
exmap closeFile :obcommand workspace:close
exmap globalSearch :obcommand global-search:open
exmap toggleLeftSidebar :obcommand app:toggle-left-sidebar
exmap toggleRightSidebar :obcommand app:toggle-right-sidebar
exmap toggleComments :obcommand editor:toggle-comments
exmap insertTemplate :obcommand insert-template
exmap insertLink :obcommand editor:insert-link
exmap insertEmbed :obcommand editor:insert-embed
exmap toggleUnorderedList :obcommand editor:toggle-bullet-list
exmap toggleOrderedList :obcommand editor:toggle-numbered-list
exmap verticalSplit :obcommand workspace:split-vertical
exmap horizontalSplit :obcommand workspace:split-horizontal

nmap <C-o> :back               "C-o was open file
nmap <C-i> :forward            "C-i was toggle italics
nmap za :toggleFold
nmap zM :foldAll
nmap zR :unfoldAll
nmap gi :followLink
nmap <Space>f :switcher
nmap <Space>w :saveFile
nmap <C-j> :focusBottom
nmap <C-k> :focusTop           "C-k was insert markdown link
nmap <C-h> :focusLeft
nmap <C-l> :focusRight
nmap <Space>pi :togglePin
nmap <Space>c :closeFile
nmap <Space>F :globalSearch
nmap <Space>e :toggleLeftSidebar
nmap <Space>E :toggleRightSidebar
nmap <Space>/ :toggleComments
nmap <Space>it :insertTemplate
nmap <Space>il :insertLink
nmap <Space>ie :insertEmbed
nmap <Space>iul :toggleUnorderedList
nmap <Space>iol :toggleOrderedList
nmap <C-w>v :verticalSplit
nmap <C-w>s :horizontalSplit
" Available commands: 
" file-explorer:open
" editor:open-link-in-new-leaf
" workspace:edit-file-title
" workspace:copy-path
" workspace:copy-url
" workspace:undo-close-pane
" workspace:export-pdf
" editor:rename-heading
" sliding-panes-obsidian:toggle-sliding-panes
" sliding-panes-obsidian:toggle-sliding-panes-smooth-animation
" sliding-panes-obsidian:toggle-sliding-panes-leaf-auto-width
" sliding-panes-obsidian:toggle-sliding-panes-stacking
" sliding-panes-obsidian:toggle-sliding-panes-rotated-headers
" sliding-panes-obsidian:toggle-sliding-panes-header-alt
" app:open-vault
" theme:use-dark
" theme:use-light
" app:open-settings
" markdown:toggle-preview
" workspace:close-others
" app:delete-file
" app:toggle-default-new-pane-mode
" app:open-help
" app:reload
" app:show-debug-info
" file-explorer:new-file
" file-explorer:new-file-in-new-pane
" editor:open-search
" editor:open-search-replace
" editor:focus
" editor:insert-wikilink
" editor:insert-link
" editor:insert-tag
" editor:set-heading
" editor:toggle-bold
" editor:toggle-italics
" editor:toggle-strikethrough
" editor:toggle-highlight
" editor:toggle-code
" editor:toggle-blockquote

" editor:toggle-checklist-status
" editor:swap-line-up
" editor:swap-line-down
" editor:attach-file
" editor:delete-paragraph
" editor:toggle-spellcheck
" file-explorer:reveal-active-file
" file-explorer:move-file
" graph:open
" graph:open-local
" graph:animate
" backlink:open
" backlink:open-backlinks
" backlink:toggle-backlinks-in-document
" note-composer:merge-file
" note-composer:split-file
" note-composer:extract-heading
" command-palette:open
" starred:open
" starred:star-current-file
" markdown-importer:open
" open-with-default-app:open
" open-with-default-app:show
" file-recovery:open
" editor:toggle-source



" Vim syntax file
" Language:    TracWiki (Trac 1.0 wiki formatting)
" Reference:   https://trac.edgewall.org/wiki/1.0/WikiFormatting
" Filetype:    tracwiki

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case match

" --- Inline text styles -------------------------------------------------------
" When two regions start at the same column the one defined LAST wins, so the
" shortest markers come first: '' < ''' < '''''.
syn region tracItalic     start=/''/    end=/''/    oneline contains=tracBold,tracEscape
syn region tracBold       start=/'''/   end=/'''/   oneline contains=tracItalic,tracEscape
syn region tracBoldItalic start=/'''''/ end=/'''''/ oneline contains=tracEscape
syn region tracUnderline  start=/__/    end=/__/    oneline contains=tracBold,tracItalic,tracEscape
syn region tracStrike     start=/\~\~/  end=/\~\~/  oneline contains=tracBold,tracItalic,tracEscape
syn region tracSuper      start=/\^\S\@=/ end=/\S\@<=\^/ oneline
syn region tracSub        start=/,,\S\@=/ end=/\S\@<=,,/ oneline

" Inline monospace: `text` and {{{text}}} (markup inside is not interpreted)
syn region tracCode       start=/`/     end=/`/     oneline
syn region tracCode       start=/{{{/   end=/}}}/   oneline

" Explicit line break
syn match  tracLineBreak  /\\\\/

" --- Escapes (!) --------------------------------------------------------------
" "!CamelCase" suppresses a wiki link; "!''" and friends suppress markup.
syn match  tracEscape     /!\%(\u\l\+\u\w*\|'\+\|_\+\|\~\+\|,\+\|{{{\|\S\)/

" --- Links and macros ---------------------------------------------------------
syn match  tracWikiWord   /\<\%(\u\l\+\)\{2,}\w*\>/
syn match  tracUrl        =\<\%(https\?\|ftp\)://[^[:space:]<>\]]\+=
syn match  tracTicket     /#\d\+\>/

" [target label]: only bracket forms whose target looks like a link
syn region tracLink       matchgroup=tracLinkDelim start=/\[\ze\%(\a[[:alnum:]+.-]*:\|[/#.]\|\u\l\+\u\)/ end=/\]/ oneline contains=tracLinkTarget
syn match  tracLinkTarget /\%(\[\)\@1<=\S\+/ contained
" [[macro]], [[Image(...)]], [[url|label]]
syn region tracMacro      start=/\[\[/  end=/\]\]/  oneline

" --- Block structure ----------------------------------------------------------
" Headings: "= Title =", "== Title == #anchor"
syn match  tracHeading    /^=\{1,6}\s.*$/ contains=tracEscape,tracCode,tracMacro,tracLink,tracAnchor
syn match  tracAnchor     /\s\zs#\S\+\s*$/ contained

syn match  tracRule       /^----\+\s*$/

" Lists: " * item", " 1. item", " a. item", " iv. item", " term:: definition"
syn match  tracListMarker /^\s*\%([-*]\|\d\+\.\|\a\.\|[ivxIVX]\{2,5}\.\)\s\@=/
syn match  tracDefTerm    /^\s\+\zs.\{-}\ze::\%(\s\|$\)/

" Citation / quoted reply: "> text"
syn match  tracQuote      /^>\+\s.*$/ contains=tracBold,tracItalic,tracCode,tracEscape

" Tables: ||cell||= header =||
syn match  tracTableSep   /||/
syn match  tracTableHead  /\%(||\)\@2<==[^|]\{-}=\ze\s*||/

" Preformatted blocks: {{{ ... }}} and {{{#!processor ... }}}
syn region tracCodeBlock  start=/^\s*{{{\s*$/ start=/^\s*{{{#!/ end=/^\s*}}}\s*$/ keepend contains=tracProcessor
syn match  tracProcessor  /#!\S\+.*$/ contained

syn sync fromstart

" --- Highlight groups ---------------------------------------------------------
hi def tracItalic     term=italic      cterm=italic                gui=italic
hi def tracBold       term=bold        cterm=bold                  gui=bold
hi def tracBoldItalic term=bold,italic cterm=bold,italic           gui=bold,italic
hi def tracUnderline  term=underline   cterm=underline             gui=underline
hi def tracStrike     term=strikethrough cterm=strikethrough       gui=strikethrough

hi def link tracSuper       Special
hi def link tracSub         Special
hi def link tracCode        String
hi def link tracCodeBlock   String
hi def link tracProcessor   PreProc
hi def link tracLineBreak   Special
hi def link tracEscape      SpecialChar
hi def link tracWikiWord    Underlined
hi def link tracUrl         Underlined
hi def link tracTicket      Identifier
hi def link tracLinkDelim   Delimiter
hi def link tracLinkTarget  Underlined
hi def link tracMacro       Macro
hi def link tracHeading     Title
hi def link tracAnchor      Identifier
hi def link tracRule        Delimiter
hi def link tracListMarker  Statement
hi def link tracDefTerm     Identifier
hi def link tracQuote       Comment
hi def link tracTableSep    Delimiter
hi def link tracTableHead   Title

let b:current_syntax = "tracwiki"

let &cpo = s:cpo_save
unlet s:cpo_save

" TODO Add Error highlight, add every possible key
" TODO change \S to alphanum + punctuation + "symbolic" (?) (check source) or utilize iskeyword

if exists('b:current_syntax')
  finish
endif

" To match kmonadOperator only in operator position, wrap it in
" kmonadOperatorContainer.
syn match   kmonadOperatorContainer "^\S\+\s\(=\)\s" contains=@kmonadLHS,kmonadOperator

syn match   kmonadOperator "=" contained
hi def link kmonadOperator Operator

" Using kmonadLHS as a wrapper for kmonadIO + kmonadAliasContained, however
" latter gets overridden by kmonadAlias, so for now we leave it out.
" It is canonic to only allow aliases in the LHS.
syn cluster kmonadLHS contains=kmonadIO,kmonadAliasContained

syn keyword kmonadIO contained INPUT OUTPUT
hi def link kmonadIO Constant

" TODO kmonadAlias overrides kmonadOperatorContainer; possible solution is to
" create kmonadKeyboard zone and contain kmonadAlias
syn match kmonadAlias '@\S\+' containedin=TOP
syn match kmonadAliasContained '@\S\+' contained

hi def link kmonadAliasContained Identifier
hi def link kmonadAlias Identifier

" TODO Alpha-numeric layer names after LAYER keyword
syn match kmonadLayer '^\(LAYER\|SRC\)'
hi def link kmonadLayer Type

syn keyword kmonadTodo contained TODO FIXME XXX NOTE BUG
hi def link kmonadTodo Todo

syn cluster kmonadCommentGroup contains=kmonadTodo
syn region  kmonadComment start="/\*" end="\*/" contains=@kmonadCommentGroup,@Spell
syn region  kmonadComment start="//" end="$" contains=@kmonadCommentGroup,@Spell
hi def link kmonadComment Comment

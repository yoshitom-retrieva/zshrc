autoload -U compinit
compinit
export LANG=ja_JP.UTF-8

bindkey -v

# auto directory pushd that you can get dirs list by cd - [tab]
setopt auto_pushd

setopt correct

# バックグラウンドジョブが終わったらすぐ知らせる
setopt no_tify

# 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1

# --prefix=/usr などの = 以降も補完
setopt magic_equal_subst

# 補完候補を一覧表示
setopt auto_list

#補完候補一覧でファイルの種別を識別マーク表示(ls -F の記号)
setopt list_types

# 補完結果を詰める
setopt list_packed

# auto change directory
setopt auto_cd

# http://d.hatena.ne.jp/tsaka/20060819/1162739565

# Prediction cofiguration
autoload predict-on
#predict-on

# 補完キー(Tab,Ctrl+I) を連打するだけで順に補完を自動で補完
setopt auto_menu

# sudo でも補完の対照
zstyle ':completione:*:sudo:*' command-path /usr/local/sbin /usr/local/bin/ /usr/sbin /usr/bin /bin /opt/local/bin/
# cd の後 ls も実行

###############################################
# 履歴関係                                    #
###############################################
# ヒストリー機能
HISTFILE=~/.zsh_history      # ヒストリファイルを指定
HISTSIZE=10000               # ヒストリに保存するコマンド数
SAVEHIST=10000               # ヒストリファイルに保存するコマンド数
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt share_history         # コマンド履歴ファイルを共有する
setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt hist_no_store         # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks    # 余分な空白は詰めて記録
#setopt hist_ignore_space    # 先頭がスペースの場合、ヒストリに追加しない

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# for, repeat, select, if, function などで簡略文法が使えるようになる
setopt short_loops

setopt no_always_last_prompt

# コマンドラインがどのように展開され実行されたかを表示するようになる
#setopt xtrace

#local Green=$'%{\e[1;32m%}'
# local Red=$'%{\e[31m%}'
local Red=$'%{\e[31m%}'
local Green=$'%{\e[32m%}'
local Yellow=$'%{\e[00;33m%}'
local Blue=$'%{\e[34m%}'
local Purple=$'%{\e[35m%}'
local Cyaan=$'%{\e[36m%}'
local Grey=$'%{\e[37m%}'
local DEFAULT=$'%{\e[m%}'
local NOM_DEF=$'%{\e[00;m%}'
local BOL_DEF=$'%{\e[01;m%}'
local UNDERLINE_DEF=$'%{\e[04;m%}'
local ONOFF_DEF=$'%{\e[05;m%}'
local REVERSAL_DEF=$'%{\e[07;m%}'
local DISAPPER_DEF=$'%{\e[08;m%}'

case ${UID} in
0)
#    PROMPT="%B%{[35m%}%/#%{[m%}%b "
		PROMPT="%{$Purple%}[%n@%m]%# %{$DEFAULT%}"
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
		RPROMPT="[%d]"
    if [ -n "${REMOTEHOST}${SSH_CONNECTION}" ]; then
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    fi
    ;;
*)
#		PROMPT="%{[33m%} %m%% [m%}"
#		PROMPT="%{$prompt_color%}[%n@%m:%d]%#%{$reset_color%} "
		PROMPT="
${Red}Insert ${Cyaan}[%~%50(l.	.)]${DEFAULT}
${Yellow}%n@%m%# ${DEFAULT}"
    PROMPT2="%{[31m%}%_%%%{[m%} "
#		RPROMPT="%{$Yellow%}[%~%50(l.
#			.)]%{$DEFAULT%}"
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    if [ -n "${REMOTEHOST}${SSH_CONNECTION}" ]; then
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    fi
    ;;
esac 
# function zle-line-init zle-keymap-select {
# function  zle-keymap-select {
function  zle-keymap-select zle-line-init zle-line-finish {
	case $KEYMAP in
		vicmd)
		# PROMPT="\n%{$Blue%}Normal %{$Cyaan%}[%~%50(l.	.)]%{$DEFAULT%}\n%{$Yellow%}%n@%m%# %{$DEFAULT%}"
		PROMPT="
${Blue}Normal ${Cyaan}[%~%50(l.	.)]${DEFAULT}
${Yellow}%n@%m%# ${DEFAULT}"
			;;
		main|viins)
		# PROMPT=$'\n%{\e[31m%}Insert %{$Cyaan%}[%~%50(l.	.)]%{$DEFAULT%}'$'\n'%{$Yellow%}%n@%m%# %{$DEFAULT%}
		# PROMPT=$'\n'"%{${Red}%}Insert %{$Cyaan%}[%~%50(l.	.)]%{$DEFAULT%}"$'\n'"%{$Yellow%}%n@%m%# %{$DEFAULT%}"
		PROMPT="
${Red}Insert ${Cyaan}[%~%50(l.	.)]${DEFAULT}
${Yellow}%n@%m%# ${DEFAULT}"
			;;
	esac
	zle reset-prompt
}
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line
# http://qiita.com/b4b4r07/items/8db0257d2e6f6b19ecb9
if ! [ "$TMUX" = "" ]; then
    tmux set-option status-bg $(perl -MList::Util=sum -e'print+(red,green,blue,yellow,cyan,magenta,white)[sum(unpack"C*",shift)%7]' $(hostname)) | cat > /dev/null
fi
#http://d.hatena.ne.jp/sugyan/20120302/1330699507

# ビープ音を消す
#setopt no_beep
setopt nolistbeep
#数値順でソート
setopt numeric_glob_sort

#ログアウト時にバックグラウンドジョブをkillしない
setopt no_hup
#ログアウト時にバックグラウンドジョブを確認しない
setopt no_checkjobs
#バックグラウンドジョブが終了したら(プロンプト表示を待たずに)すぐに知らせる
#setopt notify

alias root='root -l'
alias grep='grep --color'

case "${OSTYPE}" in
darwin*)
	function chpwd() {ls -aG}
    if [ -e ~/selfcompile/.zshrc.local ];then
        source ~/selfcompile/.zshrc.local
    fi
	;;
linux*)
	#echo "linux mokyu"
	#source ~/Dropbox/LocalizingFile/.ubuntu_zshrc
	source ~/.zshrcs/.zshrc.linux
	function chpwd() {ls -a --color}
	alias open='/usr/bin/gnome-open'
	;;
esac

#http://dadeba.github.com/blog/2012/03/10/note-on-opencl-sdks/

#for selfcompile
export PATH=~/selfcompile/bin:$PATH
export PATH=~/selfcompile/bin/msrutil:$PATH
#alias python2="/opt/local/bin/python2.7"
#alias python3="/opt/local/bin/python3.3"

if [[ $(uname) = "Darwin" ]]; then
    alias ldd="echo ldd is not on OSX. use otool -L."
    alias strace="echo strace is not on OSX. use dtruss"
fi

# source ~/.zshrcs/.zshrc*
for ZSHRC in $( ls -A ~/.zshrcs/.zshrc.* | grep -vE "sw.$"); do
    source $ZSHRC
done

export EDITOR="/home/emdb/local/bin/vim"
setopt print_eight_bit

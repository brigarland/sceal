# You can set following options in your .zshrc

# OS detection
[[ -n "${OS}" ]] || OS=$(uname)

# background color
BG_COLOR_BASE03=%K{238}
BG_COLOR_BASE02=%K{234}
BG_COLOR_BASE01=%K{28}
BG_COLOR_BASE00=%K{226}
BG_COLOR_BASE0=%K{32}
BG_COLOR_BASE1=%K{51}
BG_COLOR_BASE2=%K{197}
BG_COLOR_BASE3=%K{255}
BG_COLOR_YELLOW=%K{184}
BG_COLOR_ORANGE=%K{202}
BG_COLOR_RED=%K{160}
BG_COLOR_MAGENTA=%K{127}
BG_COLOR_VIOLET=%K{199}
BG_COLOR_BLUE=%K{25}
BG_COLOR_CYAN=%K{81}
BG_COLOR_GREEN=%K{40}

# foreground color
FG_COLOR_BASE03=%F{238}
FG_COLOR_BASE02=%F{234}
FG_COLOR_BASE01=%F{28}
FG_COLOR_BASE00=%F{226}
FG_COLOR_BASE0=%F{32}
FG_COLOR_BASE1=%F{51}
FG_COLOR_BASE2=%F{197}
FG_COLOR_BASE3=%F{255}
FG_COLOR_YELLOW=%F{184}
FG_COLOR_ORANGE=%F{202}
FG_COLOR_RED=%F{160}
FG_COLOR_MAGENTA=%F{127}
FG_COLOR_VIOLET=%F{199}
FG_COLOR_BLUE=%F{25}
FG_COLOR_CYAN=%F{81}
FG_COLOR_GREEN=%F{40}

# RESET=$(tput sgr0)

# reset color
local RESET_COLOR=%f%k%b
local RESET=%{$RESET_COLOR%}
local RETURN_CODE="%(?..$FG_COLOR_RED%? ↵$RESET)"
local ARROW_SYMBOL=$(echo "\ue0b0")
local ZSH_TIME=%D{%H:%M}
local PADDING=' '

if [ $OS = "Darwin" ]; then
	# local LOGO=$(echo "\uf179") # 
	local LOGO=$(echo "\ue711") # 
else
	# local LOGO="🐧"
	# local LOGO=$(echo "\ue712") #
	local localunicode=$(echo "\ue73a") # 
	local LOGO="$FG_COLOR_ORANGE$localunicode $RESET" 
	# local LOGO=$(echo "\uf17c") # 
fi

GIT_DIRTY_COLOR=%F{196}
GIT_CLEAN_COLOR=%F{118}
GIT_PROMPT_INFO=%F{012}

ZSH_THEME_GIT_PROMPT_PREFIX="  "
ZSH_THEME_GIT_PROMPT_SUFFIX="$GIT_PROMPT_INFO"
ZSH_THEME_GIT_PROMPT_DIRTY=" $GIT_DIRTY_COLOR✘"
ZSH_THEME_GIT_PROMPT_CLEAN=" $GIT_CLEAN_COLOR✔"

ZSH_THEME_GIT_PROMPT_ADDED="%F{082}✚%f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{166}✹%f"
ZSH_THEME_GIT_PROMPT_DELETED="%F{160}✖%f"
ZSH_THEME_GIT_PROMPT_RENAMED="%F{220]➜%f"
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{082]═%f"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{190]✭%f"

# option defaults
[[ -n "$ZSH_POWERLINE_SHOW_USER" ]]             || ZSH_POWERLINE_SHOW_USER=true
[[ -n "$ZSH_POWERLINE_SHOW_IP" ]]               || ZSH_POWERLINE_SHOW_IP=true
[[ -n "$ZSH_POWERLINE_SHOW_OS" ]]               || ZSH_POWERLINE_SHOW_OS=true
[[ -n "$ZSH_POWERLINE_SHOW_TIME" ]]             || ZSH_POWERLINE_SHOW_TIME=true
[[ -n "$ZSH_POWERLINE_SINGLE_LINE" ]]           || ZSH_POWERLINE_SINGLE_LINE=false
[[ -n "$ZSH_POWERLINE_SHOW_GIT_STATUS" ]]       || ZSH_POWERLINE_SHOW_GIT_STATUS=true
[[ -n "$ZSH_POWERLINE_SHOW_GIT_BRANCH_ONLY" ]]  || ZSH_POWERLINE_SHOW_GIT_BRANCH_ONLY=false
[[ -n "$ZSH_POWERLINE_SHOW_RETURN_CODE" ]]      || ZSH_POWERLINE_SHOW_RETURN_CODE=true
[[ -n "$ZSH_POWERLINE_DIRECTORY_DEPTH" ]]       || ZSH_POWERLINE_DIRECTORY_DEPTH=2

# a new line before prompt
PROMPT="
"
# username
if [ $ZSH_POWERLINE_SHOW_USER = true ]; then
	local USER="%n"
	PROMPT="${BG_COLOR_BLUE}%{$fg_bold[white]%}${PADDING}${USER}"
	# PROMPT="${BG_COLOR_BLUE}%{$fg_bold[white]%}${PADDING}${USER}%{$reset_color%}"
    # PROMPT="${PROMPT}${BG_COLOR_BLUE}${FG_COLOR_BASE3}${PADDING}${USER}"
	PADDING=''
fi

# hostname
if [ $ZSH_POWERLINE_SHOW_IP = true ]; then
    if [ "$(echo $IP | grep 200)" = "" ]; then
    IP=`curl -si --max-time 2 http://ipecho.net/plain`
        # no network connection, use hostname
        IP="%m"
    else
        # replace dot by dash
        IP=`echo -n $IP | tail -n 1 | sed "s/\./-/g"`
    fi
	if [ $ZSH_POWERLINE_SHOW_USER = true ]; then
		PROMPT="${PROMPT}${FG_COLOR_BASE3}${BG_COLOR_BLUE}@"
	fi
    PROMPT="${PROMPT}${FG_COLOR_BASE3}${BG_COLOR_BLUE}${PADDING}${IP}"
	PADDING=' '
fi
# arrow symbol for username and ip/host
if [ $ZSH_POWERLINE_SHOW_USER = true ] || [ $ZSH_POWERLINE_SHOW_IP = true ]; then
	if [ $ZSH_POWERLINE_SHOW_TIME = true ]; then
		PROMPT="${PROMPT} ${FG_COLOR_BLUE}${BG_COLOR_BASE01}${ARROW_SYMBOL}%{$reset_color%}"
	else
		PROMPT="${PROMPT} ${FG_COLOR_BLUE}${BG_COLOR_BASE02}${ARROW_SYMBOL}%{$reset_color%}"
		# PROMPT="${PROMPT} ${FG_COLOR_BLUE}${BG_COLOR_BASE02}${ARROW_SYMBOL}%{$reset_color%}"
	fi
fi

# datetime
if [ $ZSH_POWERLINE_SHOW_TIME = true ]; then
	PROMPT="${PROMPT}${FG_COLOR_BASE3}${BG_COLOR_BASE01}${PADDING}${ZSH_TIME}"
	PROMPT="${PROMPT} ${FG_COLOR_BASE01}${BG_COLOR_BASE02}${ARROW_SYMBOL}"
	PADDING=' '
fi

# OS logo
if [ $ZSH_POWERLINE_SHOW_OS = true ]; then
	PROMPT="${PROMPT}${FG_COLOR_ORANGE}${BG_COLOR_BASE02}${PADDING}${LOGO}"
	PADDING=' '
fi

# current directory (%E hightline all line to end)
DIRECOTORY_DEPTH="%${ZSH_POWERLINE_DIRECTORY_DEPTH}~"
PROMPT="${PROMPT}${FG_COLOR_BASE3}${BG_COLOR_BASE02} ${DIRECOTORY_DEPTH}"

# show git status
if [ $ZSH_POWERLINE_SHOW_GIT_BRANCH_ONLY = true ]; then
	# get git branch function
	git_branch() {
		git rev-parse --git-dir > /dev/null 2>&1
		if [ "$?" = "0" ]; then
			BRANCH=$(git branch | grep '*' | cut -d' ' -f2-)
			echo ${ZSH_THEME_GIT_PROMPT_PREFIX}${BRANCH}
		fi
	}
	PROMPT="${PROMPT}"'$(git_branch)'
elif [ $ZSH_POWERLINE_SHOW_GIT_STATUS = true ]; then
	PROMPT="${PROMPT}"'$(git_prompt_info)'
fi

# single line or double lines
if [ $ZSH_POWERLINE_SINGLE_LINE = false ]; then
	PROMPT="${PROMPT} %E
  ${RESET}${FG_COLOR_BASE02}${ARROW_SYMBOL}"
else
	PROMPT="${PROMPT} ${RESET}${FG_COLOR_BASE02}${ARROW_SYMBOL}"
fi

# reset
PROMPT="$PROMPT ${RESET} "

if [ $ZSH_POWERLINE_SHOW_RETURN_CODE = true ]; then
	RPROMPT="${RETURN_CODE}"
fi


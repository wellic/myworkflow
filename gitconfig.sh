#customize your personal info
#   user.name
#   user.email
#   mcf.nickname
[user]
    name = Valerii Savchenko
    email = valerii.s@giantleaplab.com
[mcf]
# Use commands w-(get,set,del,list)-mcf-param for work with l-* parameters
#Your nickname
    l-nickname = wellic

#  l-debug-level = $level
#    $level :  0  is normal mode. Hide all diagnostic messages.
#    $level :  1  is debug mode 1. Show some diagnostic message in w-* and mcf-* functions.
#    $level :  2  is debug mode 2. Show all diagnostic message in w-* and mcf-* functions.
#  Локальный метод, позволяет управлять выводом сообщений при работе w-* and mcf-* методов.
#  Необходим при отладке методов и при изучении работы команд.
	l-debug-level = 0

# Выполнять или нет копирование локальной ветки $cfg в основной источник $src1 при выполнении w-upload*.
# 0|off или 1|on
    l-backup-cfg = off

#  MCF main branches names
	l-fix    = _fix
	l-cfg    = _cfg
    l-master = master

#  Main source 1
    l-src1         = origin
    l-src1-rbranch = master

#  Additional source 2
    l-src2         = origin
    l-src2-rbranch = master

#  MCF prev branches names and repo
    l-prev-master               = master
    l-prev-src1-rbranch         = master
    l-prev-src1                 = origin
	l-prev-fix                  = _fix
	l-prev-cfg                  = _cfg

# Автоматическое создание удаленной ветки
# 0|off или 1|on
	l-autocreate-feature-rbranch = off

################################################################################

[commit]
#    template = /home/yournick/.gitmessage_template
[color]
    ui = true
    status = true
    diff = true
    branch = true
    interactive = true
    pager = true
    grep = true
[color "log"]
    current = green
    local = yellow
    remote = green reverse
    upstream = green dim
[color "branch"]
    current = green bold
    local = green
    remote = cyan
    upstream = yellow
[color "diff"]
    commit = yellow bold
    meta = normal bold
    frag = magenta bold
    old = red
    new = green
    whitespace = red reverse blink
    plain = normal
    func = normal
[color "status"]
    added = green dim
    changed = cyan
    untracked = yellow
[core]
    commentchar = ";"
    pager = less -FXRS
    whitespace = fix,-indent-with-non-tab,trailing-space,cr-at-eol
#    editor = mcedit
# FOR LINUX
    autocrlf = input
    safecrlf = false
    eol = native
# FOR WIN
#    pager = more
#    core.autocrlf true
#    core.safecrlf true
[blame]
    data = short
[gui]
    spellingdictionary = en_GB
[merge]
    tool = kdiff3
    guitool = kdiff3
[diff]
    tool = kdiff3
    guitool = kdiff3
[difftool]
    prompt = false
[mergetool]
    prompt = false
[help]
    autocorrect = 0
[http]
    sslverify = false
[push]
    default = upstream

################################################################################

###############
# Start ALIASES
###############

[alias]

###############
# Main commands
###############

br = branch
br-info = branch -vv --list
br-info-all = branch -vv --list -ra
bri = branch -vv --list
bria = branch -vv --list -ra

co = checkout
ci = commit
amend = commit --amend -C HEAD
st = status
rb = rebase
rbi = rebase -i
ch = cherry-pick
unstage = reset HEAD

# diff
df = diff
df0 = diff -U0
dfc = diff --cached
dfc0 = diff --cached -U0
df0c = diff --cached -U0
visual = !LANG=C gitk --all &

# show history and log
sshow = "! f() { git --no-pager show --no-notes --stat --pretty=format:\"%C(yellow)%ad %C(green)%h%C(cyan)%d%Creset | %s %C(black bold)[%an]%Creset\"  --date=short --decorate $@ && echo  ; }; f"
hist  = "! f() { git --no-pager log                    --pretty=format:\"%C(yellow)%ad %C(green)%h%C(cyan)%d%Creset | %s %C(black bold)[%an]%Creset\"  --graph --date=short --decorate $@ && echo ; }; f"
hist2 = "! f() { git --no-pager log                    --pretty=format:\"%C(yellow)%ad %C(green)%h%Creset | %s %C(black bold)[%an]%Creset\"            --graph --date=short --decorate $@ && echo ; }; f"
hist3 = "! f() { git --no-pager log                    --pretty=format:\"%C(yellow)%ad %C(green)%h%Creset | %s %C(cyan)%d %C(black bold)[%an]%Creset\" --graph --date=short --decorate $@ && echo  ; }; f"
hist4 = "! f() { git --no-pager log                    --pretty=format:\"%C(yellow)%ad %C(green)%h%Creset | %s %Creset\" --graph --date=short --decorate $@ && echo  ; }; f"
hist5 = "! f() { git --no-pager log                    --pretty=format:\"%C(yellow)%ad %C(green)%h%Creset | %s %Creset\"         --date=short            $@ && echo  ; }; f"
last  = "! git hist  -20 $* "
last2 = "! git hist2 -20 $* "
last3 = "! git hist3 -20 $* "

#
# User info
#

myname     = "! git config user.name"
myemail    = "! git config user.email"
mynickname = "! git config mcf.l-nickname | sed 's/ /_/g'"

#Check labels in sources. Useful look for nickname, f.e. in comments
mycheck = "! f() { \
 allname=${1:-$(git mynickname)} && \
 git l-echo \"Find '$allname' in sources\" 6 && \
 git --no-pager grep -nEe \"${allname}\" \
;}; f "

#Show log for current user without sort
mylog = "! f() { \
 name=$(git myname) && \
 name=$(echo $name | sed 's/ /./g') && \
 git remote -v && \
 echo \"Log for user (regex): '$name'\" && \
 git hist2 --author=\"$name\" $@ \
;}; f "

mylogshort = "! f() { \
 name=$(git myname) && \
 name=$(echo $name | sed 's/ /./g') && \
 git remote -v && \
 echo \"Log for user (regex): '$name'\" && \
 git hist4 --author=\"$name\" $@ \
;}; f "

#Show log for current user sorted by date
mylogsort = "! f() { \
 git mylog $@ | sort -k 2,2 -r \
;}; f"

#Show log for current user without sort
myreport-cbr = "! f() { \
 name=$(git myname) && \
 name=$(echo $name | sed 's/ /./g') && \
 git remote -v && \
 echo \"Log for user (regex): '$name'\" && \
 git hist5 --author-date-order --author=\"$name\" -20 $@ \
;}; f "

myreport = "! f() { \
 name=$(git myname) && \
 name=$(echo $name | sed 's/ /./g') && \
 git l-echo \"Log for user (regex): '$name'\n\" 6 1 && \
 git l-echo \"$(git remote -v)\n\" 6 0 && \
 cbr=$(git current-branch-name) && \
 res1=''; \
 res2=''; \
 pr=''; \
 rbr=$(git branch -r | sed -r -e 's/[*>]|->//g' | sed -r -e 's/^\\s*-\\s*$//g' | sort -ru ) && \
 for br in $rbr; do\
	rev=$(git l-rev $br); \
	if echo \"$pr\" | grep -vqw $rev ; then \
		pr=\"$pr $rev\"; \
		s=$(git hist5 --author-date-order --author=\"$name\" $br $@ | sed '/^$/d' ); \
		if [ \"$s\" != '' ]; then \
			res1=$(git l-echo \"$res1\n$br\n\"); \
			res2=$(git l-echo \"$res2\n$s\n\"); \
		fi; \
	fi; \
 done &&\
 lbr=$(git branch | sed -r -e 's/[*>]//g' | sed -r -e 's/^\\s*-\\s*$//g' | sort -u ) && \
 for br in $lbr; do\
	rev=$(git l-rev $br); \
	if echo \"$pr\" | grep -vqw $rev ; then \
		pr=\"$pr $rev\"; \
		s=$(git hist5 --author-date-order --author=\"$name\" $br $@ | sed '/^$/d' ); \
		if [ \"$s\" != '' ]; then \
			res1=$(git l-echo \"$res1\n$br\n\"); \
			res2=$(git l-echo \"$res2\n$s\n\"); \
		fi; \
	fi; \
 done &&\
 echo \"$res2\" | sort -ru | sed -r 's/^(\\x1B\\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K])+$//ig'| sed '/^$/d'; \
 res1=$(echo \"$res1\" | sort -u  | sed -r 's/^(\\x1B\\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K])+$//ig'| sed '/^$/d'); \
 git l-echo \"\n$res1\"; \
 git l-cmd-checkout '' $cbr \
 ;}; f "

################################################################################

#################
# Useful commands
#################

# see gitignore rules
gi-list="! git gi list"
# get rules for gitignore: git gi netbeans
gi = "! gi() { curl -L -s https://www.gitignore.io/api/$@ ;}; gi"

current-branch-name = "! git cbr"
cbr = rev-parse --abbrev-ref HEAD

# ignored
# Show files ignored by git:
ign = "! git status --ignored --short | awk '/^!!/ { print $2 }'"
ign-cd = ls-files -o -i --exclude-standard


# temporarily ignoring file
ignore   = update-index --assume-unchanged
unignore = update-index --no-assume-unchanged
# to see the list of the ignored files.
ignored = "!git ls-files -v | grep ^[a-z]"

# check merged
merged   = branch --merged
unmerged = branch --no-merged

# different list and logs
ls = ls-files
lg    = "! f() { git --no-pager log -p $@ && echo ;}; f "
lol   = "! f() { git --no-pager log       --graph --decorate --pretty=oneline --abbrev-commit $@       && echo ;}; f "
lola  = "! f() { git --no-pager log --all --graph --decorate --pretty=oneline --abbrev-commit --all $@ && echo ;}; f "

type = cat-file -t
dump = cat-file -p

fsckclear = "! f(){ \
 git l-echo \"git fsck\"                                            && git fsck && \
 git l-echo \"git reflog expire --expire-unreachable=now --all\" && git reflog expire --expire-unreachable=now --all && \
 git l-echo \"git gc --prune prunefsck\"                         && git gc --prune=now && \
 git l-echo \"git fsck\"                                         && git fsck && \
 git l-echo \"git gc\"                                           && git gc \
;}; f"

################################################################################

###################
# - My workflow
# - Local commands
# - Useful commands
###################

#############
# S: l-echo-*
#############

# Показать сообщение нужным цветом и оттенком
# COLOR={0..7}
#  0-Black(Grey), 1-Red, 2-Green, 3-Brown/Orange(Yellow), 4-Blue,  5-Purple, 6-Cyan, 7-Light Gray(White)
# BRIGHT={0|1|2|4|7|9}
#  0(normal), 1(light), 2(dark), 4(underline), 7(invert) 9(cross)
l-echo-l0 = "! git l-echo"
l-echo = "! f() { \
 MESS=${1:-} && \
 COLOR=${2:-3} && \
 BRIGHT=${3:-1} && \
 COLOR=\"\\033[${BRIGHT};3${COLOR}m\" && \
 NOCOLOR=\"\\033[0m\" && \
 MESS=\"${COLOR}${MESS}${NOCOLOR}\" && \
 [ \"$(uname)\" = 'Linux' ] && echo \"$MESS\" || echo -e \"$MESS\"; \
 return 0 \
;}; f"

l-echo-err = "! f() { \
 MESS=${1:-} && \
 COLOR=${2:-1} && \
 BRIGHT=${3:-1} && \
 l-echo \"$MSG\n\nFor more detais set debug level from 1 to 3:\ngit w-mcf-param-set l-debug-level 3\n\" $COLOR $BRIGHT && \
 return 0 \
;}; f"

l-echo-l1 = "! f() { \
 MESS=${1:-} && \
 COLOR=${2:-2} && \
 BRIGHT=${3:-2} && \
 git l-debug-level-check 1 && \
 git l-echo \"= $MESS\" \"$COLOR\" \"$BRIGHT\"; \
 return 0 \
;}; f"

l-echo-l2 = "! f() { \
 MESS=${1:-} && \
 COLOR=${2:-6} && \
 BRIGHT=${3:-2} && \
 git l-debug-level-check 2 && \
 git l-echo \"== $MESS\" \"$COLOR\" \"$BRIGHT\"; \
 return 0 \
;}; f"

l-echo-l3 = "! f() { \
 MESS=${1:-} && \
 COLOR=${2:-6} && \
 BRIGHT=${3:-2} && \
 git l-debug-level-check 3 && \
 git l-echo \"== $MESS\" \"$COLOR\" \"$BRIGHT\"; \
 return 0 \
;}; f"

l-echo-lc = "! git l-echo-cmd"
l-echo-cmd = "! f() { \
 MSG=${1:-} && \
 CMD=${2:-} && \
 LEVEL_MSG=${3:-2} && \
 LEVEL_CMD=${4:-0} && \
 COLOR_MSG=${5:-6} && \
 BRIGHT_MSG=${6:-2} && \
 COLOR_CMD=${7:-3} && \
 BRIGHT_CMD=${8:-1} && \
 ECHO_MSG=l-echo-l$LEVEL_MSG && \
 ECHO_CMD=l-echo-l$LEVEL_CMD && \
 git \"$ECHO_MSG\" \"$MSG\" $COLOR_MSG $BRIGHT_MSG && \
 if [ \"$CMD\" != '' ]; then\
	git \"$ECHO_CMD\" \"$CMD\" $COLOR_CMD $BRIGHT_CMD; \
 fi &&\
 return 0 \
;}; f"

# Посмотреть последние коммиты текущей ветки, если $showlog=show|on|''
# Конечная ветка: не меняется.
l-showlog = "! f(){ \
 showlog=${1:-on} && \
 [ $(git l-check-is-on $showlog) = 'on' ] && (git l-echo '--- Please check ---' 5 && git last) || : \
;}; f"

##############
# E:  l-echo-*
##############

##############
# S: l-*check*
##############

l-debug-level-check = "! f() { \
 level=${1:-0} && [ \"$level\" -le \"$(git l-mcf-param-get l-debug-level)\" ] \
;}; f"

l-quite = "! f() { \
 if [ \"$(git l-mcf-param-get l-debug-level)\" != '0' ]; then echo ''; else echo '-q'; fi \
;}; f"

# Проверяет наличие локальной ветки 0-существует, 1-нет
l-check-exists-branch = "! f(){ \
 CMD='l-check-exists-branch' && \
 branch=${1:-''} \
 showstatus=${2:-off}; \
 git l-echo-l1 \"$CMD '$branch' $showstatus\" && \
 status=1 && \
 if [ \"$branch\" != '' ]; then \
    lbr=$(git branch    | grep -P \"\\s$1\\s*$\"); \
    rbr=$(git branch -r | grep -P \"\\s$1\\s*$\"); \
	if [ \"$rbr\" != '' -o \"$lbr\" != '' ]; then status=0 ; fi; \
 fi; \
 git l-echo-lc \"$CMD status: $status\" \"$CMD Found: $lbr $rbr\" 2 3 6 2; \
 if [ $(git l-check-is-on $showstatus) = 'on' ]; then echo $status; fi; \
 return $status \
;}; f"

# Проверяет статус переменной: возвращает on или off
l-check-is-on = "! f(){ \
 value=${1:-''} && \
 empty_is_true=${2:-1} && \
 if [ \"$empty_is_true\" = '1' -a \"$value\" = '' ]; then status=on; \
 elif [ \"$value\" = 'on' -o \"$value\" = '1' ]; then status=on; else status=off; fi; \
 echo $status; \
 return 0 \
;}; f"

##############
# E: l-*check*
##############

#############
# S: *system*
#############

l-local-branch-name = "! f(){ \
 CMD='l-local-branch-name' && \
 branch_name=${1:-} && \
 local_name=${2:-} && \
 if [ \"$master_name\" = '' -o \"$branch_name\" = '' ]; then git l-echo-err \"$CMD\nError!!!\nBranch and local name cannot be empty.\"; exit 1; fi && \
 if [ \"$branch_name\" != 'master' ]; then name=\"_/$branch_name/\" ; else name='' ; fi && \
 echo \"${name}_${local_name}\" \
;}; f"

l-rev = "! f() { \
  git rev-list "$1" | head -n 1 \
;}; f"

l-set-upstream-cbr = "! f(){ \
 CMD='l-set-upstream-cbr' && \
 quite=$(git l-quite) && \
 upstream=${1:-} && \
 git l-echo-l1 \"$CMD $upstream\" && \
 if [ \"$upstream\" = '' ]; then\
	git l-echo \"$CMD Warning!!!\nUpstream cannot be empty\" && return 1; \
 fi && \
 git l-echo-lc \"$CMD 1:\" \"git branch --set-upstream-to=$upstream\" && git branch $quite --set-upstream-to=$upstream \
;}; f"

l-unset-upstream-cbr = "! f(){ \
 CMD='l-unset-upstream-cbr' && \
 quite=$(git l-quite) && \
 git l-echo-l1 \"$CMD\" && \
 s=$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD)); \
 if [ \"$s\" != '' ] ; then\
	git l-echo-lc \"$CMD 1:\" \"git branch --unset-upstream\" && git branch $quite --unset-upstream; \
 fi\
;}; f"

l-remove-local-branch = "! f(){ \
 CMD='l-remove-local-branch' && \
 quite=$(git l-quite) && \
 force=${1:-} && \
 branch=${2:-} && \
 return_branch=${3:-} && \
 showlog=${3:-on} && \
 git l-echo-l1 \"$CMD $force $branch $return_branch $showlog\" && \
 if ! git l-check-exists-branch $return_branch ; then\
	git l-echo \"$CMD Error!!!\nBranch '$return_branch' does not exists\" 1; \
	return 1; \
 fi && \
 if git l-check-exists-branch $branch ; then\
	git l-echo-l2 \"$CMD 1:\" && git l-cmd-checkout '' $return_branch && \
	if [ \"$force\" = '-f' ]; then mode=\"-D\"; else mode=\"-d\"; fi && \
	git l-echo-l2 \"$CMD 2:\" && git l-cmd-branch \"$mode\" $branch; \
 fi && \
 if [ $(git l-check-is-on $showlog) != 'on' ]; then return 0; fi && \
 git br-info-all\
;}; f"

l-remove-all-local-branch = "! f(){ \
 CMD='l-remove-all-local-branch' && \
 quite=$(git l-quite) && \
 force=${1:-} && \
 showlog=${2:-on} && \
 git l-echo-l1 \"$CMD $force $showlog\" && \
 git l-echo-l2 \"$CMD 1:\"                       && git w-reset 0 0 && \
 src1=$(git l-mcf-param-get l-src1) && \
 rbranch=$(git l-mcf-param-get l-src1-rbranch) && \
 if ! git l-check-exists-branch $src1/$rbranch ; then\
	src1=$(git l-mcf-param-get l-src1         --global) && \
    rbranch=$(git l-mcf-param-get l-src1-rbranch --global); \
 fi && \
 git l-cmd-checkout '' $src1/$rbranch && \
 if [ \"$force\" = '-f' ]; then mode=-D; else mode=-d; fi && \
 branches=$(git branch | grep -v '*'); \
 if [ \"$branches\" != '' ]; then\
	git l-echo-lc \"$CMD 1:\" \"git branch | grep -v '*' | xargs git branch $mode\" && \
	echo "$branches" | xargs git branch $mode; \
 fi && \
 if [ $(git l-check-is-on $showlog) != 'on' ]; then return 0; fi && \
 git br-info-all\
;}; f"

#############
# E: *system*
#############

############
# S: l-cmd-*
############

l-cmd-fetch = "! f(){ \
 CMD='l-cmd-fetch' && \
 quite=$(git l-quite) && \
 opt=${1:-} && \
 src1=${2:-} && \
 src1_rbranch=${3:-} && \
 git l-echo-l1 \"$CMD $opt $src1 $src1_rbranch\" && \
 git l-echo-lc \"$CMD 1:\" \"git fetch $opt $src1 $src1_rbranch\" && git fetch $quite $opt $src1 $src1_rbranch\
;}; f"

l-cmd-branch = "! f(){ \
 CMD='l-cmd-branch' && \
 quite=$(git l-quite) && \
 opt=${1:-} && \
 branch=${2:-} && \
 git l-echo-l1 \"$CMD $opt $branch \" && \
 git l-echo-lc \"$CMD 1:\" \"git branch $opt $branch\" && git branch $quite $opt $branch \
;}; f"

l-cmd-checkout = "! f(){ \
 CMD='l-cmd-checkout' && \
 quite=$(git l-quite) && \
 cbr=$(git current-branch-name) && \
 opt=${1:-} && \
 br=${2:-$cbr} && \
 git l-echo-l1 \"$CMD $br\" && \
 if [ \"$br\" != \"$cbr\" ]; then git l-echo-lc \"$CMD 1:\" \"git checkout $br\" && git checkout $quite $br ; fi\
;}; f"

l-cmd-checkout-b = "! f(){ \
 CMD='l-cmd-checkout-b' && \
 quite=$(git l-quite) && \
 if [ $# -lt 2 ]; then git l-echo \"$CMD Error!!!\nMust be minimum 2 parameters\" 1; exit 1; fi && \
 opt=${1:-} && \
 br=${2:-} && \
 remote=${3:-} && \
 git l-echo-l1 \"$CMD $br $remote\" && \
 if git l-check-exists-branch $br ; then git l-echo \"$CMD Error!!!\nBranch already exists\" 1; exit 1; fi && \
 git l-echo-lc \"$CMD 1:\" \"git checkout -b $br $remote\" && git checkout $quite -b $br $remote\
;}; f"

l-cmd-pull = "! f(){ \
 CMD='l-cmd-pull' && \
 quite=$(git l-quite) && \
 opt=${1:-} && \
 src1=${2:-} && \
 src1_rbranch=${3:-} && \
 git l-echo-l1 \"$CMD $opt $src1 $src1_rbranch\" && \
 git l-echo-lc \"$CMD 1:\" \"git pull $opt $src1 $src1_rbranch\" && git pull $quite --no-edit $opt $src1 $src1_rbranch \
;}; f"

l-cmd-merge = "! f(){ \
 CMD='l-cmd-merge' && \
 quite=$(git l-quite) && \
 opt=${1:-} && \
 branch=${2:-} && \
 git l-echo-l1 \"$CMD $opt $branch\" && \
 git l-echo-lc \"$CMD 1:\" \"git merge $opt $branch\" && git merge $quite --no-edit $opt $branch \
;}; f"

############
# E: l-cmd-*
############

################################################################################

#################
# Global commands
#################

#  Все команды имеют основную версию команды (mcf-*) и дополнительную с префиксом (w-*).
#  Эти команды равнозначны, пока они не переопределены в локальном конфиге. Если необходимо, то переопределять лучше команды w-*, т.к. именно эти команды вызываются в расширенных командах.
#  Команды mcf-* нужно использовать, как команды с поведением по-умолчанию.
#  Расширенные команды выполняют работы с git согласно 3-веточной схемы. Все команды можно переопределять в локальных конфигах, чтобы изменить стандатное поведение.
#    #Пример
#    #Отключить бекап локального конфига (ветка $cfg) на удаленный сервер для команд w-upload*.
#    > vim /dir/to/project/.git/config
#      …
#      [alias]
#        w-backup-cfg= "! : "
#  При описании команд ниже запись $param = value  обозначает, что $param c параметром по-умолчанию value.
#  Все команды используют параметры по-умолчанию:
#    $fix = l-fix - имя ветки правок fix в схеме MCF
#    $cfg = l-cfg - имя ветки конфигурации cfg в схеме MCF
#    $master = l-master - имя основной ветки master в схеме MCF
#    $src1 = l-src1 -  имя основного источника
#    $src1_rbranch = l-src1-rbranch - имя удаленной (remote) ветки в основном источнике
#    $src2 = l-src2 - имя вспомогательного источника
#    $src2_rbranch = l-src2-rbranch - имя удаленной (remote) ветки вспомогательного источника
#    $showlog = show - показывать или не показывать (hide|off) log после выполнения команды
#    $rebuild_base = on - делать(on) или не ltkfnm(off) после выполнения команды переустановку базовых веток
#    $method = rebase - метод (rebase|merge), который использовать при получении новых изменений с удаленных (remote) источников

# Локальные константы l-*?, которые находятся в секции [mcf], предназначены, для инициализации параметров команд по-умолчанию, а также для переопределения значений параметров в локальных конфигах.
#   #Пример
#   #Изменить умолчательные имя локальных веток $master -> work и $fix -> dev для текущего проекта.
#   > vim /dir/to/project/.git/config.
#     …
#     [mcf]
#        l-master = work
#        l-fix    = dev
# Также все mcf,w-* команды можно адаптировать для работы с git-svn.
# Далее в примерах мы используем команды с индексом w-*, и они могут быть переопределены в локальных конфигах, так же удобнее и быстрее набирать на клавиатуре.

# w-backup-cfg [ $cfg $src1 $showlog ]
#  Сделать бекап ветки конфигурации
#  Отправить копию ветки $cfg в репу $src1 c именем ветки '_{nickname}_{$cfg}_backup'.
#  Конечная ветка: не меняется.
  w-backup-cfg = "! git mcf-backup-cfg"
mcf-backup-cfg = "! f(){ \
 CMD='w-backup-cfg' && \
 quite=$(git l-quite) && \
 cfg=${1:-$(git l-mcf-param-get l-cfg)} && \
 src1=${2:-$(git l-mcf-param-get l-src1)} && \
 showlog=${3:-on} && \
 nick=$(git mynickname) && \
 src1_rbranch=_${nick}_${cfg}_backup && \
 git l-echo-l1 \"$CMD $cfg $src1 $showlog\" && \
 git l-echo-lc \"$CMD 1:\" \"git push -f $src1 $cfg:$src1_rbranch\" && git push $quite -f $src1 $cfg:$src1_rbranch && \
 git l-showlog $showlog \
;}; f"

# w-copy2tmp [ $src1 $showlog ]
#  Сделать временный бекап состояния текущей ветки.
#  Создается текущее состояние рабочего каталога в репу $src1 с именем ветки '_{nickname}_{name_of_current_branch}_tmp'. При бекапе все несохраненные изменения также отправятся в репу.
#  После завершения бекапа в рабочем катологе состояние файлов будет восстановлено, как до выполнения команды.
#  Эта операция полезна, если вы не готовы коммитить изменения, но нужно сделать копию текущего состояния.
#  Конечная ветка: не меняется.
  w-copy2tmp = "! git mcf-copy2tmp"
mcf-copy2tmp = "! f(){ \
 CMD='w-copy2tmp' && \
 quite=$(git l-quite) && \
 src1=${1:-$(git l-mcf-param-get l-src1)} && \
 showlog=${2:-on} && \
 nick=$(git mynickname) && \
 cbr=$(git current-branch-name) && \
 src1_rbranch=_${nick}_${cbr}_tmp && \
 CURDATE=$(date +%y%m%d_%H%M%S) && \
 MESS=$(echo \"Tmp commit of branch '${cbr}'. Date: ${CURDATE}.\") && \
 TMPFILE='~__REMOVE_THIS_TMP_FILE__' && \
 touch \"$TMPFILE\" && \
 git l-echo-l1 \"$CMD $src1 $showlog\" && \
 git l-echo-lc \"$CMD 1:\" \"git add --all\"                        && git add --all && \
 git l-echo-lc \"$CMD 2:\" \"git commit -am '$MESS'\"               && git commit -m \"${MESS}\" && \
 git l-echo-lc \"$CMD 3:\" \"git push -f $src1 $cbr:$src1_rbranch\" && git push $quite -f $src1 $cbr:$src1_rbranch && \
 git l-echo-lc \"$CMD 4:\" \"git reset HEAD~1\"                                && git reset HEAD~1 && \
 rm -f \"$TMPFILE\" && \
 git l-showlog $showlog \
;}; f"

# w-fakecommit [ $mess $showlog ]
#  Создает фейковый коммит.
#  Создается коммит c пустым файлом и коментарием 'Fake: $mess'. По-умолчанию, комментарий - 'Fake: Added _fakefile_...'.
#  Команда используется для тестов и при исследовании git команд.
#  Конечная ветка: не меняется.
  w-fakecommit = "! git mcf-fakecommit "
mcf-fakecommit = "! f(){ \
 CMD='w-fakecommit' && \
 quite=$(git l-quite) && \
 mess=${1:-} && \
 showlog=${2:-on} && \
 a=_fakefile_.$(basename $PWD).$(date +%Y%m%d_%H%M%S) && \
 if [ -z \"$mess\" ]; then mess=\"Added $a\"; fi && \
 sleep 1 && touch \"$a\" && git add \"$a\" -- && git commit $quite -m \"Fake: $mess\" && \
 git l-showlog $showlog \
;}; f"

################################################################################

###############
# Standart flow
# w-*
###############

# l-create-base-lite $showlog
#  Создать ветки $cfg с базой от $master и $fix с базой от $cfg для работы cо схемой MCF. Если ветки уже были созданы ранее, то будет просто переход на них без изменения базовых коммитов.
#  Конечная ветка: $fix.
l-create-base-lite = ! f(){ \
 CMD='l-create-base-lite' && \
 quite=$(git l-quite) && \
 showlog=${1:-on} && \
 fix=$(git l-mcf-param-get l-fix) && \
 cfg=$(git l-mcf-param-get l-cfg) && \
 master=$(git l-mcf-param-get l-master) && \
 git l-echo-l1 \"$CMD $showlog\" && \
 git l-echo-l2 \"$CMD 1:\" && git w-create-base $fix $cfg $master $showlog \
;}; f"

# w-create-base [ $fix $cfg $master $showlog ]
#  Создать ветки $cfg с базой от $master и $fix с базой от $cfg для работы cо схемой MCF. Если ветки уже были созданы ранее, то будет просто переход на них без изменения базовых коммитов.
#  Конечная ветка: $fix.
  w-create-base = "! git mcf-create-base"
mcf-create-base = "! f(){ \
 CMD='w-create-base' && \
 quite=$(git l-quite) && \
 fix=${1:-$(git l-mcf-param-get l-fix)} && \
 cfg=${2:-$(git l-mcf-param-get l-cfg)} && \
 master=${3:-$(git l-mcf-param-get l-master)} && \
 showlog=${4:-on} && \
 git l-echo-l1 \"$CMD $fix $cfg $master $showlog\" && \
 if ! git l-check-exists-branch $cfg; then \
	git l-echo-lc \"$CMD 1:\" \"git checkout -b $cfg $master\" && git checkout $quite -b $cfg $master; \
 fi && \
 if ! git l-check-exists-branch $fix; then \
	git l-echo-lc \"$CMD 2:\" \"git checkout -b $fix $cfg\"    && git checkout $quite -b $fix $cfg; \
 fi && \
 if [ \"$(git current-branch-name)\" != \"$fix\" ]; then \
	git l-echo-l2 \"$CMD 3:\"                                  && git l-cmd-checkout $fix; \
 fi && \
 git l-showlog $showlog \
;}; f"

# l-rebuild-base-lite $showlog
l-rebuild-base-lite = "! f(){ \
 CMD='w-rebuild-base-lite' && \
 quite=$(git l-quite) && \
 master=$(git l-mcf-param-get l-master) && \
 fix=\"_/$master/_fix\" && \
 cfg=\"_/$master/_cfg\" && \
 git l-echo-l1 \"$CMD \" && \
 git l-echo-l2 \"$CMD 1: '$master $cfg $fix'\" && \
 git l-echo-l2 \"$CMD 2:\" && git w-rebuild-base $fix $cfg $master off \
;}; f"

# w-rebuild-base [ $fix $cfg $master $showlog ]
#  Переустановить базовые коммиты для $cfg и $fix, т.е. подготовить ветки для работы по схеме MCF.
#  Обычно делается всегда после правки конфигурации, или после обновления $master, чтобы внести изменения в базовые ветки.
#  Конечная ветка: $fix.
  w-rebuild-base = "! git mcf-rebuild-base"
mcf-rebuild-base = "! f(){ \
 CMD='w-rebuild-base' && \
 quite=$(git l-quite) && \
 fix=${1:-$(git l-mcf-param-get l-fix)} && \
 cfg=${2:-$(git l-mcf-param-get l-cfg)} && \
 master=${3:-$(git l-mcf-param-get l-master)} && \
 showlog=${4:-on} && \
 git l-echo-l1 \"$CMD $fix $cfg $master $showlog\" && \
 if ! git l-check-exists-branch $cfg || ! git l-check-exists-branch $fix; then \
	git l-echo-l2 \"$CMD 1:\"                          && git w-create-base $fix $cfg $master off; \
 fi && \
 git l-echo-lc \"$CMD 2:\" \"git rebase $master $cfg\" && git rebase $quite $master $cfg && \
 git l-echo-lc \"$CMD 3:\" \"git rebase $cfg $fix\"    && git rebase $quite $cfg $fix && \
 git l-showlog $showlog \
;}; f"

# w-load-fix-from-repo [ $master $src1 $src1_rbranch $method $showlog ]
#  Залить новые изменения в ветку $master из источника $src1 $src1_rbranch используя $method=rebase|merge.
#  Если $method=rebase, то используется git pull --rebase, а иначе git merge.
#  Конечная ветка: $master.
  w-load-fix-from-repo = "! git mcf-load-fix-from-repo"
mcf-load-fix-from-repo = "! f(){ \
 CMD='w-load-fix-from-repo' && \
 quite=$(git l-quite) && \
 master=${1:-$(git l-mcf-param-get l-master)} && \
 src1=${2:-$(git l-mcf-param-get l-src1)} && \
 src1_rbranch=${3:-$(git l-mcf-param-get l-src1-rbranch)} && \
 method=${4:-rebase} && \
 showlog=${5:-on} && \
 git l-echo-l1 \"$CMD $master $src1 $src1_rbranch $method $showlog\" && \
 if [ \"$method\" = \"rebase\" ]; then \
    git l-echo-l2 \"$CMD 1:\" && git l-cmd-checkout '' $master \
    git l-echo-l2 \"$CMD 2:\" && git l-cmd-pull --rebase $src1 $src1_rbranch; \
 else \
    git l-echo-l2 \"$CMD 3:\" && git l-cmd-fetch '' $src1 $src1_rbranch && \
	git l-echo-l2 \"$CMD 4:\" && git l-cmd-checkout '' $master && \
	git l-echo-l2 \"$CMD 5:\" && git l-cmd-merge '' $src1/$src1_rbranch; \
 fi && \
 git l-showlog $showlog \
;}; f"

# w-update-common [ $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch $rebuild_base $showlog ]
#  Залить обновление в $master из 2-х источников.
#  Обновить $master из основного источника $src1/$src1_rbranch методом git pull --rebase.
#  Если первый и второй источник одинаковые ($src1 = $src2 && $src1_rbranch = $src2_rbranch), то обновление из второго источника пропускается.
#  Если первый и второй источник разные, то обновить $master из дополнительного источника $src2/$src2_rbranch методом git merge.
#  Параметр $rebuild_base=on|off указывает, нужно ли после обновления делать переустановку базовых веток.
#  Конечная ветка: $fix.
  w-update-common = "! git mcf-update-common"
mcf-update-common = "! f(){ \
 CMD='w-update-common' && \
 quite=$(git l-quite) && \
 fix=${1:-$(git l-mcf-param-get l-fix)} && \
 cfg=${2:-$(git l-mcf-param-get l-cfg)} && \
 master=${3:-$(git l-mcf-param-get l-master)} && \
 src1=${4:-$(git l-mcf-param-get l-src1)} && \
 src1_rbranch=${5:-$(git l-mcf-param-get l-src1-rbranch)} && \
 src2=${6:-$(git l-mcf-param-get l-src2)} && \
 src2_rbranch=${7:-$(git l-mcf-param-get l-src2-rbranch)} && \
 rebuild_base=${8:-on} && \
 showlog=${9:-on} && \
 git l-echo-l1 \"$CMD $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch $rebuild_base $showlog\" && \
 rev=$(git l-rev $master) && \
 git l-echo-l2 \"$CMD 1:\" && git w-load-fix-from-repo $master $src1 $src1_rbranch rebase off && \
 if [ \"$src1\" != \"$src2\" -o \"$src1_rbranch\" != \"$src2_rbranch\" ]; then \
	git l-echo-l2 \"$CMD 2:\" && git w-load-fix-from-repo $master $src2 $src2_rbranch merge off; \
 fi && \
 if [ \"$(git l-rev $master)\" != \"$(git l-rev $src1/$src1_rbranch)\"  ]; then git l-echo-lc \"$CMD 3:\" \"git push $src1 $master:$src1_rbranch\" && git push $quite $src1 $master:$src1_rbranch; fi && \
 if [ \"$rebuild_base\" = 'on' ]; then \
	if [ \"$(git l-rev $master)\" != \"$rev\" ]; then\
		git l-echo-l2 \"$CMD 4:\" && git w-rebuild-base $fix $cfg $master off; \
    fi; \
 fi && \
 cbr=$(git current-branch-name) && \
 git l-echo-l2 \"$CMD 5: w-update-extcmd $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch off\" && git w-update-extcmd $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch off && \
 git l-echo-l2 \"$CMD 6:\" && git l-cmd-checkout '' $fix && \
 git l-showlog $showlog \
;}; f"

# w-update2 [ $src2 $src2_rbranch $fix $cfg $master $src1 $src1_rbranch $rebuild_base $showlog ]
#  Команда аналогична w-update-common, но другой порядок парaметров.
#  Первые два параметра определяют второй источник, потом указываются остальные параметры или берутся по-умолчанию, как для w-update-common.
#  Более удобна при работе с 2-мя источниками, чем w-update-common, когда используются параметры по-умолчанию, а нужно указать только параметры второго источника.
#  Конечная ветка: $fix.
  w-update2 = "! git mcf-update2"
mcf-update2 = "! f(){ \
 CMD='w-update2' && \
 quite=$(git l-quite) && \
 src2=${1:-$(git l-mcf-param-get l-src2)} && \
 src2_rbranch=${2:-$(git l-mcf-param-get l-src2-rbranch)} && \
 fix=${3:-$(git l-mcf-param-get l-fix)} && \
 cfg=${4:-$(git l-mcf-param-get l-cfg)} && \
 master=${5:-$(git l-mcf-param-get l-master)} && \
 src1=${6:-$(git l-mcf-param-get l-src1)} && \
 src1_rbranch=${7:-$(git l-mcf-param-get l-src1-rbranch)} && \
 rebuild_base=${8:-on} && \
 showlog=${9:-on} && \
 git l-echo-l1 \"$CMD $src2 $src2_rbranch $fix $cfg $master $src1 $src1_rbranch $rebuild_base $showlog\" && \
 git l-echo-l2 \"$CMD 1:\" && git w-update-common $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch $rebuild_base $showlog \
;}; f"

# w-update [ $fix $cfg $master $src1 $src1_rbranch $rebuild_base $showlog ]
#  Залить обновление в $master из 1-го источника.
#  Обновить $master из основного источника $src1/$src1_rbranch методом git pull --rebase.
#  Используется w-update-common, но $src1 = $src2 && $src1_rbranch = $src2_rbranch, поэтому обновление из второго источника пропускается.
#  Параметр $rebuild_base=on|off указывает, нужно ли после обновления делать переустановку базовых веток.
#  Конечная ветка: $fix.
  w-update = "! git mcf-update"
mcf-update = "! f(){ \
 CMD='w-update' && \
 quite=$(git l-quite) && \
 fix=${1:-$(git l-mcf-param-get l-fix)} && \
 cfg=${2:-$(git l-mcf-param-get l-cfg)} && \
 master=${3:-$(git l-mcf-param-get l-master)} && \
 src1=${4:-$(git l-mcf-param-get l-src1)} && \
 src1_rbranch=${5:-$(git l-mcf-param-get l-src1-rbranch)} && \
 rebuild_base=${6:-on} && \
 showlog=${7:-on} && \
 src2=$src1 && \
 src2_rbranch=$src1_rbranch && \
 git l-echo-l1 \"$CMD $fix $cfg $master $src1 $src1_rbranch $rebuild_base $showlog\" && \
 git l-echo-l2 \"$CMD 1:\" && git w-update-common $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch $rebuild_base $showlog \
;}; f"

# w-upload-common [ $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch $showlog ]
#  Выгружает сделанные изменения из ветки $fix в ветку $master и на сервер $src1.
#  Сначала происходит обновление $master из источников $src1 и $src2 (см. w-update-common).
#  Затем изменения из $fix заливаются в $master и отправляются в $src1/$src1_rbranch.
#  Конечная ветка: $fix.
  w-upload-common = "! git mcf-upload-common"
  w-publish-common = "! git mcf-upload-common"
mcf-upload-common = "! f(){ \
 CMD='w-upload-common' && \
 quite=$(git l-quite) && \
 fix=${1:-$(git l-mcf-param-get l-fix)} && \
 cfg=${2:-$(git l-mcf-param-get l-cfg)} && \
 master=${3:-$(git l-mcf-param-get l-master)} && \
 src1=${4:-$(git l-mcf-param-get l-src1)} && \
 src1_rbranch=${5:-$(git l-mcf-param-get l-src1-rbranch)} && \
 src2=${6:-$(git l-mcf-param-get l-src2)} && \
 src2_rbranch=${7:-$(git l-mcf-param-get l-src2-rbranch)} && \
 showlog=${8:-on} && \
 do_backup=$(git l-mcf-param-get l-backup-cfg) && \
 git l-echo-l1 \"$CMD $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch $showlog\" && \
 rev=$(git l-rev $master) && \
 git l-echo-l2 \"$CMD 1:\" && git w-update-common $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch off off && \
 if [ \"$(git l-rev $master)\" != \"$rev\" ]; then\
	git l-echo-l2 \"$CMD 2:\" && git w-rebuild-base $fix $cfg $master off; \
 fi && \
 git l-echo-l2 \"$CMD 3:\" && git w-send-fix $fix $cfg $master $src1 $src1_rbranch off && \
 if [ $(git l-check-is-on $do_backup) = 'on' ]; then \
	git l-echo-l2 \"$CMD 4:\"; git w-backup-cfg $cfg $src1 off; \
 else git l-echo-l2 \"$CMD 5: skip backup $cfg\"; fi && \
 if [ \"$(git l-rev $master)\" != \"$rev\" ]; then\
	cbr=$(git current-branch-name) && \
	git l-echo-l2 \"$CMD 6:\" && \
    git l-echo-l1 \"w-upload-extcmd $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch off\" && \
    git w-upload-extcmd $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch off; \
 fi && \
 git l-echo-l2 \"$CMD 7:\" && git l-cmd-checkout '' $fix && \
 git l-showlog $showlog \
;}; f"

# w-upload2 [ $src2 $src2_rbranch $fix $cfg $master $src1 $src1_rbranch $showlog ]
#  Команда аналогична w-upload-common, но другой порядок парaметров.
#  Первые два параметра определяют второй источник, потом указываются остальные параметры или берутся по-умолчанию, как для w-upload-common.
#  Более удобна при работе с 2-мя источниками, чем w-upload-common, если используюся параметры по-умолчанию, а нужно указать только параметры второго источника.
#  Конечная ветка: $fix.
  w-upload2 = "! git mcf-upload2"
  w-publish2 = "! git mcf-upload2"
mcf-upload2 = "! f(){ \
 CMD='w-upload2' && \
 quite=$(git l-quite) && \
 src2=${1:-$(git l-mcf-param-get l-src2)} && \
 src2_rbranch=${2:-$(git l-mcf-param-get l-src2-rbranch)} && \
 fix=${3:-$(git l-mcf-param-get l-fix)} && \
 cfg=${4:-$(git l-mcf-param-get l-cfg)} && \
 master=${5:-$(git l-mcf-param-get l-master)} && \
 src1=${6:-$(git l-mcf-param-get l-src1)} && \
 src1_rbranch=${7:-$(git l-mcf-param-get l-src1-rbranch)} && \
 showlog=${8:-on} && \
 git l-echo-l1 \"$CMD $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch $showlog\" && \
 git l-echo-l2 \"$CMD 1:\" && git w-upload-common $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch $showlog \
;}; f"

# w-upload [ $fix $cfg $master $src1 $src1_rbranch $showlog ]
#  Выгружает сделанные изменения из ветки $fix в ветку $master и на сервер $src1.
#  Сначала происходит обновление $master из источника $src1 (см. w-update).
#  Затем изменения из $fix заливаются в $master и отправляются в $src1/$src1_rbranch.
#  Конечная ветка: $fix.
  w-upload = "! git mcf-upload"
  w-publish = "! git mcf-upload"
mcf-upload = "! f(){ \
 CMD='w-upload' && \
 quite=$(git l-quite) && \
 fix=${1:-$(git l-mcf-param-get l-fix)} && \
 cfg=${2:-$(git l-mcf-param-get l-cfg)} && \
 master=${3:-$(git l-mcf-param-get l-master)} && \
 src1=${4:-$(git l-mcf-param-get l-src1)} && \
 src1_rbranch=${5:-$(git l-mcf-param-get l-src1-rbranch)} && \
 showlog=${6:-on} && \
 src2=$src1 && \
 src2_rbranch=$src1_rbranch && \
 git l-echo-l1 \"$CMD $fix $cfg $master $src1 $src1_rbranch $showlog\" && \
 git l-echo-l2 \"$CMD 1:\" && git w-upload-common $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch $showlog \
;}; f"

# w-update-extcmd [ $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch $showlog ]
#  Эта команда выполняется после успешного выполнения обновления w-update-common.
#  Эту команду нужно переопределить в локальном конфиге, чтобы при обновлении можно было выполнить дополнительные действия.
#  Например, выполнить тесты, дополнительную синхронизацию, дополнительные системные программы и т.п.
#  Конечная ветка: зависит от переопределенной комманды.
#  # Пример: дополнительная синхронизация с 3-м сервером server3
#  > vim /dir/to/project/.git/config
#    …
#    [alias]
#      w-update-extcmd-default = "! f(){ \
#        master=$3\
#        && l-echo \"git push server3 $master:custom_branch\" \
#        &&          git push server3 $master:custom_branch   \
#      ;}; f"#    #Пример: дополнительная синхронизация с 3-м сервером server3
  w-update-extcmd = "! git mcf-update-extcmd"
mcf-update-extcmd = "! f(){ \
 CMD='w-update-extcmd' && \
 quite=$(git l-quite) && \
 fix=${1:-$(git l-mcf-param-get l-fix)} && \
 cfg=${2:-$(git l-mcf-param-get l-cfg)} && \
 master=${3:-$(git l-mcf-param-get l-master)} && \
 src1=${4:-$(git l-mcf-param-get l-src1)} && \
 src1_rbranch=${5:-$(git l-mcf-param-get l-src1-rbranch)} && \
 src2=${6:-$(git l-mcf-param-get l-src2)} && \
 src2_rbranch=${7:-$(git l-mcf-param-get l-src2-rbranch)} && \
 showlog=${8:-on} \
;}; f"

# w-upload-extcmd [ $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch $showlog ]
#  Эта команда выполняется после успешного выполнения w-upload.
#  Эту команду нужно переопределить в локальном конфиге, чтобы можно было выполнить дополнительные действия.
#  Например, выполнить тесты, дополнительную синхронизацию, дополнительные системные программы и т.п.
#  Конечная ветка: зависит от переопределенной комманды.
#  # Пример: отправка $master после w-upload-common на дополнительный сервер server2 в ветку remote_branch
#  > vim /dir/to/project/.git/config
#    …
#    [remote "server2"]
#       …
#    [alias]
#       w-upload-extcmd = "! f(){ \
#          master=$3 \
#          && git l-echo \"git push server2 $master:remote_branch\" \
#          &&              git push server2 $master:remote_branch   \
#       ;}; f"
  w-upload-extcmd = "! git mcf-upload-extcmd"
  w-publish-extcmd = "! git mcf-upload-extcmd"
mcf-upload-extcmd = "! f(){ \
 CMD='w-upload-extcmd' && \
 quite=$(git l-quite) && \
 fix=${1:-$(git l-mcf-param-get l-fix)} && \
 cfg=${2:-$(git l-mcf-param-get l-cfg)} && \
 master=${3:-$(git l-mcf-param-get l-master)} && \
 src1=${4:-$(git l-mcf-param-get l-src1)} && \
 src1_rbranch=${5:-$(git l-mcf-param-get l-src1-rbranch)} && \
 src2=${6:-$(git l-mcf-param-get l-src2)} && \
 src2_rbranch=${7:-$(git l-mcf-param-get l-src2-rbranch)} && \
 showlog=${8:-on} \
;}; f"

# w-apply-fix [ $fix $cfg $master $showlog ]
#  Загрузить свои изменения из ветки $fix в ветку $master, исключая коммиты ветки $cfg.
#  Конечная ветка: $fix.
  w-apply-fix = "! git mcf-apply-fix"
mcf-apply-fix = "! f(){ \
 CMD='w-apply-fix' && \
 quite=$(git l-quite) && \
 fix=${1:-$(git l-mcf-param-get l-fix)} && \
 cfg=${2:-$(git l-mcf-param-get l-cfg)} && \
 master=${3:-$(git l-mcf-param-get l-master)} && \
 showlog=${4:-on} && \
 git l-echo-l1 \"$CMD $fix $cfg $master $showlog\" && \
 git l-echo-l2 \"$CMD 1:\"                                            && git l-cmd-checkout '' $fix && \
 if [ \"$(git l-rev $master)\" != \"$(git l-rev $fix)\" ]; then\
	git l-echo-lc \"$CMD 2:\" \"git rebase --onto $master $cfg $fix\" && git rebase $quite --onto $master $cfg $fix && \
    git l-echo-lc \"$CMD 3:\" \"git rebase $fix $master\"             && git rebase $quite $fix $master && \
    git l-echo-l2 \"$CMD 4:\"                                         && git w-rebuild-base $fix $cfg $master off; \
 fi && \
 git l-echo-l2 \"$CMD 5:\"                                            && git l-cmd-checkout '' $fix && \
 git l-showlog $showlog \
;}; f"

# w-send-fix [ $fix $cfg $master $src1 $src1_rbranch $showlog ]
#  Применить изменения (mcf-apply-fix) $fix к $master, и отправить их в $src1/$src1_rbranch.
#  Конечная ветка: $fix.
  w-send-fix = "! git mcf-send-fix"
mcf-send-fix = "! f(){ \
 CMD='w-send-fix' && \
 quite=$(git l-quite) && \
 fix=${1:-$(git l-mcf-param-get l-fix)} && \
 cfg=${2:-$(git l-mcf-param-get l-cfg)} && \
 master=${3:-$(git l-mcf-param-get l-master)} && \
 src1=${4:-$(git l-mcf-param-get l-src1)} && \
 src1_rbranch=${5:-$(git l-mcf-param-get l-src1-rbranch)} && \
 showlog=${6:-on} && \
 git l-echo-l1 \"$CMD $fix $cfg $master $src1 $src1_rbranch $showlog\" && \
 rev=$(git l-rev $master) && \
 git l-echo-l2 \"$CMD 1:\" && git w-apply-fix $fix $cfg $master off && \
 if [ \"$(git l-rev $master)\" != \"$rev\" ]; then\
	git l-echo-lc \"$CMD 2:\" \"git push $src1 $master:$src1_rbranch\" && git push $quite $src1 $master:$src1_rbranch; \
 fi && \
 git l-showlog $showlog \
;}; f"

# w-repair-conflict-master [ $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch $showlog ]
#  Устранить возможные проблемы после устранения конфликта в $master.
#  Отправить устраненные конфликты в $src1/$src1_rbranch
#  Все параметры как для w-upload-common.
#  Конечная ветка: $fix.
  w-repair-conflict-master = "! git mcf-repair-conflict-master"
mcf-repair-conflict-master = "! f(){ \
 CMD='w-repair-conflict-master' && \
 quite=$(git l-quite) && \
 fix=${1:-$(git l-mcf-param-get l-fix)} && \
 cfg=${2:-$(git l-mcf-param-get l-cfg)} && \
 master=${3:-$(git l-mcf-param-get l-master)} && \
 src1=${4:-$(git l-mcf-param-get l-src1)} && \
 src1_rbranch=${5:-$(git l-mcf-param-get l-src1-rbranch)} && \
 src2=${6:-$(git l-mcf-param-get l-src2)} && \
 src2_rbranch=${7:-$(git l-mcf-param-get l-src2-rbranch)} && \
 rebuild_base=${8:-on} && \
 showlog=${9:-on} && \
 git l-echo-l1 \"$CMD $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch $showlog\" && \
 git l-echo-l2 \"$CMD 1:\" && git w-rebuild-base $fix $cfg $master off && \
 git l-echo-lc \"$CMD 2:\" \"git push $src1 $master:$src1_rbranch\" && git push $quite $src1 $master:$src1_rbranch && \
 git l-echo \"$CMD: All fixed. Please start conflicted command again.\"\
;}; f"

# w-repair-conflict-cfg [ $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch $showlog ]
#  Устранить возмжные проблемы после устранения конфликта в $cfg
#  Все параметры как для w-upload-common.
#  Конечная ветка: $fix.
  w-repair-conflict-cfg = "! git mcf-repair-conflict-cfg"
mcf-repair-conflict-cfg = "! f(){ \
 CMD='w-repair-conflict-cfg' && \
 quite=$(git l-quite) && \
 fix=${1:-$(git l-mcf-param-get l-fix)} && \
 cfg=${2:-$(git l-mcf-param-get l-cfg)} && \
 master=${3:-$(git l-mcf-param-get l-master)} && \
 src1=${4:-$(git l-mcf-param-get l-src1)} && \
 src1_rbranch=${5:-$(git l-mcf-param-get l-src1-rbranch)} && \
 src2=${6:-$(git l-mcf-param-get l-src2)} && \
 src2_rbranch=${7:-$(git l-mcf-param-get l-src2-rbranch)} && \
 rebuild_base=${8:-on} && \
 showlog=${9:-on} && \
 git l-echo-l1 \"$CMD $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch $showlog\" && \
 git l-echo-l2 \"$CMD 1:\" && git w-rebuild-base $fix $cfg $master off && \
 git l-echo \"$CMD: All fixed. Please start conflicted command again.\"\
;}; f"

# w-repair-conflict-fix [ $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch $showlog ]
#  Устранить возмжные проблемы после устранения конфликта в $fix
#  Все параметры как для w-upload-common.
#  Конечная ветка: $fix.
  w-repair-conflict-fix = "! git mcf-repair-conflict-fix"
mcf-repair-conflict-fix = "! f(){ \
 CMD='w-repair-conflict-fix' && \
 quite=$(git l-quite) && \
 fix=${1:-$(git l-mcf-param-get l-fix)} && \
 cfg=${2:-$(git l-mcf-param-get l-cfg)} && \
 master=${3:-$(git l-mcf-param-get l-master)} && \
 src1=${4:-$(git l-mcf-param-get l-src1)} && \
 src1_rbranch=${5:-$(git l-mcf-param-get l-src1-rbranch)} && \
 src2=${6:-$(git l-mcf-param-get l-src2)} && \
 src2_rbranch=${7:-$(git l-mcf-param-get l-src2-rbranch)} && \
 rebuild_base=${8:-on} && \
 showlog=${9:-on} && \
 git l-echo-l1 \"$CMD $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch $showlog\" && \
 git l-echo-l2 \"$CMD 1:\" && git w-rebuild-base $fix $cfg $master off && \
 git l-echo    \"$CMD: All fixed. Please start conflicted command again.\"\
;}; f"

###############
# Standart flow
# l-*
###############

################################################################################

######################
# Work with mcf params
######################

###############
# w-mcf-param-*
###############

# w-mcf-param-get $name [,$typevar] [,$emptyok]
#  Показывает текущее значение параметра $name
#  Если параметр не найден, то будет выведено сообщение об ошибке и список текущих параметров
w-mcf-param-get = "! f(){ \
 CMD='w-mcf-param-get' && \
 param=${1:-} && \
 typevar=${2:-} && \
 emptyok=${3:-} && \
 git l-mcf-param-get \"$param\" \"$emptyok\" \"$typevar\" \
;}; f"

# w-mcf-param-set $name $value [ $showlog ]
#  Устанавливает новое значение $value для параметра $name.
#  Установка происходит в локальном конфиге.
w-mcf-param-set = "! f(){ \
 CMD='w-mcf-param-set' && git l-echo-l1 $CMD && \
 param=${1:-} && \
 value=${2:-} && \
 showlog=${3:-on} && \
 oldvalue=$(git l-mcf-param-get \"$param\") && \
 git l-echo-l2 \"$CMD 1: '$param' '$value' '$showlog'\" && \
 if ! git l-mcf-param-set \"$param\" \"$value\" '--local'; then \
	git l-echo-err \"$CMD Error!!!\nError occurs when setting the new value '$value' of the parameter '$param'.\"; \
	exit 1; \
 fi && \
 if [ $(git l-check-is-on $showlog) != 'on' ]; then return 0; fi && \
 newvalue=$(git l-mcf-param-get \"$param\") && \
 git l-echo \"Old: $param = $oldvalue\" 4 1 && \
 git l-echo \"New: $param = $newvalue\" 2 0 && \
 git w-list-mcf-param \
;}; f"

# w-mcf-param-del $name [ $showlog ]
#  Удаляет локальное значение параметра c именем $name, если параметр существует в локальном конфиг файле git.
w-mcf-param-del = "! f(){ \
 CMD='w-mcf-param-del' && git l-echo-l1 $CMD && \
 param=${1:-''} && \
 showlog=${2:-on} && \
 oldvalue=$(git l-mcf-param-get \"$param\") && \
 git l-echo-l2 \"$CMD 1:\" && git l-mcf-param-del \"$param\" && \
 if [ $(git l-check-is-on $showlog) != 'on' ]; then return 0; fi && \
 newvalue=$(git l-mcf-param-get \"$param\") && \
 git l-echo \"Old: $param = $oldvalue\" 4 1 && \
 git l-echo \"New: $param = $newvalue\" 2 0 && \
 git w-list-mcf-param \
;}; f"

# w-list-mcf-param
#  Показывает значения всех l-* параметров для текущего проекта.
  w-list-mcf-param = "! git mcf-list-mcf-param "
mcf-list-mcf-param = "! f() {\
 CMD='w-list-mcf-param' && \
 type=${1:-} && \
 git l-echo \"Current exists parameters:\" 5 0 && \
 if [ \"$type\" != '--local' ]; then git l-echo \"Global:\" 6 0 && git l-list-mcf-param --global; fi && \
 s=$(git config --local --get-regex mcf.l-) && \
 git l-echo \"Local:\" 6 0 && git l-list-mcf-param --local\
;}; f"

###############
# l-mcf-param-*
###############

l-mcf-param-get = "! f() { \
 CMD='l-mcf-param-get' && \
 param=${1:-} && \
 emptyok=${2:-off} && \
 typevar=${3:-} && \
 name=$(git l-mcf-param-fix-name \"$param\") && \
 echo $? ;\
 if [ \"$name\" = '' ]; then \
	git l-echo-err \"$CMD\nError!!!\nCheck name of the parameter '$param'.\"; \
	git w-list-mcf-param; \
	exit 1; \
 fi && \
 value=$(git config \"$typevar\" \"mcf.${name}\" ); \
 emptyok=$(git l-check-is-on \"$emptyok\" 0) && \
 if [ \"$?\" != '0' -a $emptyok = 'on' ]; then git l-echo-err \"$CMD Error!!!\nIncorrect parameter name '$name'.\"; exit 1; fi; \
 if [ \"$value\" = '' -a $emptyok = 'on' ]; then git l-echo-err \"$CMD Error!!!\nParameter '$name' is empty.\"; exit 1; fi; \
 echo \"$value\" \
;}; f"

# l-list-mcf-param [$type]
# Показать список глобальных или локальных переменных
# $type : --global|--local Default: --global
l-list-mcf-param = "! f() { \
 type=${1:-'--global'} && git config \"$type\" --get-regex mcf.l- | sed 's/^mcf.//' | awk '{printf \"%-30.80s = %s\\n\",$1,$2 }' \
;}; f"

# l-mcf-param-set $param $value [$type]
# $type : --global|--local Default:'' for local
l-mcf-param-set = "! f() { \
 CMD='l-mcf-param-set' && git l-echo-l2 $CMD && \
 param=${1:-''} && \
 value=${2:-''} && \
 type=${3:-'--local'} && \
 git l-echo-l2 \"$CMD 1:\"                                                      && git l-mcf-param-fix-value \"$value\" && \
 value=$(git l-mcf-param-fix-value \"$value\") && \
 if [ $param = '' -o $value = '' ]; then \
	git l-echo-err \"$CMD\nError!!!\nCheck name and value.\nThey cannot be empty.\" \
	exit 1; \
 fi && \
 git l-echo-lc \"$CMD 1:\" \"git config $type mcf.${param} $value\" 2 3         && git config \"$type\" \"mcf.${param}\" \"$value\" \
;}; f"

# l-mcf-param-del $name
# Удаляет локальное значение параметра c именем $name, если параметр существует в локальном конфиг файле git.
l-mcf-param-del = "! f(){ \
 CMD='l-mcf-param-del' && git l-echo-l2 $CMD && \
 param=${1:-''} && \
 if [ $param = '' ]; then \
	git l-echo-err \"$CMD Error!!!\nParameter name cannot be empty.\"; \
	git w-list-mcf-param; \
	exit 1; \
 fi && \
 ( t=$(git config --local mcf.$param) && git config --local --unset mcf.$param || : ) && \
 mcf=$(git config --local --get-regex 'mcf.l-') && \
 if [ \"$mcf\" = '' ]; then \
	git config --local --remove-section mcf; \
 fi \
;}; f"

# l-mcf-param-fix-name $value
# Удалить в значении пробелы
l-mcf-param-fix-name = "! f() { \
 CMD='l-mcf-param-fix-name' && s=$(echo \"$1\" | sed -r -e 's/[\\s]//g -e 's/[_]/-/g'); \
 if echo \"$s\" | grep -qvP \"'[a-z]'\"; then echo ''; else echo \"$s\"; fi\
;}; f"

# l-mcf-param-fix-value $value
# Удалить в значении пробелы
l-mcf-param-fix-value = "! f() { \
 CMD='l-mcf-param-fix-value' && s=$(echo \"$\" | sed -r 's/\\s//g'); echo $s \
 if echo \"$s\" | grep -qvP '[a-z]'; then echo ''; else echo \"$s\"; fi\
;}; f"

l-mcf-param-check-type = "! f(){ \
CMD='l-mcf-param-check-type' && git l-echo-l2 $CMD && \
 type=$1 && \
 if [ \"$type\" != 'main' -o \"$type\" != 'prev' ]; then \
    git l-echo-err \"$CMD\nError!!!\nCheck type mcf-param: '$type'.\nAvailable be only 'main' or 'prev'.\"; \
	exit 1; \
 fi \
;}; f"

l-mcf-param-check-typeid = "! f(){ \
CMD='l-mcf-param-is-typeid' && git l-echo-l2 $CMD && \
 typeid=$1 && \
 if [ \"$typeid\" != '-' -o \"$typeid\" != '-prev-' ]; then\
	git l-echo-err \"$CMD\nError!!!\nCheck typeid mcf-param: '$typeid'.\nAvailable be only '-' or '-prev-'.\";\
	exit 1;\
 fi \
;}; f"

l-mcf-param-get-typeid = "! f(){ \
CMD='l-mcf-param-get-typeid' && git l-echo-l2 $CMD && \
 type=$1 && \
 git l-echo-l2 \"$CMD 0:\" && git l-mcf-param-check-type \"$type\" && \
 if [ \"$type\" = 'main' ]; then echo 'l-';     return 0; fi && \
 if [ \"$type\" = 'prev' ]; then echo 'l-prev-; return 0; fi && \
 exit 1 \
;}; f"

l-mcf-param-set-typeid = "! f(){ \
CMD='l-mcf-param-set-typeid' && git l-echo-l2 $CMD && \
 typeid=$1 && \
 git l-echo-l2 \"$CMD 0:\" && git l-mcf-param-check-typeid \"$typeid\" && \
 fix=${2:-$(         git l-mcf-param-get ${typeid}fix          1)} && \
 cfg=${3:-$(         git l-mcf-param-get ${typeid}cfg          1)} && \
 master=${4:-$(      git l-mcf-param-get ${typeid}master       1)} && \
 src1=${5:-$(        git l-mcf-param-get ${typeid}src1         1)} && \
 src1_rbranch=${6:-$(git l-mcf-param-get ${typeid}src1-rbranch 1)} && \
 git l-echo-l2 \"$CMD 1:\" && git l-mcf-param-set ${typeid}master       \"$master\"  && \
 git l-echo-l2 \"$CMD 2:\" && git l-mcf-param-set ${typeid}fix          \"$fix\"     && \
 git l-echo-l2 \"$CMD 3:\" && git l-mcf-param-set ${typeid}cfg          \"$cfg\"     && \
 git l-echo-l2 \"$CMD 4:\" && git l-mcf-param-set ${typeid}src1-rbranch \"$rbranch\" && \
 git l-echo-l2 \"$CMD 5:\" && git l-mcf-param-set ${typeid}src1         \"$src1\" \
;}; f"

l-mcf-param-del-typeid = "! f(){ \
 CMD='l-mcf-param-del-typeid' && git l-echo-l2 $CMD && \
 typeid=$1 && \
 git l-echo-l2 \"$CMD 0:\" && git l-mcf-param-check-typeid \"$typeid\"   && \
 git l-echo-l2 \"$CMD 1:\" && git l-mcf-param-del \"${typeid}fix\"       && \
 git l-echo-l2 \"$CMD 2:\" && git l-mcf-param-del \"${typeid}cfg\"       && \
 git l-echo-l2 \"$CMD 3:\" && git l-mcf-param-del \"${typeid}master\"    && \
 git l-echo-l2 \"$CMD 4:\" && git l-mcf-param-del \"${typeid}src1\"      && \
 git l-echo-l2 \"$CMD 5:\" && git l-mcf-param-del \"${typeid}src1-rbranch\" \
;}; f"

l-mcf-param-init = "! f(){ \
 CMD='l-mcf-param-reset-all' && git l-echo-l1 $CMD && \
 fix=$1          && \
 cfg=$2          && \
 master=$3       && \
 src1=$4         && \
 src1_rbranch=$5 && \
 git l-echo-l2 \"$CMD 1: '$fix' '$cfg' '$master' '$src1' '$src1_rbranch'\" && \
 git l-echo-l2 \"$CMD 2:\" && git l-mcf-param-set-typeid $(git l-mcf-param-get-typeid 'main') \"$fix\" \"$cfg\" \"$master\" \"$src1\" \"$src_rbranch\" && \
 git l-echo-l2 \"$CMD 3:\" && git l-mcf-param-set-typeid $(git l-mcf-param-get-typeid 'prev') \"$fix\" \"$cfg\" \"$master\" \"$src1\" \"$src_rbranch\" \
;}; f"

# l-new-master $master [$src1 $src1_rbranch]
#  Устанавливает новое значение $master для параметров l-master и l-src1_rbranch.
#  Установка происходит в локальном конфиге.
l-mcf-param-new-master = "! f(){ \
 CMD='l-new-master' && git l-echo-l1 $CMD && \
 quite=$(git l-quite) && \
 typeid=$(git l-mcf-param-get-typeid 'prev') && \
 fix=${2:-$(         git l-mcf-param-get ${typeid}fix          1)} && \
 cfg=${3:-$(         git l-mcf-param-get ${typeid}cfg          1)} && \
 master=${4:-$(      git l-mcf-param-get ${typeid}master       1)} && \
 src1=${5:-$(        git l-mcf-param-get ${typeid}src1         1)} && \
 src1_rbranch=${6:-$(git l-mcf-param-get ${typeid}src1-rbranch 1)} && \
 git l-echo-l2 \"$CMD 1: '$fix' '$cfg' '$master' '$src1' '$src1_rbranch'\" && \
 git l-echo-l2 \"$CMD 2: \" && git l-mcf-param-init \"$fix\" \"$cfg\" \"$master\" \"$src1\" \"$src1_rbranch\"\
;}; f"

################################################################################

###############################
# For 2 branches flows:       #
# master-{hotfix,dev,feature} #
# dev-{hotfix,feature})       #
###############################

########
# w-hf-*
########

# w-hf [ $master_hf $cfg_hf $fix_hf $src1_rbranch_hf $showlog ]
#  Построить новую временную схему для выгрузки на удаленный сервер.
#  Используется для создания hotfix веток.
#  Конечная ветка: $fix_hf.
  w-hf      = "! git mcf-hf"
mcf-hf = "! f(){ \
 CMD='w-hf' && \
 quite=$(git l-quite) && \
 master_hf=$1 && \
 if [ -z $master_hf ]; then git l-echo \"$CMD Error!!!\nCheck hotfix master name.\" 1; exit 1; fi && \
 cfg_hf=$2 && \
 fix_hf=$3 && \
 src1_rbranch_hf=$4 && \
 showlog=${5:-on} && \
 if [ \"$cfg_hf\" = '' ]; then cfg_hf=_/${master_hf}/_cfg; fi && \
 if [ \"$fix_hf\" = '' ]; then fix_hf=_/${master_hf}/_fix; fi && \
 if [ \"$src1_rbranch\" = '' ]; then src1_rbranch_hf=$master_hf; fi && \
 git l-echo-l1 \"$CMD $master_hf $cfg_hf $fix_hf $src1_rbranch_hf $showlog\" && \
 git l-echo-l2 \"$CMD 1:\"                                                          && git w-hf-reset 1 off && \
 master=$(git l-mcf-param-get l-master) && \
 cfg=$(git l-mcf-param-get l-cfg) && \
 git l-echo-l2 \"$CMD 2:\"                                                          && git l-hotfix-setprev $master_hf $cfg_hf $fix_hf $src1_rbranch_hf && \
 src1=$(git l-mcf-param-get l-src1) && \
 if git l-check-exists-branch $master_hf; then \
	git l-echo-l2 \"$CMD 3:\"                                                       && git l-cmd-checkout '' $master_hf; \
 else \
	if git l-check-exists-branch $src1/$master_hf; then \
		git l-echo-l2 \"$CMD 4:\"                                                   && git l-cmd-checkout-b '' $master_hf $src1/$master_hf; \
    else\
		git l-echo-l2 \"$CMD 5:\"                                                   && git l-cmd-checkout-b '' $master_hf $master; \
	fi && \
    git l-echo-lc \"$CMD 6:\"                                                       && git l-cmd-checkout-b '' $cfg_hf $master_hf && \
    git l-echo-lc \"$CMD 7:\" \"git rebase --onto $cfg_hf $master $cfg\"            && git rebase $quite --onto $cfg_hf $master $cfg && \
    create_rbranch=$(git l-mcf-param-get l-autocreate-feature-rbranch); \
    if [ $(git l-check-is-on $create_rbranch) = 'on' ]; then \
		src1=$(git l-mcf-param-get l-src1) && \
        git l-echo-lc \"$CMD 8:\" \"git push -u $src1 $master_hf:$src1_rbranch_hf\" && git l-echo \"git push $quite -u $src1 $master_hf:$src1_rbranch_hf\"; \
	fi; \
 fi && \
 git l-echo-l2 \"$CMD 9:\"                                                          && git w-rebuild-base $fix_hf $cfg_hf $master_hf off && \
 if [ $(git l-check-is-on $showlog) != 'on' ]; then return 0; fi && \
 git w-list-mcf-param --local && \
 git l-showlog $showlog \
;}; f"

# l-hotfix-lite $master_hf [$showlog]
l-hotfix-lite = "! f(){ \
 CMD='l-hotfix-lite' && \
 quite=$(git l-quite) && \
 master_hf=$1 && \
 showlog=${2:-on} && \
 git l-echo-l1 \"$CMD $master_hf $showlog\" && \
 if [ -z $master_hf ]; then git l-echo \"$CMD Error!!!\nMust be minimum 1 parameter. Check hotfix name.\" 1; exit 1; fi && \
 fix=\"_/${master_hf}/_fix\" && \
 cfg=\"_/${master_hf}/_cfg\" && \
 src1=$(git l-mcf-param-get 'l-src1') && \
 git l-echo-l2 \"$CMD 1:\" && git w-hf $master_hf $cfg $fix $master_hf $showlog \
;}; f"

# Проверяет наличие локальной ветки 0-существует, 1-нет
w-remove-merged-branch = "! f(){ \
 BR=${1:-''} && \
 if [ \"$1\" = '' ]; then return 0; fi && \
 if ! git l-check-exists-branch $BR; then return 0; fi && \
 if git br --merged | grep -qF \"$BR\"; then git branch -q -d $BR; fi; \
 return 0 \
;}; f"

# w-hf-reset
#  Сбросить l-...-prev переменные  и вернуть работу на стандартные ветки
  w-hf-reset = "! git mcf-hf-reset"
  w-reset        = "! git mcf-hf-reset"
mcf-hf-reset = "! f(){ \
 CMD='w-hf-reset' && \
 quite=$(git l-quite) && \
 do_rb=${1:-1} && \
 showlog=${2:-on} && \
 git l-echo-l1 \"$CMD $do_rb $showlog\" && \
 src1_prev=$(git l-mcf-param-get         l-prev-src1         1 --local) && \
 src1_rbranch_prev=$(git l-mcf-param-get l-prev-src1-rbranch 1 --local) && \
 master_prev=$(git l-mcf-param-get       l-prev-master       1 --local) && \
 cfg_prev=$(git l-mcf-param-get          l-prev-cfg          1 --local) && \
 fix_prev=$(git l-mcf-param-get          l-prev-fix          1 --local) && \
 if [ \"$src1_prev\" != '' ];         then git l-mcf-param-set l-src1         \"$src1_prev\"         --local && git w-mcf-param-del l-prev-src1         '--local'; fi && \
 if [ \"$src1_rbranch_prev\" != '' ]; then git l-mcf-param-set l-src1-rbranch \"$src1_rbranch_prev\" --local && git w-mcf-param-del l-prev-src1-rbranch '--local'; fi && \
 if [ \"$master_prev\"       != '' ]; then git l-mcf-param-set l-master       \"$master_prev\"       --local && git w-mcf-param-del l-prev-master       '--local'; fi && \
 if [ \"$cfg_prev\"          != '' ]; then git l-mcf-param-set l-cfg          \"$cfg_prev\"          --local && git w-mcf-param-del l-prev-cfg          '--local'; fi && \
 if [ \"$fix_prev\"          != '' ]; then git l-mcf-param-set l-fix          \"$fix_prev\"          --local && git w-mcf-param-del l-prev-fix          '--local'; fi && \
 master=$(git l-mcf-param-get l-master) && \
 if git l-check-exists-branch $master ; then\
	fix=$(git l-mcf-param-get l-fix) && \
    cfg=$(git l-mcf-param-get l-cfg) && \
    if [ \"$do_rb\" = '1' ] ; then \
		git l-echo-l2 \"$CMD 1:\"      && git l-cmd-checkout '' $master && \
        git l-echo-l2 \"$CMD 2:\"      && git w-remove-merged-branch $fix && \
        git l-echo-l2 \"$CMD 3:\"      && git w-remove-merged-branch $cfg && \
        git l-echo-l2 \"$CMD 4:\"      && git w-rebuild-base $fix $cfg $master off; \
	fi; \
 fi && \
 if [ $(git l-check-is-on $showlog) != 'on' ]; then return 0; fi && \
 git w-list-mcf-param --local && \
 git br-info && \
 git l-showlog $showlog \
;}; f"

# w-hf-update [ $master_hf $cfg_hf $fix_hf $src1_rbranch_hf $showlog ]
#  Обновить hotfix ветку из удаленного репозитория
#  Конечная ветка: не меняется
  w-hf-update = "! git mcf-hf-update"
mcf-hf-update = "! f(){ \
 CMD='w-hf-update' && \
 quite=$(git l-quite) && \
 if [ $# -lt 1 ]; then git l-echo \"$CMD Error!!!\nMust be minimum 1 parameter. Check hotfix name.\" 1; exit 1; fi && \
 master_hf=$1 && \
 cfg_hf=${2:-_/${master_hf}/_cfg} && \
 fix_hf=${3:-_/${master_hf}/_fix} && \
 src1_rbranch_hf=${4:-$master_hf} && \
 showlog=${5:-on} && \
 git l-echo-l1 \"$CMD $master_hf $cfg_hf $fix_hf $src1_rbranch_hf $showlog\" && \
 if git l-check-exists-branch $master_hf; then \
	git l-echo-l2 \"$CMD 1:\"                                 && git w-hf-reset 0 off; \
 fi && \
 fix=$(git l-mcf-param-get l-fix) && \
 cfg=$(git l-mcf-param-get l-cfg) && \
 master=$(git l-mcf-param-get l-master) && \
 src1=$(git l-mcf-param-get l-src1) && \
 src1_rbranch=$(git l-mcf-param-get l-src1-rbranch ) && \
 src2=$(git l-mcf-param-get l-src2 ) && \
 src2_rbranch=$(git l-mcf-param-get l-src2-rbranch) && \
 git l-echo-l2 \"$CMD 2:\"                                      && git w-update $fix $cfg $master $src1 $src1_rbranch $src2 $src2_rbranch on off && \
 if git l-check-exists-branch $master_hf; then \
	git l-echo-l2 \"$CMD 3:\"                                   && git l-cmd-checkout '' $master_hf && \
    git l-echo-lc \"$CMD 4:\" \"git merge $src1/$src1_rbranch\" && git merge $quite --no-edit $src1/$src1_rbranch; \
 fi && \
 git l-echo-l2 \"$CMD 5:\"                                      && git w-hf $master_hf $cfg_hf $fix_hf $src1_rbranch_hf off && \
 git l-showlog $showlog \
;}; f"

# w-hf-purge [ $master_hf $cfg_hf $fix_hf $src1_rbranch_hf $showlog ]
#  Удалить локальные ветки для hotfiч
#  Конечная ветка: не меняется
  w-hf-purge = "! git mcf-hf-purge"
  w-hf-purge     = "! git mcf-hf-purge"
mcf-hf-purge = "! f(){ \
 CMD='w-hf-purge' && \
 quite=$(git l-quite) && \
 if [ $# -lt 1 ]; then git l-echo \"$CMD Error!!!\nMust be minimum 1 parameter. Check hotfix name.\" 1; exit 1; fi && \
 master_hf=$1 && \
 cfg_hf=${2:-_/${master_hf}/_cfg} && \
 fix_hf=${3:-_/${master_hf}/_fix} && \
 showlog=${4:-on} && \
 cfg=$(git l-mcf-param-get l-cfg) && \
 git l-echo-l1 \"$CMD $master_hf $fix_hf $showlog\" && \
 git l-echo-l2 \"$CMD 1:\"                                      && git w-hf-reset 1 off && \
 master=$(git l-mcf-param-get l-master) && \
 cfg=$(git l-mcf-param-get l-cfg) && \
 if git l-check-exists-branch $fix_hf; then \
	if [ \"$fix\" != \"$fix_hf\"  ]; then \
        git l-echo-cmd \"$CMD 2:\" \"git branch -D $fix_hf\"    && git branch $quite -D $fix_hf; \
    fi; \
 fi && \
 if git l-check-exists-branch $cfg_hf; then \
	if [ \"$cfg\" != \"$cfg_hf\"  ]; then \
        git l-echo-cmd \"$CMD 3:\" \"git branch -D $cfg_hf\"    && git branch $quite -D $cfg_hf; \
    fi; \
 fi && \
 if git l-check-exists-branch $master_hf; then \
	if [ \"$master\" != \"$master_hf\"  ]; then \
		git l-echo-cmd \"$CMD 4:\" \"git branch -D $master_hf\" && git branch $quite -D $master_hf; \
    fi; \
 fi && \
 git l-showlog $showlog \
;}; f"

########
# l-hf-*
########

# l-hotfix-setprev [ $master_new $cfg_new $fix_new $src1_rbranch_new ]
#  Создать временные переменные для работы c хотфикс-ветками.
l-hotfix-setprev = "! f(){ \
 CMD='l-hotfix-setvar' && \
 master_new=${1:-$(git l-mcf-param-get l-master)} && \
 cfg_new=${2:-_/${master_new}/_cfg} && \
 fix_new=${3:-_/${master_new}/_fix} && \
 src1_rbranch_new=${4:-$master_new} && \
 src1_new=${5:-$(git l-mcf-param-get l-src1} && \
 git l-echo-l1 \"$CMD '$master_new' '$fix_new' '$src1_rbranch_new' '$src1_new'\" && \
 master=$(git l-mcf-param-get l-master) && \
 cfg=$(git l-mcf-param-get l-cfg) && \
 fix=$(git l-mcf-param-get l-fix) && \
 src1_rbranch=$(git l-mcf-param-get l-src1-rbranch) && \
 src1=$(git l-mcf-param-get l-src1) && \
 git l-mcf-param-set l-master       \"$master_new\"       --local && \
 git l-mcf-param-set l-cfg          \"$cfg_new\"          --local && \
 git l-mcf-param-set l-fix          \"$fix_new\"          --local && \
 git l-mcf-param-set l-src1-rbranch \"$src1_rbranch_new\" --local && \
 git l-mcf-param-set l-src1         \"$src1_new\"         --local && \
 master_prev=$(git l-mcf-param-get l-prev-master             1 --local) && \
 cfg_prev=$(git l-mcf-param-get l-prev-cfg                   1 --local) && \
 fix_prev=$(git l-mcf-param-get l-prev-fix                   1 --local) && \
 src1_rbranch_prev=$(git l-mcf-param-get l-prev-src1-rbranch 1 --local) && \
 src1_prev=$(git l-mcf-param-get l-prev-src1                 1 --local) && \
 if [ \"$master_prev\"       = '' ]; then git l-mcf-param-set l-prev-master       \"$master\"       '--local'; fi && \
 if [ \"$cfg_prev\"          = '' ]; then git l-mcf-param-set l-prev-cfg          \"$cfg\"          '--local'; fi && \
 if [ \"$fix_prev\"          = '' ]; then git l-mcf-param-set l-prev-fix          \"$fix\"          '--local'; fi && \
 if [ \"$src1_rbranch_prev\" = '' ]; then git l-mcf-param-set l-prev-src1-rbranch \"$src1_rbranch\" '--local'; fi \
 if [ \"$src1_prev\"         = '' ]; then git l-mcf-param-set l-prev-src1         \"$src1\"         '--local'; fi \
;}; f"

################################################################################

##########################################
# For 3 branches flows
# master-dev-feature:
# *-flow-*
##########################################

##########
# w-flow-*
##########

# w-flow-setup-mdf
w-flow-setup = "! f(){\
 CMD='w-flow-setup-mdf' && \
 quite=$(git l-quite) && \
 if [ $# -lt 1 ]; then git l-echo \"$CMD Error!!!\nMust be minimum 1 parameter. Select main branch.\" 1; git branch -ra; exit 1; fi && \
 master=$1 && \
 dev=${2:-${master}-dev} && \
 feature=${3:-${dev}-feature} && \
 src1=${4:-$(git l-mcf-param-get l-src1)} && \
 showlog=${5:-on} && \
 git l-echo-l1 \"$CMD $master $dev $feature $src1 $showlog\" && \
 git l-echo-l2 \"$CMD 1:\"       && git l-cmd-fetch \"--all --prune --tags\" && \
 if [ \"$src1\" != '' ]; then \
	git l-echo-l2 \"$CMD 2:\"    && git w-mcf-param-set \"l-src1\" \"$src1\" 0; \
 else \
	src1=$(git l-mcf-param-get \"l-src1\" \"$src1\" 0); \
 fi && \
 git l-echo-l2 \"$CMD 4:\"       && git l-flow-setup-master $master $src1 off && \
 git l-echo-l2 \"$CMD 5:\"       && git l-flow-setup-dev $dev $master $src1 off && \
 git l-echo-l2 \"$CMD 6:\"       && git l-flow-setup-feature $feature $dev $src1 off && \
 if [ $(git l-check-is-on $showlog) != 'on' ]; then return 0; fi && \
 git l-echo-l2 \"$CMD 7:\"       && git w-list-mcf-param --local && \
 git l-echo \"Check branches upstream:\" 5 0 && \
 git l-echo-l2 \"$CMD 8:\"       && git br-info $master $dev $feature \
;}; f"

##########
# l-flow-*
##########

# l-flow-setup-master $master $src1 $showlog
l-flow-setup-master = "! f(){\
 CMD='l-flow-setup-master' && \
 quite=$(git l-quite) && \
 master=${1:-} && \
 src1=${2:-} && \
 showlog=${3:-on} && \
 git l-echo-l1 \"$CMD $master $src1 $showlog\" && \
 if [ \"$master\" = '' ]; then git l-echo \"$CMD Error!!!\nName of main master branch cannot be empty.\" 1; exit 1; fi && \
 if [ \"$src1\" = '' ]; then src1=$(git l-mcf-param-get l-src1); fi && \
 rbranch=$src1/$master && \
 if ! git l-check-exists-branch $rbranch ; then\
    git l-echo \"$CMD Error!!!\nCheck existing remote branch '$rbranch'\nor try to create manually '$master' from any existing branch\"; \
    git branch -ra; \
    return 1; \
 fi && \
 if git l-check-exists-branch $master; then\
    git l-echo-l2 \"$CMD 1:\"                                            && git l-cmd-checkout '' $master && \
    git l-echo-l2 \"$CMD 2:\"                                            && git l-set-upstream-cbr $rbranch && \
    if [ \"$(git l-rev $master)\" != \"$(git l-rev $rbranch)\" ]; then \
 	   git l-echo-l2 \"$CMD 3:\"                                         && git l-cmd-merge --ff $rbranch; \
    fi\
 else\
    git l-echo-l2 \"$CMD 4:\"											 && git l-cmd-checkout-b '' $master $rbranch; \
 fi && \
 if [ $(git l-check-is-on $showlog) != 'on' ]; then return 0; fi && \
 git l-echo-l2 \"$CMD 5:\"                                               && git w-list-mcf-param --local && \
 git l-echo \"Check branches upstream:\" 5 0 && \
 git l-echo-l2 \"$CMD 6:\"                                               && git br-info $master \
;}; f"

# l-flow-setup-dev $dev $master $src1 $showlog
l-flow-setup-dev = "! f(){\
 CMD='l-flow-setup-dev' && \
 quite=$(git l-quite) && \
 dev=${1:-} && \
 master=${2:-} && \
 src1=${3:-} && \
 showlog=${4:-on} && \
 git l-echo-l1 \"$CMD '$dev' '$master' '$src1' '$showlog'\" && \
 if [ \"$dev\" = '' -o "$master" = '' ]; then\
    git l-echo \"$CMD Error!!!\nMain and develop names of branches cannot be empty.\" 1 && \
    exit 1; \
 fi && \
 if [ \"$src1\" = '' ]; then src1=$(git l-mcf-param-get l-src1); fi && \
 rbranch=$src1/$dev && \
 if git l-check-exists-branch $dev; then\
    git l-echo-l2 \"$CMD 1:\"                                             && git l-cmd-checkout '' $dev; \
    if git l-check-exists-branch $rbranch; then\
	    git l-echo-l2 \"$CMD 2:\"                                         && git l-set-upstream-cbr $rbranch && \
		if [ \"$(git l-rev $dev)\" != \"$(git l-rev $rbranch)\" ]; then \
			git l-echo-l3 \"$CMD 3:\"		                              && git l-cmd-merge --ff $rbranch; \
		fi; \
	fi; \
 else \
    if git l-check-exists-branch $rbranch; then\
		git l-echo-l2 \"$CMD 5:\"                                         && git l-cmd-checkout-b '' $dev $rbranch; \
	else \
		git l-echo-l2 \"$CMD 6:\"                                         && git l-cmd-checkout-b '' $dev $master; \
	fi; \
 fi && \
 git l-echo-l2 \"$CMD 7:\"                                                && git l-new-master-cbr off && \
 git l-echo-l2 \"$CMD 8:\"                                                && git l-rebuild-base-lite off && \
 if [ $(git l-check-is-on $showlog) != 'on' ]; then return 0; fi && \
 git l-echo-l2 \"$CMD 9:\"                                                && git w-list-mcf-param --local && \
 git l-echo \"Check branches upstream:\" 5 0 && \
 git l-echo-l2 \"$CMD 10:\"                                               && git br-info $dev\
;}; f"

# l-flow-setup-feature $feature $dev $src1 $showlog
l-flow-setup-feature = "! f(){\
 CMD='l-flow-setup-feature' && \
 quite=$(git l-quite) && \
 feature=${1:-} && \
 dev=${2:-} && \
 src1=${3:-} && \
 showlog=${4:-on} && \
 git l-echo-l1 \"$CMD '$feature' '$dev' '$src1' '$showlog'\" && \
 if [ \"$dev\" = '' -o \"$feature\" = '' ]; then\
    git l-echo \"$CMD Error!!!\nFeature and develop names of branches cannot be empty.\" 1 && \
    exit 1; \
 fi && \
 if ! git l-check-exists-branch $dev ; then\
    git l-echo \"$CMD Error!!!\nThe branch '$dev' is not exists.\" 1 && \
    exit 1; \
 fi && \
 if [ \"$src1\" = '' ]; then src1=$(git l-mcf-param-get l-src1); fi && \
 rbranch=$src1/$feature && \
 if git l-check-exists-branch $feature; then\
	git l-echo-lc \"$CMD 1:\" \"git rebase $dev $feature\"             && git rebase $quite $dev $feature; \
 fi && \
 git l-echo-l2 \"$CMD 2:\"                                             && git l-hotfix-lite $feature off && \
 if git l-check-exists-branch $rbranch; then\
    git l-echo-l2 \"$CMD 3:\"                                          && git l-remove-local-branch -f $feature $dev; \
    git l-echo-lc \"$CMD 4:\"                                          && git l-cmd-checkout-b '' $feature $rbranch; \
 else\
    git l-echo-l2 \"$CMD 5:\"                                          && git l-cmd-checkout '' $feature; \
    git l-echo-l2 \"$CMD 6:\"                                          && git l-unset-upstream-cbr || :; \
 fi && \
 git l-echo-l2 \"$CMD 7:\"                                             && git l-rebuild-base-lite off; \
 if [ $(git l-check-is-on $showlog) != 'on' ]; then return 0; fi && \
 git l-echo-l2 \"$CMD 8:\"                                             && git w-list-mcf-param --local && \
 git l-echo \"Check branches and upstream:\" 5 0 && \
 git l-echo-l2 \"$CMD 9:\"                                             && git br-info $master\
;}; f"

################################################################################

##################################
# Attention only for old system!!!
# Only for fix old versions names
# Dangerously !!!
# *-old-*
##################################

l-fix-old-param = "! f(){ \
 CMD='l-fix-old-param' && \
 paramname=$1 && \
 old=$2 && \
 new=$3 && \
 type=--local && \
 cur=$(git l-mcf-param-get $paramname 1 $type); \
 git l-echo-l2 \"$CMD 1: name=$paramname type=$type cur_value=$cur\"; \
 if [ \"$cur\" != '' -a \"$cur\" = \"$old\" ]; then \
	git l-echo-l2 \"$CMD 2:\" && \
	git l-mcf-param-set \"$paramname\" \"$new\" \"$type\" 0; \
 fi && \
 type=--global && \
 cur=$(git l-mcf-param-get $paramname 1 $type); \
 git l-echo-l2 \"$CMD 3: name=$paramname type=$type cur_value=$cur\"; \
 if [ \"$cur\" != '' -a \"$cur\" = \"$old\" ]; then \
	git l-echo-l2 \"$CMD 4:\" && \
	git l-mcf-param-set \"$paramname\" \"$new\" \"$type\" 0; \
 fi \
;}; f"

l-fix-old-branch = "! f(){ \
 CMD='l-fix-old-branch' && \
 old=$1 && \
 new=$2 && \
 if git l-check-exists-branch $old; then \
	git l-echo-lc \"$CMD 1:\" \"git branch -m $old $new\" && git branch -m $old $new; \
 fi \
;}; f"

l-fix-all-old-names = "! f(){ \
 CMD='l-fix-all-old-names' && \
 git l-fix-old-branch fix _fix && \
 git l-fix-old-branch cfg _cfg && \
 git l-fix-old-param l-fix fix _fix && \
 git l-fix-old-param l-cfg cfg _cfg && \
 git l-fix-old-param l-prev-fix fix _fix && \
 git l-fix-old-param l-prev-cfg cfg _cfg && \
 git branch && \
 git w-list-mcf-param\
;}; f"

###################
### End ALIASES ###
###################
#!/bin/bash

set -e

cd "$(dirname "$0")"
CUR_DIR=$PWD
cd -
SRC_DIR="$CUR_DIR"/install.template
NAME_INSTALL_DIR=_install
NAME_INSTALL_PRG=00_install.sh
NAME_FIX_PRG=90_fix_win.bat
DST_DIR="$CUR_DIR"/"$NAME_INSTALL_DIR"
FILE_NAME_INFO="my_git_name_info"

bash "$CUR_DIR/00_prepare_install.sh"

[ $? ] || exit 1

mkdir -p "$DST_DIR/old"

[ -f "$DST_DIR"/"$NAME_INSTALL_PRG" ] && mv "$DST_DIR"/{,old/}"$NAME_INSTALL_PRG"
[ -f "$DST_DIR"/"$NAME_FIX_PRG"     ] && mv "$DST_DIR"/{,old/}"$NAME_FIX_PRG"

cp {"$SRC_DIR","$DST_DIR"}/"$NAME_INSTALL_PRG"
echo >> "$DST_DIR"/"$NAME_INSTALL_PRG"
echo "#user info" >> "$DST_DIR"/"$NAME_INSTALL_PRG"
cat "$CUR_DIR"/"$FILE_NAME_INFO" >> "$DST_DIR"/"$NAME_INSTALL_PRG"
cp {"$SRC_DIR","$DST_DIR"}/"$NAME_FIX_PRG"

echo -e "\e[1;36m""\nThe install program was prepared.\n""\e[0m"
echo "1. All user have to run installation after checked user info correct:"
echo  -e "\e[0;32m   bash \"$DST_DIR/$NAME_INSTALL_PRG\"\n\e[0m"
echo "2. After installation Windows users have to start the additional fix."
echo -e "   Go to the directory \e[0;32m'${NAME_INSTALL_DIR}'\e[0m with file \e[0;32m'${NAME_FIX_PRG}'\e[0m and start it.\n"

exit 0
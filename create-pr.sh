#!/bin/bash
# Author: Chris Tatro
# Date: 10/6/2022

SCRIPT_NAME=$(basename $BASH_SOURCE) 


#export BRANCH_NAME=test9
pwd

echo "${SCRIPT_NAME}:: Jenkins working branch: ${BRANCH_NAME}"

# git checkout master
# git --no-pager branch

# echo "${SCRIPT_NAME}:: merge branch ${BRANCH_NAME} with master"
# git merge $BRANCH_NAME || MR=$? 
# echo "${SCRIPT_NAME}:: $?"
# echo "${SCRIPT_NAME}:: $MR"
# if [[ $MR == 1 ]]; then
  # echo "${SCRIPT_NAME}:: Auto-merging failed with exit code ${MR}, perform merge reset"
  # git reset --merge
  echo "${SCRIPT_NAME}:: Creating PR"
  gh auth login --hostname github.com --git-protocol https
  git checkout $BRANCH_NAME
  gh pr create --title "Please approve my PR" --body "Please approve my PR" --base master --reviewer tatroc
  # echo "${SCRIPT_NAME}:: merge request exit code $MR"
  # exit $MR
# fi

# #if [[ $MR == 0 ]]; then
# if [[ -z "${MR}" ]]; then
#   echo "${SCRIPT_NAME}:: git pull"
#   git pull
#   echo "${SCRIPT_NAME}:: git push origin master"
#   git push origin master
# fi

# if [[ -z "${MR}" ]]; then
#   echo "variable \$MR is empty"
#   exit 1
# fi
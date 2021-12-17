# SHELLOMO

A shell app for [flomo](https://flomoapp.com/register2/?Mzk4Nw)  
flomo 命令行工具

## 使用指南

```sh
$ git clone git@github.com:sfyumi/shellomo.git
$ cd shellomo
$ FLOMO_PATH=`pwd`/flomo.sh
$ cd ~
$ echo 'alias flomo="'$FLOMO_PATH'"' >> .bash_profile
$ source .bash_profile
# if you use zshell, write alias to .zsh_rc
$ flomo --api https://flomoapp.com/iwh/Mg/yourapisecretskey/
$ flomo -m "Hello shellomo"
send "Hello shellomo" to flomo
$ flomo -t inbox -m "Hello shellomo"
send "Hello shellomo #inbox" to flomo
```

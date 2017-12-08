sechelp() {
    echo "Local Security Wiki"
    echo "props to https://github.com/nixawk/pentest-wik"
    if [ -z $1 ]; then
        echo "no input, options are: "
    elif [ $1 = "info" ]; then
        _info
    fi
}

_log_heading() {
    echo -e ""
    echo -e "\033[34m${1}\033[0m"
    echo -e "\033[36m================================================================================\033[0m"
}


_log_step() {
    # $1 = prefix
    # $2 = message
    echo -e "${1}\t\t  ${2}"
}



_info() {
    _log_heading "Information Gathering"
    _log_step "uname -a" "The uname command reports basic information about a computer's software and hardware."
    _log_step "cat /etc/issue" "The file /etc/issue is a text file which contains a message or system identification to be printed before the login prompt."
    _log_step "cat /etc/*-release" "/etc/lsb-release, /etc/redhat-release files contain a description line which is parsed to get information. ex: 'Distributor release x.x (Codename)'"
    _log_step "cat /proc/version" "/proc/version specifies the version of the Linux kernel, the version of gcc used to compile the kernel, and the time of kernel compilation. It also contains the kernel compiler's user name."
    _log_step "cat /proc/sys/kernel/version" "The files in /proc/sys/kernel/ can be used to tune and monitor miscellaneous and general things in the operation of the Linux kernel. Kernel - Documentation"

}

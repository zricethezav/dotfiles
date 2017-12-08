#if [ ! -d ~/.sec ]; then
    # mkdir ~/.sec
#fi

source_line="source ~/.sec/scripts.sh"
grep -q "^${source_line}" ${HOME}/.bashrc || \
    echo "${source_line}" >> ${HOME}/.bashrc


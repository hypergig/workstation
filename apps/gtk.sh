[ -d ~/.themes ] || mkdir -pv ${HOME}/.themes

(
    cd /tmp && curl -fLO https://raw.githubusercontent.com/rtlewis88/rtl88-Themes/Solarized-Dark/Solarized-Dark-Orange-GTK_1.5.1.tar.gz
)&

posts['Solarized-Dark-GTK_1']+="tar xzvf /tmp/Solarized-Dark-Orange-GTK_1.5.1.tar.gz -C ${HOME}/.themes"

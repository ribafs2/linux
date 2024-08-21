# Baixar um site completo. Já usei para baixar meu site criado em Joomla e converti para um site estático, que está aqui:
# https://ribafs.me/portal
wget \
     --recursive \
     --no-clobber \
    -P /backup/ribafsgh \
     --page-requisites \
     --html-extension \
     --convert-links \
     --restrict-file-names=windows \
     --no-parent \
http://backup/ribafs


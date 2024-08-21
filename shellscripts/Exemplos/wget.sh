# Exportar um site dinâmico completo para html estático. Sites criados em Joomla, Wordpress, aplicativos com frameworks, etc. O site abaixo foi criado com Joomla e agora está no Github de gratis. O original não existe mais, que era ribafs.org:
# https://ribafs.github.io/portal/
wget \
     --recursive \
     --no-clobber \
     --page-requisites \
     --html-extension \
     --convert-links \
     --restrict-file-names=windows \
     --no-parent \
     $1
# Exemplo
# sh wget https://ribafs.org

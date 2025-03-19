# 1) Verwende das offizielle Apache-Image als Basis
FROM httpd:latest

# 2) Optional: Label mit deinem Namen/E-Mail
LABEL maintainer="marcb@marcb-virtual-machine.com"

# 3) Lokale HTML-Datei mit Apache mappen
COPY html/ /usr/local/apache2/htdocs/

# 4) Standard-Port 80 im Container
EXPOSE 80

# 5) Apache im Vordergrund starten
CMD ["httpd-foreground"]





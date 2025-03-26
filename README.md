# Apache mit Docker

Ich habe eine Umgebung erstellt, in der Apache in einem Docker-Container läuft. Dabei werden die HTML-Dateien sowie die Logs über Bind-Mounts direkt in das Host-Dateisystem eingebunden, sodass Änderungen an der Webseite sofort sichtbar sind und die Logs auf dem Host gespeichert werden.

## Verzeichnisstruktur

Mein Projektverzeichnis hat folgende Struktur:

```
my-apache-docker/
─ html/
   └─ index.html
─ logs/
─ Dockerfile
```

- `html/` enthält meine Webinhalte (Website).
- `logs/` speichert die Apache-Logdateien.
- `Dockerfile` ist das zentrale File zur Erstellung des Docker-Images.

## Beispiel-HTML-Seite

Die Datei `html/index.html` enthält eine einfache Beispiel-Webseite, welches ich mit hilfe von Chat-GPT:

[Link zur index.html](html/index.html)


## Dockerfile

Ich habe folgendes `Dockerfile` erstellt:

[Link zum Dockerfile](Dockerfile)


## Docker-Image bauen

Ich habe das Docker-Image mit folgendem Befehl erstellt:

```bash
docker build -t my-apache-image .
```

- `-t my-apache-image` gibt dem Image einen Namen.
- `.` bedeutet, dass das `Dockerfile` im aktuellen Verzeichnis verwendet wird.

Das Image kann mit folgendem Befehl angezeigt werden:

```bash
docker images
```

## Container starten

Um den Container mit Port 8080 und den Bind-Mounts zu starten, habe ich folgenden Befehl ausgeführt:

```bash
docker run -d \
  -p 8080:80 \
  -v $(pwd)/html:/usr/local/apache2/htdocs \
  -v $(pwd)/logs:/usr/local/apache2/logs \
  --name my-apache-container \
  my-apache-image
```

### Parameter-Erklärung:
- `-d` lässt den Container im Hintergrund laufen.
- `-p 8080:80` macht den Container über `http://localhost:8080` erreichbar.
- `-v $(pwd)/html:/usr/local/apache2/htdocs` bindet das `html/`-Verzeichnis ein, sodass Änderungen sofort sichtbar sind.
- `-v $(pwd)/logs:/usr/local/apache2/logs` speichert die Logs direkt auf dem Host.
- `--name my-apache-container` gibt dem Container einen Namen.
- `my-apache-image` ist das Image, das zuvor gebaut wurde.

## Webseite testen

Ich kann meine Webseite über folgenden Link aufrufen:

```
http://localhost:8080/
```

Falls ich Änderungen an `index.html` vornehme, werden sie sofort sichtbar, da das Verzeichnis als Bind-Mount eingebunden ist.

## Logs überprüfen

Die Apache-Logs finde ich in meinem `logs/`-Ordner auf dem Host-System. Besonders relevant sind:

- `access_log` → Dokumentiert alle Zugriffe auf die Webseite.
- `error_log` → Zeigt Fehler an, falls welche auftreten.

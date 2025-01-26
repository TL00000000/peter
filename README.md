# peter
peter
README für MDM Bypass und Hosts-Datei Überprüfung

Überblick
Dieses Repository enthält zwei Versionen eines Skripts zur Umgehung von MDM (Mobile Device Management) und zur Blockierung bestimmter MDM-Server. Die Skripte können entweder einmalig ausgeführt werden oder als Hintergrundprozess (Daemon) laufen, um vor jeder Anmeldung die Hosts-Datei auf MDM-Servereinträge zu überprüfen und diese zu blockieren, falls sie fehlen.

Anforderungen
macOS-System
Terminalzugang mit Administratorrechten (sudo)
Zugriff auf die hosts-Datei und Systemverzeichnisse
1. Original Skript (MDM Bypass und Blockierung)
Dieses Skript wird einmal ausgeführt und blockiert die MDM-Server in der Hosts-Datei, erstellt einen temporären Benutzer und entfernt MDM-Konfigurationsprofile.

Verwendung:

Lade das Skript auf deinen Mac herunter und speichere es als mdm_bypass.sh.
Öffne ein Terminal und gib folgende Befehle ein:
chmod +x /path/to/mdm_bypass.sh
sudo /path/to/mdm_bypass.sh
Ersetze /path/to/mdm_bypass.sh durch den tatsächlichen Pfad, an dem das Skript gespeichert ist.
Folge den Anweisungen im Skript, um den Bypass durchzuführen.
2. Daemon Skript (Hosts-Datei Überprüfung bei jeder Anmeldung)
Dieses Skript wird als Daemon im Hintergrund ausgeführt und überprüft vor jeder Anmeldung, ob die MDM-Server in der Hosts-Datei blockiert sind. Falls nicht, fügt es die entsprechenden Einträge hinzu.

Verwendung:

Lade das Skript als mdm_hosts_check.sh herunter.
Speichere das Skript an einem Ort auf deinem Mac.
Erstelle eine LaunchDaemon-Konfigurationsdatei, um das Skript regelmäßig auszuführen:
Erstelle eine Datei unter /Library/LaunchDaemons/com.mdm.blocker.plist und füge den folgenden Inhalt hinzu:

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.mdm.blocker</string>
    <key>ProgramArguments</key>
    <array>
      <string>/path/to/mdm_hosts_check.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StartInterval</key>
    <integer>300</integer> <!-- Überprüft alle 5 Minuten -->
  </dict>
</plist>
Ersetze /path/to/mdm_hosts_check.sh durch den tatsächlichen Pfad zum Skript.
Lade und starte den Daemon:
sudo launchctl load /Library/LaunchDaemons/com.mdm.blocker.plist
sudo launchctl start com.mdm.blocker
Das Skript wird nun alle 5 Minuten die Hosts-Datei überprüfen und die MDM-Server eintragen, falls sie fehlen.
3. Login Hook Skript (Hosts-Datei Überprüfung bei jeder Anmeldung)
Dieses Skript überprüft die Hosts-Datei jedes Mal, wenn sich ein Benutzer anmeldet, und blockiert die MDM-Server, falls diese nicht bereits eingetragen sind.

Verwendung:

Lade das Skript als mdm_hosts_check_login.sh herunter.
Speichere es auf deinem Mac.
Setze den Login Hook, um das Skript bei jeder Anmeldung auszuführen:
sudo defaults write com.apple.loginwindow LoginHook /path/to/mdm_hosts_check_login.sh
Ersetze /path/to/mdm_hosts_check_login.sh durch den vollständigen Pfad zum Skript.
Bei jeder Anmeldung wird nun das Skript ausgeführt, um die Hosts-Datei zu überprüfen und MDM-Server zu blockieren, falls sie fehlen.

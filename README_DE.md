[English](README.md) | [Deutsch](README_DE.md)

# ClassQoL Talent Warning

**Version 0.1.1 · World of Warcraft WotLK 3.3.5a · MIT**

Ein schlankes Client-Addon für Server mit `mod-class-qol` 0.2.3 und allen
37 ausgewählten Talentfreigaben. Es markiert diese Talentknoten im eigenen
Blizzard-Talentfenster mit einem roten Rahmen und ergänzt einen Tooltip-Hinweis.

Repository: [theprinceofbucket/ClassQoLTalentWarning](https://github.com/theprinceofbucket/ClassQoLTalentWarning).

## Funktionen

- Enthält alle 37 ausgewählten Talentknoten der zehn spielbaren Klassen.
- Markiert nur Talente der eigenen Klasse; Begleiter- und Inspektionsfenster bleiben ausgenommen.
- Deutscher Client (`deDE`): **ClassQoL: Wird serverseitig auf maximalem Rang gewährt.**
- Alle anderen Client-Sprachen: **ClassQoL: Granted by the server at maximum rank.**
- Reguläre Ränge, Voraussetzungen, Talentpunkte und Klickverhalten bleiben erhalten.
- Eine Lua-Datei zur Laufzeit, keine Bibliotheken, Einstellungsdateien,
  Servernachrichten oder laufenden Abfragen. Aktualisiert nach einem Blizzard-Update
  des Talentfensters und beim Anzeigen eines Talent-Tooltips.

## Voraussetzungen

- Der originale WoW-WotLK-Client **3.3.5a** (Addon-Interface `30300`).
- Das originale Blizzard-Talentfenster.
- Ein Server mit derselben `mod-class-qol`-Talentauswahl und allen Freigaben aktiviert.

Diese Version ist nicht für Retail oder moderne WoW-Classic-Clients ausgelegt.

## Installation und Updates

1. Unter den Release-Downloads **ClassQoLTalentWarning.zip** herunterladen.
   Solange die Veröffentlichung aussteht, das lokal bereitgestellte ZIP dieses Namens verwenden.
2. WoW schließen und das Archiv nach `World of Warcraft/Interface/AddOns` entpacken.
3. Prüfen, dass diese Datei ohne zusätzliche Ordnerebene vorhanden ist:
   `Interface/AddOns/ClassQoLTalentWarning/ClassQoLTalentWarning.toc`.
4. **ClassQoL Talent Warning** in der Addon-Liste der Charakterauswahl aktivieren und einloggen.

Zum Aktualisieren den vorhandenen Ordner `ClassQoLTalentWarning` ersetzen.
Das Addon speichert keine Einstellungen. Server-SQL, Client-DBC-Änderungen und
Kompilieren sind nicht erforderlich.

## Bedienung

Das Talentfenster mit der üblichen Taste (standardmäßig **N**) öffnen, einen
Talentbaum wählen und mit der Maus über ein markiertes Talent fahren. Der rote
Rahmen ist unabhängig von den regulär investierten Punkten sichtbar.
Es gibt keine Befehle oder Optionen einzustellen.

Der Hinweis beschreibt die Talentfreigabe des Servermoduls. Er fordert nicht zum
Investieren von Punkten auf und hebt normale Baumvoraussetzungen nicht auf.

## Einschränkungen und Teststand

Das Addon liest keine Serverkonfiguration und prüft keine aktiven Auren. Es setzt
alle ausgewählten Talentfreigaben als aktiviert voraus. Benötigte Basisfähigkeiten
und bedingte Effekte folgen weiterhin den Regeln des Servermoduls. Ein Rahmen
beweist deshalb nicht, dass jeder Effekt gerade aktiv ist. Paladin-Sonderfälle und
andere Klassenausnahmen behandelt der Server, nicht dieses Anzeige-Addon.

Geänderte Client-Talentbäume, alternative Talentfenster und abweichende Modulauswahlen
können Anpassungen erfordern. Glyphen, Zauber und separate QoL-Funktionen wie
Free Shouts erhalten keine eigenen Hinweise.

Der Projektbetreiber hat sich mit der ersten Ausführung im Spiel zufrieden gezeigt.
Lokal wurden die 37 DBC-Talentkoordinaten und Klassenzuordnungen, Lua-Syntax,
Paketstruktur und Versionskonsistenz geprüft. Der Projektbetreiber hat Deutsch
und Englisch in 0.1.1 erfolgreich getestet: Sprache in den Spieleinstellungen
geändert und das Spiel für jede Sprache neu gestartet. Vollständige Prüfungen aller
Klassen, Dual Spec und Addon-Kompatibilität stehen ebenfalls aus.
Siehe [Testplan](docs/TESTING.md).

## Quellcode und Release-Paket

TOC und Lua-Datei sind direkt verwendbar. Zur Prüfung und Erstellung des ZIPs
im Repository-Ordner mit **Python ab 3.9** ausführen:

```sh
python tools/build_release.py
```

Unter Windows geht auch `py -3 tools/build_release.py`. Python ist nur für die
Entwicklung nötig. Ausgaben: `dist/ClassQoLTalentWarning.zip` und
`dist/SHA256SUMS.txt`. Das Skript verwendet eine feste Dateiliste, prüft das
Archiv und lädt nichts hoch. Weitere Angaben stehen in den
[Release-Notizen v0.1.1](docs/releases/v0.1.1.md) und den
[Updater-Hinweisen](docs/UPDATER.md).

## Entstehung und Lizenz

Erstellt von **theprinceofbucket mit Unterstützung von OpenAI ChatGPT/Codex**
bei Planung, Programmierung, Fehlersuche, Prüfungen und Dokumentation. Entscheidungen,
praktische Tests und Rückmeldungen kamen vom Projektbetreiber. Dies ist ein
unabhängiges Community-Projekt, kein offizielles OpenAI- oder Blizzard-Produkt.

Der Quellcode dieses Addons steht unter der [MIT-Lizenz](LICENSE). Diese gilt für
dieses Addon, nicht für AzerothCore, das Servermodul, den WoW-Client oder andere
Addons. Blizzard-UI-Quellcode, DBC-Daten und externe Bibliotheken sind nicht
enthalten. Änderungen stehen in [CHANGELOG.md](CHANGELOG.md).

# Verification and game tests / Prüfungen und Spieltests

## Verified locally / Lokal geprüft

- All 37 talent IDs, coordinates and class masks were checked against the supplied
  WotLK Talent.dbc and TalentTab.dbc files during initial development. These data
  files are not included. / Alle 37 Talentzuordnungen wurden während der Entwicklung
  gegen die bereitgestellten WotLK-DBC-Dateien geprüft; die Daten sind nicht enthalten.
- The current runtime code differs from the previously checked 0.1.1 only in
  license/copyright comments. Lua grammar parsing was checked locally. / Der aktuelle
  Laufzeitcode unterscheidet sich nur in Lizenz-/Urheberkommentaren von 0.1.1.
  Die Lua-Grammatik wurde lokal geprüft.
- The release script checks versions, relative documentation links, the allowlisted
  file set, MIT metadata, obvious secret/path patterns and the ZIP contents and CRC.
  This is not a guarantee that every possible secret can be detected. / Das
  Release-Skript prüft Versionen, lokale Links, Dateiliste, MIT-Angaben, auffällige
  Geheimnis-/Pfadmuster sowie ZIP-Inhalt und CRC. Die Suche erkennt nicht jedes denkbare Geheimnis.

## Owner feedback / Rückmeldung

The project owner reported satisfaction with the initial addon implementation
in October 2026. Specific successful checks are recorded below; these do not
establish exhaustive coverage of every class-specific interaction.
Der Projektbetreiber war mit der ersten Addon-Ausführung zufrieden. Die konkret
bestandenen Prüfungen stehen unten; daraus wird kein vollständiger Test aller
klassenspezifischen Wechselwirkungen abgeleitet.

## Passed in-game: German and English / Im Spiel bestanden: Deutsch und Englisch

The project owner successfully tested both tooltip languages in version 0.1.1.
For each language, the client language was changed in the game settings and the
game was restarted. The German and English tooltip messages were displayed correctly.

Der Projektbetreiber hat beide Tooltip-Sprachen in Version 0.1.1 erfolgreich
getestet. Dafür wurde die Client-Sprache in den Spieleinstellungen geändert und
das Spiel für jede Sprache neu gestartet. Deutscher und englischer Hinweis
wurden korrekt angezeigt.

## Passed in-game: ten classes and DK dual spec / Im Spiel bestanden: zehn Klassen und DK-Dual-Spec

The project owner logged in once on each of the ten playable classes and opened
the talent window with **N** to check the addon display. All ten classes displayed
the markers correctly. On the Death Knight, the owner also used dual spec and
confirmed correct display in both specializations.

Der Projektbetreiber hat alle zehn spielbaren Klassen jeweils einmal eingeloggt
und mit **N** das Talentfenster geöffnet, um die Addon-Anzeige zu kontrollieren.
Bei allen zehn Klassen wurden die Markierungen korrekt angezeigt. Beim Todesritter
wurde zusätzlich Dual Spec verwendet; die Darstellung funktionierte in beiden
Spezialisierungen.

This confirms the reported display checks, not every possible rank, reset,
preview or third-party addon interaction. / Bestätigt sind diese Anzeigeprüfungen,
nicht alle möglichen Rang-, Reset-, Vorschau- oder Fremdaddon-Wechselwirkungen.

## Open in-game checks / Offene Prüfungen im Spiel

1. Check the English fallback on additional non-German client locales.
   / Englischen Fallback auf weiteren nichtdeutschen Client-Sprachen prüfen.
2. Check unmarked talents for absence of an addon note.
   / Bei unmarkierten Talenten das Ausbleiben des Addon-Hinweises prüfen.
3. Extend the successful display checks to talent ranks, window reopening,
   talent preview, resets and dual-spec switches on the other nine classes.
   / Die bestandenen Anzeigeprüfungen um Ränge, erneutes Öffnen, Talentvorschau,
   Reset und Dual Spec bei den übrigen neun Klassen erweitern.
4. Confirm normal clicks and talent allocation work, pet/inspect windows do not
   receive markers, and tooltips contain the note only once. / Normale Vergabe,
   keine Begleiter-/Inspektionsmarkierungen und keine doppelten Hinweise prüfen.
5. Test alongside the owner's normal UI addons. Replacement talent windows are
   outside the initial support scope. / Mit den üblichen UI-Addons testen.
6. After approval and publication: download the actual release assets, compare the
   checksum and test installation/update with WoW Addon Updater.
   / Nach Freigabe echte Release-Downloads und Installation durch den Updater testen.

Release packaging is not a live WoW test. / Paketprüfungen ersetzen keinen Spieltest.

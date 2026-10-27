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
in October 2026. This is not recorded as a complete all-class test pass.
Der Projektbetreiber war mit der ersten Addon-Ausführung zufrieden. Daraus wird
kein vollständiger Test aller Klassen abgeleitet.

## Passed in-game: German and English / Im Spiel bestanden: Deutsch und Englisch

The project owner successfully tested both tooltip languages in version 0.1.1.
For each language, the client language was changed in the game settings and the
game was restarted. The German and English tooltip messages were displayed correctly.

Der Projektbetreiber hat beide Tooltip-Sprachen in Version 0.1.1 erfolgreich
getestet. Dafür wurde die Client-Sprache in den Spieleinstellungen geändert und
das Spiel für jede Sprache neu gestartet. Deutscher und englischer Hinweis
wurden korrekt angezeigt.

## Open in-game checks / Offene Prüfungen im Spiel

1. Check the English fallback on additional non-German client locales.
   / Englischen Fallback auf weiteren nichtdeutschen Client-Sprachen prüfen.
2. Death Knight: check all six marked talents across Blood, Frost and Unholy.
   Check one unmarked talent and confirm there is no addon note.
   / Alle sechs DK-Talente und mindestens ein unmarkiertes Talent prüfen.
3. Repeat across all ten classes, talent ranks, tree tabs, window reopening,
   talent preview, resets and dual-spec switches. / Alle Klassen, Ränge, Tabs,
   erneutes Öffnen, Talentvorschau, Reset und Dual Spec prüfen.
4. Confirm normal clicks and talent allocation work, pet/inspect windows do not
   receive markers, and tooltips contain the note only once. / Normale Vergabe,
   keine Begleiter-/Inspektionsmarkierungen und keine doppelten Hinweise prüfen.
5. Test alongside the owner's normal UI addons. Replacement talent windows are
   outside the initial support scope. / Mit den üblichen UI-Addons testen.
6. After approval and publication: download the actual release assets, compare the
   checksum and test installation/update with WoW Addon Updater.
   / Nach Freigabe echte Release-Downloads und Installation durch den Updater testen.

Release packaging is not a live WoW test. / Paketprüfungen ersetzen keinen Spieltest.

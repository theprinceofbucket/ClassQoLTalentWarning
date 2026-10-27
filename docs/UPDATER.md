# WoW Addon Updater integration / Einbindung

Repository: [theprinceofbucket/ClassQoLTalentWarning](https://github.com/theprinceofbucket/ClassQoLTalentWarning),
branch `main`. The owner supplied this public repository and its URL was checked.
The catalog entry below can be used once the source has been published on `main`.

Der Projektbetreiber hat dieses öffentliche Repository angegeben; der Link wurde
geprüft. Branch: `main`. Der folgende Katalogeintrag kann verwendet werden,
sobald der Quellstand auf `main` veröffentlicht ist.

## Catalog entry / Katalogeintrag

Based on the current schema of
[WoW Addon Updater](https://github.com/theprinceofbucket/WoW-Addon-Updater):

```json
{
  "name": "ClassQoL Talent Warning",
  "enabled": true,
  "type": "github",
  "repository": "https://github.com/theprinceofbucket/ClassQoLTalentWarning",
  "branch": "main",
  "addons": ["ClassQoLTalentWarning"]
}
```

Add this entry to the updater's `sources` list after publication. The current
updater embeds its catalog in the EXE: editing an external JSON alone does not
change that EXE. Rebuild the updater to distribute the new catalog.

Nach Veröffentlichung zur `sources`-Liste hinzufügen. Der aktuelle Updater
bettet den Katalog in die EXE ein. Eine externe JSON ändert die EXE nicht;
für die neue Auswahl ist ein neuer Updater-Build nötig.

The repository root contains `ClassQoLTalentWarning.toc`; the updater detects
that TOC and installs the target folder as `ClassQoLTalentWarning`.
The JSON is an example, not a completed installation test.

Die TOC liegt im Repository-Hauptordner und wird dem Zielordner
`ClassQoLTalentWarning` zugeordnet. Das Beispiel ist noch kein Installationstest.

## Stable release assets / Stabile Release-Dateien

Keep these asset names for future releases:

```text
ClassQoLTalentWarning.zip
SHA256SUMS.txt
```

Permanent latest download / Dauerhafter Download der neuesten Version:

```text
https://github.com/theprinceofbucket/ClassQoLTalentWarning/releases/latest/download/ClassQoLTalentWarning.zip
```

Fixed version download / Download dieser Version:

```text
https://github.com/theprinceofbucket/ClassQoLTalentWarning/releases/download/v0.1.1/ClassQoLTalentWarning.zip
```

These release URLs require the corresponding published release assets.
The GitHub-type updater entry reads the main branch archive, not these
release assets. The packaged ZIP is available for manual installation.

Diese Release-URLs benötigen die entsprechend veröffentlichten Release-Dateien.
Der GitHub-Katalogeintrag liest den Main-Branch, nicht diese Release-Dateien.
Das ZIP ist zusätzlich für die manuelle Installation vorgesehen.

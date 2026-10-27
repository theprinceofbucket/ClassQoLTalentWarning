#!/usr/bin/env python3
"""Validate and package public project files only. No network or upload operations."""
import hashlib
from pathlib import Path, PurePosixPath
import re
import zipfile

ROOT = Path(__file__).resolve().parents[1]
ADDON = "ClassQoLTalentWarning"
PUBLIC_FILES = (
    ".gitattributes", ".gitignore", "CHANGELOG.md", "LICENSE",
    "README.md", "README_DE.md", "ClassQoLTalentWarning.lua",
    "ClassQoLTalentWarning.toc", "docs/TESTING.md", "docs/UPDATER.md",
    "docs/releases/v0.1.1.md", "tools/build_release.py",
)


def require(condition, message):
    if not condition:
        raise SystemExit("Validation failed: " + message)


def validate():
    files = {name: (ROOT / name).read_bytes() for name in PUBLIC_FILES}
    text = {name: data.decode("utf-8") for name, data in files.items()}
    toc = text[ADDON + ".toc"]
    match = re.search(r"^## Version: (\d+\.\d+\.\d+)$", toc, re.M)
    require(match, "TOC version missing")
    version = match.group(1)
    require("docs/releases/v" + version + ".md" in files, "release note/version mismatch")
    require("## Interface: 30300" in toc, "incorrect client interface")
    require("## Author: theprinceofbucket" in toc, "incorrect TOC author")
    require("## X-License: MIT" in toc, "incorrect TOC license")
    loaded = [line.strip() for line in toc.splitlines() if line.strip() and not line.startswith("#")]
    require(loaded == [ADDON + ".lua"], "unexpected runtime files")
    lua = text[ADDON + ".lua"]
    require("SPDX-License-Identifier: MIT" in lua, "missing runtime MIT header")
    require("Copyright (c) 2026 theprinceofbucket" in lua, "missing runtime copyright")
    require('GetLocale() == "deDE"' in lua, "locale selection missing")
    require('and "ClassQoL: Wird serverseitig auf maximalem Rang gewährt."' in lua,
            "German message missing")
    require('or "ClassQoL: Granted by the server at maximum rank."' in lua,
            "English fallback missing")
    require(len(re.findall(r"\{\s*\d+,\s*\d+,\s*\d+,\s*\d+\s*\}", lua)) == 37,
            "talent count mismatch")
    require(not re.search(r"SetScript\(\s*['\"]OnUpdate|SendAddonMessage\s*\(", lua),
            "unexpected polling or server communication")
    require("MIT License" in text["LICENSE"] and
            "Copyright (c) 2026 theprinceofbucket" in text["LICENSE"], "MIT license mismatch")
    require("## " + version in text["CHANGELOG.md"], "changelog/version mismatch")
    nav = "[English](README.md) | [Deutsch](README_DE.md)"
    for name in ("README.md", "README_DE.md"):
        require(text[name].startswith(nav + "\n"), name + " language navigation")
        require("Version " + version in text[name], name + " version mismatch")
        require("OpenAI ChatGPT/Codex" in text[name], name + " assistance credit missing")

    secret_patterns = (
        r"gh[pousr]_[A-Za-z0-9]{30,}", r"github_pat_[A-Za-z0-9_]{50,}",
        r"AKIA[0-9A-Z]{16}", r"-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----",
        r"[A-Za-z]:[\\/](?:Users|home)[\\/]", r"/home/[a-zA-Z0-9_-]+/",
    )
    for name, content in text.items():
        require(not any(re.search(pattern, content) for pattern in secret_patterns),
                "possible secret or personal path in " + name)
        if name.endswith(".md"):
            for target in re.findall(r"\[[^\]]+\]\(([^)]+)\)", content):
                if "://" in target or target.startswith("#"):
                    continue
                target_path = target.split("#", 1)[0]
                candidate = (ROOT / name).parent / target_path
                resolved = candidate.resolve()
                require(resolved.is_relative_to(ROOT) and resolved.is_file(),
                        "broken or external local link in " + name + ": " + target)
                require(resolved.relative_to(ROOT).as_posix() in files,
                        "linked file missing from public package: " + target)
    print("PASS: public file list, versions, MIT, locale wiring, 37 talents, local links and basic privacy checks")
    return version, files


def main():
    version, files = validate()
    output = ROOT / "dist"
    output.mkdir(exist_ok=True)
    archive = output / (ADDON + ".zip")
    with zipfile.ZipFile(archive, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=9) as package:
        for name in sorted(files):
            info = zipfile.ZipInfo(ADDON + "/" + name, date_time=(1980, 1, 1, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            info.create_system = 3
            info.external_attr = 0o100644 << 16
            package.writestr(info, files[name], compresslevel=9)
    with zipfile.ZipFile(archive) as package:
        require(package.testzip() is None, "ZIP CRC check")
        actual = {info.filename: package.read(info) for info in package.infolist()}
        expected = {ADDON + "/" + name: content for name, content in files.items()}
        require(actual == expected, "archive differs from approved public files")
        for name in actual:
            require(".." not in PurePosixPath(name).parts, "unsafe archive path")
    digest = hashlib.sha256(archive.read_bytes()).hexdigest()
    (output / "SHA256SUMS.txt").write_text(digest + "  " + archive.name + "\n", encoding="ascii")
    print("PASS: ZIP contents and CRC;", len(files), "files; release v" + version)
    print(archive)
    print("SHA256:", digest)
    print("No GitHub upload performed. Client and online updater tests remain separate.")


if __name__ == "__main__":
    main()

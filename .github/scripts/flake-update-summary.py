#!/usr/bin/env python3
"""Render changed locked inputs by comparing two flake.lock files."""

import json
import sys
from pathlib import Path
from urllib.parse import quote


def source(locked):
    kind = locked.get("type")
    if kind in {"github", "gitlab", "sourcehut"}:
        host = locked.get("host", {"github": "github.com", "gitlab": "gitlab.com", "sourcehut": "sr.ht"}[kind])
        owner = locked["owner"]
        if kind == "sourcehut":
            owner = "~" + owner.lstrip("~")
        return f"https://{host}/{owner}/{locked['repo']}"
    return locked.get("url") or locked.get("path") or "—"


def revision(locked):
    rev = locked.get("rev")
    if rev:
        short = rev[:8]
        kind = locked.get("type")
        if kind in {"github", "gitlab", "sourcehut"}:
            route = "/-/tree/" if kind == "gitlab" else "/tree/"
            return f"[{short}]({source(locked)}{route}{quote(rev, safe='')})"
        return short
    nar_hash = locked.get("narHash")
    if nar_hash:
        algorithm, separator, digest = nar_hash.partition("-")
        return f"{algorithm}{separator}{digest[:8]}{'…' if len(digest) > 8 else ''}"
    return locked.get("ref") or "—"


def cell(value):
    return str(value).replace("|", "\\|").replace("\n", " ").replace("\r", " ")


def summary(before, after):
    old_nodes, new_nodes = before["nodes"], after["nodes"]
    lines = ["| Input | Old rev | New rev | Source |", "|-------|---------|---------|--------|"]
    for name in sorted(old_nodes.keys() | new_nodes.keys()):
        old = old_nodes.get(name, {}).get("locked", {})
        new = new_nodes.get(name, {}).get("locked", {})
        if old == new:
            continue
        old_source, new_source = source(old), source(new)
        origin = f"{old_source} → {new_source}" if old and new and old_source != new_source else source(new or old)
        lines.append("| " + " | ".join(map(cell, (name, revision(old), revision(new), origin))) + " |")
    return "\n".join(lines) + "\n"


if __name__ == "__main__":
    before, after = (json.loads(Path(path).read_text()) for path in sys.argv[1:])
    print(summary(before, after), end="")

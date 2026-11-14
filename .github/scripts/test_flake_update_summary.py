import runpy
import unittest
from pathlib import Path


summary = runpy.run_path(str(Path(__file__).with_name("flake-update-summary.py")))["summary"]


def lock(**inputs):
    return {"nodes": {name: {"locked": value} for name, value in inputs.items()}}


class SummaryTests(unittest.TestCase):
    def test_github_revisions_come_from_separate_locks(self):
        repo = {"type": "github", "owner": "NixOS", "repo": "nixpkgs"}
        old_rev, new_rev = "a" * 40, "b" * 40
        before = lock(nixpkgs={**repo, "rev": old_rev}, same=repo)
        after = lock(nixpkgs={**repo, "rev": new_rev}, same=repo)
        result = summary(before, after)
        self.assertIn(f"[aaaaaaaa](https://github.com/NixOS/nixpkgs/tree/{old_rev})", result)
        self.assertIn(f"[bbbbbbbb](https://github.com/NixOS/nixpkgs/tree/{new_rev})", result)
        self.assertNotIn("| same |", result)

    def test_added_removed_inputs_and_full_content_hashes(self):
        before = lock(removed={"type": "path", "path": "/old", "narHash": "sha256-old="})
        after = lock(added={"type": "tarball", "url": "https://example.org/source.tgz", "narHash": "sha256-new="})
        result = summary(before, after)
        self.assertIn("| added | — | sha256-new= | https://example.org/source.tgz |", result)
        self.assertIn("| removed | sha256-old= | — | /old |", result)

    def test_source_changes_and_custom_gitlab_host(self):
        before = lock(dep={"type": "git", "url": "https://example.org/old.git", "rev": "old"})
        after = lock(dep={"type": "gitlab", "host": "git.example.org", "owner": "team", "repo": "dep", "rev": "new"})
        self.assertIn("https://example.org/old.git → https://git.example.org/team/dep", summary(before, after))

    def test_markdown_cells_escape_pipes(self):
        after = lock(dep={"type": "path", "path": "/a|b", "narHash": "sha256-new="})
        self.assertIn(r"/a\|b", summary(lock(), after))

    def test_gitlab_revision_link_uses_custom_host(self):
        after = lock(dep={"type": "gitlab", "host": "git.example.org", "owner": "team", "repo": "dep", "rev": "0123456789abcdef"})
        self.assertIn("[01234567](https://git.example.org/team/dep/-/tree/0123456789abcdef)", summary(lock(), after))

    def test_content_hash_shortens_digest_without_inventing_repository_link(self):
        after = lock(dep={"type": "path", "path": "/local", "narHash": "sha256-abcdefghijklmnop="})
        result = summary(lock(), after)
        self.assertIn("| dep | — | sha256-abcdefgh… | /local |", result)
        self.assertNotIn("abcdefghijklmnop", result)


if __name__ == "__main__":
    unittest.main()

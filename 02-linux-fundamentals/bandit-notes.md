# OverTheWire Bandit - Levels 0 to 10

## Goal
Practise Linux command-line navigation, file inspection, searching and text processing.

| Level | Concept learned | Relevant command/tool |
|---|---|---|
| 0 | Connect to a remote Linux server using SSH | `ssh` |
| 1 | Read a file with a special filename (`-`) | `cat`, `./` |
| 2 | Handle filenames containing spaces | `cat` |
| 3 | Find hidden files | `ls -la` |
| 4 | Identify file types | `file` |
| 5 | Search files by size and permissions | `find` |
| 6 | Search by owner, group and size | `find` |
| 7 | Search for text inside a file | `grep` |
| 8 | Find a unique line in sorted data | `sort`, `uniq -u` |
| 9 | Extract readable strings from binary data | `strings` |
| 10 | Decode Base64-encoded content | `base64 -d` |

## Key takeaways

- SSH provides remote command-line access.
- Hidden Linux filenames begin with a dot.
- Filenames can contain spaces and special characters.
- `find` supports filtering by file properties.
- `grep` searches text using patterns.
- Pipes (`|`) pass one command's output into another.
- `sort` and `uniq` help analyse repeated data.
- `strings` extracts readable text from binary files.
- Base64 is an encoding format, not encryption.

## Security note
Challenge passwords and credentials are intentionally excluded from this repository.

Using `rsync` is a more efficient way to copy files while skipping already copied ones. Here’s the recommended command:

```bash
rsync -av --progress /source/directory/ /destination/directory/
```

### Explanation:
- `-a` (archive mode): Preserves timestamps, symbolic links, and permissions.
- `-v` (verbose): Shows details of the process.
- `--progress`: Displays progress for each file.

#### If you want to delete files from the destination that no longer exist in the source:
```bash
rsync -av --delete /source/directory/ /destination/directory/
```

#### If you want to copy only newer or missing files without modifying existing ones:
```bash
rsync -au /source/directory/ /destination/directory/
```
- `-u` (update): Copies only newer files, leaving existing ones untouched.

#### `r` option vs. `a` option

`rsync` has the `-r` option, which stands for **recursive**, meaning it copies directories and their contents. However, `-a` (archive mode) is generally preferred because it includes **recursive copying** (`-r`) along with **preserving file metadata** (timestamps, symbolic links, permissions, etc.).

So, while you *could* use:
```bash
rsync -r /source/directory/ /destination/directory/
```
It's usually better to use:
```bash
rsync -a /source/directory/ /destination/directory/
```
since it does everything `-r` does, plus more.

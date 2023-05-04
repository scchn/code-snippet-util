# code-snippet-util

Download Xcode code snippets from GitHub repo.

## List

Command:

```
$ csdl list <user> <repo> [--folder <folder>] [--detail]
```

Example:

```
$ swift run csdl list scchn code-snippets --detail

💠 Fetching file list...

🤩 Found 2 files.

[1] scchn-view-controller.codesnippet
  Title:        View Controller
  Summary:      <Empty>
  Platform:     iOS
  Completion:   viewcon
  Availability: Top Level

[2] scchn-view-model.codesnippet
  Title:        View Model
  Summary:      <Empty>
  Platform:     All
  Completion:   <Empty>
  Availability: Top Level
```

## Update

Command:

```
$ csdl update <user> <repo> [--folder <folder>]
```

Example:

```
$ swift run csdl update scchn code-snippets

💠 Fetching file list...

🤩 Found 2 code snippets.

💠 Downloading scchn-view-controller.codesnippet...
  [*] /Users/user/Library/Developer/Xcode/UserData/CodeSnippets/scchn-view-controller.codesnippet

💠 Downloading scchn-view-model.codesnippet...
  [*] /Users/user/Library/Developer/Xcode/UserData/CodeSnippets/scchn-view-model.codesnippet

🎉 Finished updating code snippets!
```

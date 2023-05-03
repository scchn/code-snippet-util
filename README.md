# code-snippet-util

Download Xcode code snippets from GitHub repo.

## List

Command:

```
$ csu list <user> <repo> [<folder>] [--detail]
```

Example:

```
$ swift run csu list scchn code-snippets --detail

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
$ csu update <user> <repo> [<folder>]
```

Example:

```
$ swift run csu update scchn code-snippets         

💠 Fetching file list...

🤩 Found 2 code snippets.

💠 Downloading scchn-view-controller.codesnippet...
  [*] /Users/user/Library/Developer/Xcode/UserData/CodeSnippets/scchn-view-controller.codesnippet

💠 Downloading scchn-view-model.codesnippet...
  [*] /Users/user/Library/Developer/Xcode/UserData/CodeSnippets/scchn-view-model.codesnippet

🎉 Finished updating code snippets!
```
## QDR - Quick Directories
![GitHub last commit](https://img.shields.io/github/last-commit/getizeddev/qdr)

### Table of Contents
- [Introduction](#introduction)
- [Description](#description)
- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Limitations](#limitations)

### Introduction

**qdr** (quick directories) is a lightweight bash script that allows you to
navigate easily through the file system.
By assigning a tag (**key**) to a specific path, the tool redirects you
to the desired location in the current shell execution environment.

### Description

The script is designed to save the path of favourite directories that might
take extensive typing to relocate to, assigning a tag to it. For example,
if I am in `~/Desktop/path/to/desired/folder`, I can assign a tag to it
```
qdr -i <key>
```
and, in the future, I would be able to move to that folder just by typing
```
qdr <key>
```
without having to `cd` the whole path.

The tool saves a list of **key** -> *path* in a file (`.qdr_table`) located
in the home directory (~).

Additionally, the tool allows you to remove the saved reference from the
table or list the saved entries.

### Installation

There are two different files in the repository that can be used.
`b_qdr.sh` for bash terminals and `z_qdr.sh` for zsh.

The distinction has been made due to syntactical difference in handling
associative arrays.

The other files in the repo are just tests and documentation.

Once the file(s) has been downloaded, you **need to source the script
in your specific config file** (.bashrc | .zshrc).
The reason is that the script would need to run in the current shell
environment and not in a sub-shell.

### Usage

The help command is `qdr -h` or `qdr --help`.

### Dependencies

The script uses Associative Arrays. Bash supports them starting from
version 4.

### Limitations

- paths are not dynamic, meaning if you move a directory in another location 
the entry in the table won't be updated automatically. You'll need to 
delete the old entry and enter the new one.

- no keys autocompletion 

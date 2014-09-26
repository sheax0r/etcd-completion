# Etcd::Completion
Rubygem. Provides a CLI for performing etcd autocompletion.

## Installation
```bash
gem install etcd-completion
```

## Usage
```bash
etcd-completion <operation> <prefix>
```
Operation must an etcd operation - ie: 
* mkdir
* get
* ls
* set
* etcetera

Prefix must be part of a path or a key.

## Examples
Given this directory structure:
```
/
|--dir1
|   |--k/
|   |--key
|   |--key2
|--dir2
```

```
etcd-completion ls /d
--> /dir1/ /dir2/

etcd-completion ls /dir1
--> /dir1/key1 /dir1/key2

etcd-completion ls /dir1/k
--> /dir1/k/

etcd-completion get /dir1/k
--> /dir1/k/ /dir1/key /dir1/key2
```

## Limitations
* Currently, etcd-completion does not recurse into subdirectories to prune  
invalid directories. In the above examples, the ```get /dir1/k``` example should
prune the "dir/k" directory, because there are no keys to "get" in that 
directory, so get cannot possibly operate on a path starting with it. I plan
to address this problem in a future pull request.
* Currently, this gem is just a bin file, with no library, so it is useful 
only from the commandline and not from ruby programs. I plan to rectify this
as well.



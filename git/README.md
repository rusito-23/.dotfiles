# Git Config :twisted_rightwards_arrows:

## Install

Change the following lines in `gitconfig` with your data:

```
[user]
  name = ********************
  email = ********************@gmail.com
  username = *********
  
  excludesfile = $HOME/.git/global_gitignore
  hookspath = $HOME/.git/hooks
  
  template = $HOME/.git/global_commit_template
  
  smtpuser = *******************@gmail.com
  smtppass = ********
```

Then run the install script:
`./install.sh`

And that's it!

## Features :rocket:

- Pre-commit hook to search for TODO's and FIXME's.
- Commit template
- IntelliJ Community Edition as Default DiffTool
- SourceTree as DiffTool
- GitFlow Prefixes
- Colors for branches and diff
- Global gitignore!

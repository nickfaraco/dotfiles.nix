# Change default shell

Home-manager is able to install a new shell (e.g. Zsh in this configuration), but such shell is not available system-wide for you to use `chsh -s /usr/bin/zsh`,  for example, to set the default on WLS.

## Solution 1 (requires admin privileges)
If you have admin access and are therefore able to modify the `/etc/wsl.conf` file, add the following content to it and change your username appropriately:

```
[interop]
appendWindowsPath = true

[user]
default = your_username
shell = /home/your_username/.nix-profile/bin/zsh
```

## Solution 2

The simplest solution is to make Bash itself load your preferred shell at launch.
To do that, e.g. with Zsh, simply add this line at the end of your .bash_profile file:

```
exec zsh
```
This flake does exactly this by default. However, if you can, use the first solution for a more seamless experience.
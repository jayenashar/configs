# Hi! This is a repository where some useful configuration files are stored.

Please feel free to submit pull requests here as you think is necessary.

You can copy/merge these files to the same relative location in your home directory.

*   [.bashrc](#.bashrc) - Configuration file for bash (the bourne again shell)
*   [.nanorc](#.nanorc) - Configuration file for nano (Nano's ANOther editor, an enhanced free Pico clone)
*   [.procmailrc](#.procmailrc) - Configuration file for procmail (autonomous mail processor)
*   [.ssh/config](#.ssh/config) - Configuration file for ssh (secure shell)
*   [.profile](#.profile) - Configuration file for compatible shells' (sh, ash, ksh, bash) login
*   [.inputrc](#.inputrc) - Initialization file for readline (a library that allow users to edit command lines as they are typed in)
*   [.vimrc](#.vimrc) - Initialization file for vim (Vi IMproved, a programmers text editor)
*   [.wgetrc](#.wgetrc) - User startup file for Wget (The non-interactive network downloader)

### <a name=".bashrc">.bashrc</a> - Configuration file for bash (the bourne again shell)

*   gives a colored prompt
    *   includes the non-zero exit status of the last command
*   colorizes the output of grep and ls
*   gives you the shortcut wcc for compiling with -Wall -Werror
*   gives you the shortcut mcc for compiling with mudflap and -Wall -Werror
*   allows you to do a forward history search with Ctrl-f (you know how Ctrl-r does a backward history search, right?)
*   stores a large history (without consecutive duplicates)
*   stores history with date and time stamps
*   make less more friendly for non-text input files
*   warns you when losing data with cp, mv, or rm
*   requires two ctrl-d's to exit a shell, in case you press it accidentally

### <a name=".nanorc">.nanorc</a> - Configuration file for nano (Nano's ANOther editor, an enhanced free Pico clone)

*   autoindentation (it's stupid, though)
*   automatic backups
*   mouse support
*   tab inserts spaces
*   color syntax highlighting

### <a name=".procmailrc">.procmailrc</a> - Configuration file for procmail (autonomous mail processor)

*   logs what it filters
*   prevents most duplicates

### <a name=".ssh/config">.ssh/config</a> - Configuration file for ssh (secure shell)

*   Automatic control connections (If you already have a connection open, reuses the same connection to spawn a new shell. This is faster, and doesn't require re-authentication.)
*   Readable known hosts (If your client machine is compromised, people can find out where you connect to, but now so can you, and your tab-completing shell!)
*   Always forwards X1\. (Never type -X or -Y again!)
*   Disables strict host key checking (Tells you about new keys and possible man-in-the-middle attacks, but isn't as annoying to confirm.)
*   Doesn't check for DNS spoofing (Faster to connect)
*   Doesn't store keys for localhost (Less annoying if your home directory is shared on multiple machines and you do ssh localhost.)
*   Keeps connections alive (Doesn't disconnect you if you step away for an hour or so.)
*   Alias for cse (Just type "ssh cse" instead of the entire hostname.)

### <a name=".profile">.profile</a> - Configuration file for compatible shells' (sh, ash, ksh, bash) login

*   loads your .bashrc, if you are running bash and you have a .bashrc
*   prepends ~/.local/bin to your path, if you have ~/.local/bin
*   prepends ~/bin to your path, if you have ~/bin
*   disables beeps if you are logging into a graphical display
*   sets less (a file viewer) to allow colors, default to search case-insensitively, and display utf-8 characters
*   sets up ssh agent, for ssh forwarding (You will also want `.bash_logout` to kill the agent when you logout)

#### Special Installation Instructions

For most people, you can just save the file to .profile in your home directory.

If you have a ~/.bash\_profile or ~/.bash\_login file, then ~/.profile is not read.

To quote from the bash (1) man page:
<pre>When bash is invoked as an interactive login shell, or as a  non-inter-
active  shell with the --login option, it first reads and executes com-
mands from the file /etc/profile, if that file exists.   After  reading
that file, **it looks for ~/.bash_profile, ~/.bash_login, and ~/.profile,
in that order, and reads and executes commands from the first one  that
exists**  and  is  readable.</pre>
It is recommended that you merge the three into ~/.profile and place the bash-specific items in a block like:
<pre># if running bash
if [ -n "$BASH_VERSION" ]; then
# perform bash-specific code
fi</pre>

### <a name=".inputrc">.inputrc</a> - Initialization file for readline (a library that allow users to edit command lines as they are typed in)

*   gives case-insensitive tab completion
*   disables beeps
*   up and down to search history

### <a name=".vimrc">.vimrc</a> - Initialization file for vim (Vi IMproved, a programmers text editor)

*   tab inserts spaces
*   color syntax highlighting

### <a name=".wgetrc">.wgetrc</a> - User startup file for Wget (The non-interactive network downloader)

*   Turn off verbose without being completely quiet (use -q for that), which means that error messages and basic information still get printed.
*   no retries
*   Continue getting a partially-downloaded file.
*   Turn on time-stamping.
*   experimental (not fully-functional) support for "Content-Disposition" headers is enabled.  some file-downloading CGI programs use "Content-Disposition" headers to describe what the name of a downloaded file should be.

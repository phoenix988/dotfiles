# Variables for standard programs
variables = {
    'term': 'kitty',
    'browser': 'librewolf',
    'run': "rofi -show drun -show-icons -display-drun \"Run : \" -drun-display-format \"{name}\"",
    'mod': 'mod4',
}

# Programs
variables['sysmon'] = variables['term'] + ' -e btop'
variables['editor'] = 'emacsclient -c -a emacs'
variables['browser2'] = "brave-browser --new-window --app=https://duckduckgo.com"
variables['virtman'] = "virt-manager"
variables['backup'] = "sudo timeshift-gtk"
variables['lockscreen'] =  "slock"
variables['FILE_MANAGER'] = "emacsclient -c -a '' --eval '(dired nil)'"
variables['GUI_FILE_MANAGER'] = "pcmanfm"

# Paths
variables['dmenu_path'] = "/home/karl/.dmenu"
variables['script_path'] = "/home/karl/.scripts/activated"
variables['tmux_path'] = "/home/karl/.scripts/tmux"

# City
variables['city'] = "593116"

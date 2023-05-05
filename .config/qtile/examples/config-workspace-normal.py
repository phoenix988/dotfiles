group_names = [("WWW", {'layout': 'bsp' ,'matches':[Match(wm_class=["Brave-browser-nightly", "Chromium" , "librewolf"])]}),
               ("DEV", {'layout': 'bsp','matches':[Match(wm_class=["neo"])]}),
               ("SYS", {'layout': 'bsp', 'matches':[Match(wm_class=["TeamViewer"])]}),
               ("GAM", {'layout': 'max', 'matches':[Match(wm_class=["lutris" , "Steam" , "upc.exe" , "steam_proton" , "heroic"])]}),
               ("DOC", {'layout': 'bsp', 'matches':[Match(wm_class=["re.sonny.Tangram", "crx_cifhbcnohmdccbgoicgdjpfamggdegmo", "disk.yandex.com__client_disk"])]}),
               ("SOC", {'layout': 'max', 'matches':[Match(wm_class=["discord" , "Franz" , "whatsapp-nativefier-d40211" , "altus" , "whatsdesk" , "whatsapp-for-linux", "web.whatsapp.com"])]}),
               ("REC", {'layout': 'bsp', 'matches':[Match(wm_class=["Spotify"])]}),
               ("VID", {'layout': 'treetab', 'matches':[Match(wm_class=["nemo"  , "io.github.celluloid_player.Celluloid" , "urxvt" , "obs", "youtube.com", "netflix.com"])]}),
               ("GFX", {'layout': 'bsp', 'matches':[Match(wm_class=["gimp-2.10","Gimp" ,"Cinelerra","Olive", "kdenlive" , "resolve" ])]})]


groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # Send current window to another group
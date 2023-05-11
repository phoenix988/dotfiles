from libqtile import layout, bar, widget, hook

group_names = [(" ", {'layout': 'bsp' ,'matches':[Match(wm_class=["Brave-browser-nightly", "Chromium" , "librewolf"])]}),
               (" ", {'layout': 'bsp','matches':[Match(wm_class=["neo"])]}),
               (" ", {'layout': 'bsp', 'matches':[Match(wm_class=["TeamViewer"])]}),
               (" ", {'layout': 'max', 'matches':[Match(wm_class=["lutris" , "Steam" , "upc.exe" , "steam_proton" , "heroic"])]}),
               (" ", {'layout': 'bsp', 'matches':[Match(wm_class=["re.sonny.Tangram", "crx_cifhbcnohmdccbgoicgdjpfamggdegmo", "disk.yandex.com__client_disk"])]}),
               (" ", {'layout': 'max', 'matches':[Match(wm_class=["discord" , "Franz" , "whatsapp-nativefier-d40211" , "altus" , "whatsdesk" , "whatsapp-for-linux", "web.whatsapp.com"])]}),
               (" ", {'layout': 'bsp', 'matches':[Match(wm_class=["Spotify"])]}),
               (" ", {'layout': 'treetab', 'matches':[Match(wm_class=["io.github.celluloid_player.Celluloid" , "urxvt" , "obs", "youtube.com", "netflix.com"])]}),
               (" ", {'layout': 'bsp', 'matches':[Match(wm_class=["gimp-2.10","Gimp" ,"Cinelerra","Olive", "kdenlive" , "resolve" ])]})]

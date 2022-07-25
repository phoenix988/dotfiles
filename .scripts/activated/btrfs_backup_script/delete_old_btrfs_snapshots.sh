#!/usr/bin/fish


###Gets information from the fstab
set btrfspath  (cat /etc/fstab | egrep '(noauto)' | awk '$3 == "btrfs" { print $2}' | grep -v .topbtrfs ) 

###this will grep for all the subvolume names
for bp in $btrfspath 

	set btrfsvolumes (btrfs subvolume list $bp | awk '{print $9}' | grep -v .snapshot)


###This will counts all the snapshots located for the subvolume
for bv in $btrfsvolumes 
  


	set snapshots (btrfs subvolume list $bp/$bv | awk '{print $9}' | grep  .snapshots/$bv | wc -l )
        


#####This while loop will only run if there is a certain amount of snapshots for the subvolume
		while [ $snapshots -gt "5" ] 
	
        	
####Gets the snapshot to delete	
	 set	rmsnap (btrfs subvolume list $bp/$bv | awk '{print $9}' | grep  .snapshots/$bv | head -n1)


      rm -rf $btrfspath/$rmsnap 

      echo "Removing Snapshot $bp/$rmsnap"
	
###set snapshots (btrfs subvolume list $bp/$bv | awk '{print $9}' | grep  .snapshots/$bv | wc -l)


      set snapshots (math $snapshots - 1)


end   
	
end

end

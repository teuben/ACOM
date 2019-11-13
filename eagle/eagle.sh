#! /bin/bash

#
    wget --user=??? --ask-password --content-disposition
      "http://dataweb.cosma.dur.ac.uk:8080/eagle-snapshots//download?run=RefL0012N0188&snapnum=28"
    wget --user=??? --ask-password --content-disposition
      "http://dataweb.cosma.dur.ac.uk:8080/eagle-snapshots//download?run=RefL0012N0188&snapnum=0"
    tar xvf RefL0012N0188_snap_028.tar 
    tar xvf RefL0012N0188_snap_000.tar
#
#   or do something like:     ln -s ~/EAGLE/RefL0012N0188
#       
    h5dump RefL0012N0188/snapshot_028_z000p000/snap_028_z000p000.0.hdf5 | head 
#  
    eaglesnap RefL0012N0188/snapshot_028_z000p000/snap_028_z000p000.0.hdf5 snap1  ptype=0 region=2
    tsf snap1 

#    
    eaglesnap RefL0012N0188/snapshot_028_z000p000/snap_028_z000p000.0.hdf5 - 0 group=2 |\
    snapplot3 - xrange=-10:10 yrange=-10:10 zrange=-10:10 yapp=eagle_1.png/png

#
    eaglesnap RefL0012N0188/snapshot_028_z000p000/snap_028_z000p000.0.hdf5 - 0 group=4 |\
    snapplot3 - xrange=-10:10 yrange=-10:10 zrange=-10:10 yapp=eagle_2.png/png 
   
#   
    eaglesnap RefL0012N0188/snapshot_028_z000p000/snap_028_z000p000.0.hdf5 - 0 group=4 center=1.9,6.6,1.2 boxsize=8.47125 |\
    hackforce - - |\
    snapcenter - - '-phi*phi*phi' |\
    snaprect - snap4cr '-phi*phi*phi'

    s=0.05
    snapplot3 snap4cr xrange=-$s:$s yrange=-$s:$s zrange=-$s:$s  yapp=eagle_3.png/png
      
    s=0.1
    snapgrid snap4cr ccd0s xrange=-$s:$s yrange=-$s:$s nx=128 ny=128 mom=0  svar=0.001
    snapgrid snap4cr ccd1s xrange=-$s:$s yrange=-$s:$s nx=128 ny=128 mom=-1 svar=0.001
    ccdplot ccd0s power=0.5 yapp=eagle_5.png/png 
    ccdplot ccd1s 

#    
    b=8.47125      # box size
    dm=4365.77     # cheat to get the correct DM amount
    snap0=RefL0012N0188/snapshot_028_z000p000/snap_028_z000p000.0.hdf5     # at z=0
    snap20=RefL0012N0188/snapshot_000_z020p000/snap_000_z020p000.0.hdf5    # at z=20

#    
    eaglesnap $snap0  - 0 |\
    snapgridsmooth - -  xrange=0:$b yrange=0:$b zrange=0:$b nx=128 ny=128 nz=128 periodic=t |\
    ccdsmooth - gas0s 0.1 dir=xyz
  
    eaglesnap $snap0 - 1 dm=$dm |\
    snapgridsmooth - -  xrange=0:$b yrange=0:$b zrange=0:$b nx=128 ny=128 nz=128 periodic=t |\
    ccdsmooth - dm0s 0.1 dir=xyz

    eaglesnap $snap20 - 0 |\
    snapgridsmooth - -  xrange=0:$b yrange=0:$b zrange=0:$b nx=128 ny=128 nz=128 periodic=t |\
    ccdsmooth - gas20s 0.1 dir=xyz

    eaglesnap $snap20 - 1 dm=$dm |\
    snapgridsmooth - -  xrange=0:$b yrange=0:$b zrange=0:$b nx=128 ny=128 nz=128 periodic=t |\
    ccdsmooth - dm20s 0.1 dir=xyz

# compute masses
    ccdstat gas0s
    ccdstat dm0s
    ccdstat gas20s
    ccdstat dm20s

# compute local Baryonic Fraction  
    ccdmath gas20s,dm20s bf20 %1/%2
    ccdmath gas0s,dm0s   bf0  %1/%2
    
    ccdstat bf20
    ccdstat bf0


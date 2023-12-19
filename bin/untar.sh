# untar EVS plots tar files for global_det and subseasonal

#tardir=/lfs/h2/emc/ptmp/emc.vpppg/evs/v1.0/plots/subseasonal/atmos.20231214
#tardir=/lfs/h2/emc/ptmp/emc.vpppg/evs/v1.0/plots/global_det/atmos.20231214
#tardir=/lfs/h2/emc/ptmp/emc.vpppg/evs/v1.0/plots/global_det/wave.20231214
tardir=/lfs/h2/emc/ptmp/emc.vpppg/evs/v1.0/plots/global_det/headline.20231214
#untardir=/lfs/h2/emc/stmp/shelley.melchior/untar-subseasonal
untardir=/lfs/h2/emc/stmp/shelley.melchior/untar-globaldet-headline

mkdir -p $untardir
cd $untardir

for tar1 in $tardir/evs.plots*.tar
do
# echo "tar -xvf $tar1"
  tar -xvf $tar1
done

exit

for tar2 in $untardir/grid2grid*.tar 
do
# echo "tar -xvf $tar2"
  tar -xvf $tar2
done

for tar2 in $untardir/grid2obs*.tar 
do
# echo "tar -xvf $tar2"
  tar -xvf $tar2
done

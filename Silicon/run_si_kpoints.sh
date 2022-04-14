#!/bin/sh
# reminder: from now on, what follows the character # is a comment
####################################################################
#
# define the following variables according to your needs
#
outdir=out/
pseudo_dir=../pseudo
# the following is not actually used:
# espresso_dir=top_directory_of_espresso_package
####################################################################

rm -f si.scf.out out/si.etot_vs_kpt
touch out/si.etot_vs_kpt

k2=(2,2,2)
k4=(4,4,4)
k6=(6,6,6)
for k_points in ${k[@]} ; do

# self-consistent calculation
cat > si.eos.in << EOF
 &control
    prefix='silicon',
    pseudo_dir = '../pseudo',
    outdir='out/'
 /
 &system    
    ibrav=  2, celldm(1) =10.2, nat=  2, ntyp= 1,
    ecutwfc = 12.0, 
 /
 &electrons
 /
ATOMIC_SPECIES
 Si  28.086  Si.pz-vbc.UPF
ATOMIC_POSITIONS
 Si 0.00 0.00 0.00 
 Si 0.25 0.25 0.25 
K_POINTS automatic
   $k_points 1 1 1
EOF

# If pw.x is not found, specify the correct value for $espresso_dir,
# use $espresso_dir/bin/pw.x instead of pw.x

pw.x -in si.scf.in > si.scf.out

grep -e 'lattice parameter' -e ! si.scf.out | \
      awk '/lattice/{alat=$(NF-1)}/!/{print alat, $(NF-1)}' >> out/si.etot_vs_kpt

done

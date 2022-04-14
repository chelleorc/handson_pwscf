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

rm -f si.etot_vs_ecut.out
touch si.etot_vs_ecut

for ecutwfc in 6.0 8.0 10.0 12.0 14.0 16.0 18.0 20.0 22.0 24.0 28.0 32.0 36.0 40.0; do

# self-consistent calculation
cat > si.scf.in << EOF
 &control
    prefix='silicon',
    pseudo_dir = '../pseudo',
    outdir='out/'
 /
 &system    
    ibrav=  2, celldm(1) =10.2, nat=  2, ntyp= 1,
    ecutwfc = $ecutwfc, 
 /
 &electrons
 /
ATOMIC_SPECIES
 Si  28.086  Si.pz-vbc.UPF
ATOMIC_POSITIONS
 Si 0.00 0.00 0.00 
 Si 0.25 0.25 0.25 
K_POINTS automatic
   4 4 4 1 1 1
EOF

# If pw.x is not found, specify the correct value for $espresso_dir,
# use $espresso_dir/bin/pw.x instead of pw.x

pw.x -in si.scf.in > si.scf.out

# grep -e 'kinetic-energy cutoff' -e ! si.scf.out | \
      # awk '/kinetic-energy/{ecutwfc=$(NF-1)}/!/{print ecutwfc, $(NF-1)}' >> out/si.etot_vs_ecut_data

# set each grep to variable
cutoff="$(grep -e 'kinetic-energy cutoff' si.scf.out | awk '{print $(NF-1)}')"
total_energy="$(grep ! si.scf.out | awk '{print $(NF-1)}')"
wall_time="$(grep 'PWSCF.*WALL' si.scf.out | awk '{printf $(NF-1)}' | head -c -1)" 

# print to file
echo $cutoff $total_energy >> out/si.etot_vs_ecut
echo $cutoff $total_energy $wall_time >> out/si.etot_vs_ecut_vs_time
 
done

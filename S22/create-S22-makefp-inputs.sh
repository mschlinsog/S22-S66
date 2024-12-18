#!/bin/bash

cd separate_molecules
for basis in 631g 631++g 631++gdp 6311++g3df2p; do

  for file in *.xyz; do

    filename=$(echo "$file" | cut -f 1 -d '.')
    cp makefp_template.inp makefp_${filename}_${basis}.inp
    cat ${file} >> makefp_${filename}_${basis}.inp
    echo ' $END' >> makefp_${filename}_${basis}.inp
    echo "done for $file with $basis"

  done
  mv *${basis}.inp ../makefp_calcs/${basis}

done

cd ../
cd makefp_calcs/631g
  for file in *.inp; do
    sed -i 's/\$BASIS/\$BASIS GBASIS=N31 NGAUSS=6 \$END/g' ${file}
  done
cd ../../
cd makefp_calcs/631++g
  for file in *.inp; do
    sed -i 's/\$BASIS/\$BASIS GBASIS=N31 NGAUSS=6 DIFFSP=.T. DIFFS=.T. \$END/g' ${file}
  done 
cd ../../
cd makefp_calcs/631++gdp
  for file in *.inp; do
    sed -i 's/\$BASIS/\$BASIS GBASIS=N31 NGAUSS=6 DIFFSP=.T. DIFFS=.T. NDFUNC=1 NPFUNC=1 \$END/g' ${file}
  done
cd ../../
cd makefp_calcs/6311++g3df2p
  for file in *.inp; do
    sed -i 's/\$BASIS/\$BASIS GBASIS=N311 NGAUSS=6 DIFFSP=.T. DIFFS=.T.\$'\n'  NDFUNC=3 NPFUNC=2 NFFUNC=1 \$END/g' ${file}
  done
cd ../../

#!/usr/bin/env bash
echo "Downloading additional resources"
git lfs pull
gunzup ./resources/repmask/alu_l1_herv_sva_other_grch38_ucsc_repeatmasker.txt.gz
gunzup ./resources/repmask/alu_l1_herv_sva_other_grch38_ucsc_accession_repeatmasker.txt.gz

echo "Starting mobster build..."

mvn clean

cd ./lib/jar

mvn install:install-file -Dfile=java-yield-1.0-SLIMJAR.jar -DgroupId=java-yield -DartifactId=java-yield -Dversion=1.0-SLIMJAR -Dpackaging=jar
mvn install:install-file -Dfile=picard-1.113.jar -DgroupId=net.sf.picard -DartifactId=picard -Dversion=1.113 -Dpackaging=jar
mvn install:install-file -Dfile=samtools-1.113.jar -DgroupId=net.sf.samtools -DartifactId=samtools -Dversion=1.113 -Dpackaging=jar

cd ../..

mvn compile -U
mvn package

cp ./lib/Mobster.properties ./target

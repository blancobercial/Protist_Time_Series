##From a file with columns ASV id, fasta, abundances per sample (each sample a column) named phylogenetic.txt
##you would need to install MEGAX in your computer, and megacc in your server
##script tested in RHEL 7 (maipo)

##sepparate the file, creating one for each sample, each containing the ASVid, the fasta and the abundances for the sample (3 columns)
awk 'BEGIN{FS=OFS="\t"}{for(i=3;i<=NF;i++){name=i".file";print $1, $2, $i> name}}' phylogenetic.txt

#for each file, extract the sequences from those ASV with abundances >0, and convert them into a fasta file.
for f in *.file; do
awk '$3>0 {print $2 >> "short"FILENAME}' $f
awk '{print ">seq " ++count ORS $0 >> FILENAME".fasta"}'  short$f
done

#for each fasta, use megacc to get the average distance for each sample; you would need to create the mao file in your computer first using MEGAX, and upload it to the server

for f in *.fasta; do
megacc -a  -f Fasta -d $f -o $f.avedist.txt
done

#contatenate the output files, including the name of the file in the first column, and the average distance in the second column. This will allow to trace back station to files
awk 'BEGIN{FS=OFS="\t"} FNR == 3{print FILENAME"\t"$0}' *avedist >  all_averages.txt

fetch_genbank <- function(k="nucleotide",
                          gene="COI[GENE] OR CO1[GENE]",
                          taxa="Annelida[ORG]",
                          dir=""){
  query <- paste(gene, "AND", taxa, sep = " ")
  
  taxa_ids <- entrez_search (db=k, 
                             term=query, 
                             retmax=9999999, 
                             use_history=TRUE)
  
  
  
  sequences <- entrez_fetch(db="nucleotide", 
                           web_history=taxa_ids[["web_history"]], 
                           rettype="fasta")
  
  output <- paste(taxa,"sequences.fasta",sep="")
    
  return(write(sequences,file=paste(dir,output,sep="")))  
}





















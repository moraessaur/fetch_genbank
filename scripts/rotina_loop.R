# loop de novo, o primeiro save tem que ser com coluna, o segundo nao

# a extensao do loop vai ser os blocos, nao as especies

df_master <- read_delim(file="data/df_master.txt",delim="\t")

especies <- word(df_master$scientific_name[1:10],start=1,end=2)

chunks <- split(especies, ceiling(seq_along(especies)/3))

for (i in 1:length(chunks)){
  print(i)
  temp_df <- do.call("rbind",
                     map(chunks[[i]],summary_gbif_sp))
  if (i == 1){
    write.table(temp_df,file="tabela_gbif_neo.txt",
                row.names = FALSE,quote=FALSE,sep="\t")
  } else {
    write.table(temp_df,file="tabela_gbif_neo.txt",
                row.names = FALSE,quote=FALSE,sep="\t",
                append=TRUE,col.names = FALSE)
  }
  write(i,file="chunk_log.txt",append=TRUE)
}







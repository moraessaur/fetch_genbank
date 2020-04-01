# Function fetch_genbank()

Funcao escrita para meu amigo profeta. Escrevi com bastante pressa, talkey? 🏇

Essa eh a funcao:

```r
library(rentrez)
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
```

Tem quatro argumentos:

* `k`: Eh basicamente a base de dados que vc quer buscar, escrevi pensando em <i>"nucleotide"</i> como default.
* `gene`: meio auto explicativo.
* `taxa`: taxa a ser buscado, tem que ser no formato taxa[ORG] (ou outra coisa desde que seja taxa[alguma coisa], com os colchetes colados.)
* `dir`: diretorio onde o resultado vai ser salvo.

O resultado final da funcao ja sao as sequencias salvas como <i>.fasta</i>, onde o nome do arquivo eh o nome do taxa, no diretorio definido por `dir`.

Quando usei apenas Annelida e Cnidaria funcionou.

Veja se o comando abaixo funciona no seu R, depois de, naturalmente, ja ter chamado a funcao:

```
# se nao tiver esse pacote instalado, instalado
library(tidyverse)

# agora vou criar o vetor que preciso dos taxa, formatado, com base no que voce me mandou no email:

taxa <- c("Cnidaria","Ctenophora",
          "Placozoa","Porifera",
          "Acoelomorpha","Xenoturbellida",
          "Nematoda","Nematomorpha",
          "Arthropoda","Onychophora",
          "Tardigrada","Kinorhyncha",
          "Loricifera","Priapulida",
          "Chaetognatha","Gnathostomulida",
          "Micrognathozoa","Rotifera","Acanthocephala",
          "Annelida","Sipuncula","Brachiopoda",
          "Bryozoa","Cycliophora","Entoprocta","Gastrotricha",
          "Mesozoa","Mollusca","Nemertea","Phoronida",
          "Platyhelminthes","Chordata",
          "Echinodermata","Hemichordata") %>% paste("[ORG]",sep="") #incluir o termo org nos taxa

# rodando o comando abaixo, deveria funcionar. Eu uso map do pacote "purrr" que ja ta dentro do tidyverse, soh porque estou acostumado:

map(taxa,fetch_genbank,k="nucleotide",gene="COI[ALL] OR CO1 [ALL] OR COXI [ALL] OR COX1 [ALL]", dir="suapasta")
```

Lembrando que voce tem que colocar o caminho para a paste que vc quer que salve as coisas no argumento `dir` e como eh muita info, deve demorar um pouco para executar!

Eu usei a funcao com o comando abaixo, mais enxuto por causa da minha internet 💩 e funcionou:

```
taxa <- c("Anellida[ORG]","Cnidaria[ORG]")
map(taxa,fetch_genbank,k="nucleotide",gene="COI[GENE] OR CO1[GENE]",dir="data/")
```

Qualquer coisa avise!

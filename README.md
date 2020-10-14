# Function fetch_genbank()

Funcao escrita para meu amigo profeta. Escrevi com bastante pressa, beleza?

Essa é a função:

```python
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

* `k`: É basicamente a base de dados que vc quer buscar, escrevi pensando em <i>"nucleotide"</i> como default.
* `gene`: meio auto explicativo.
* `taxa`: taxa a ser buscado, tem que ser no formato taxa[ORG] (ou outra coisa desde que seja taxa[alguma coisa], com os colchetes colados.)
* `dir`: diretério onde o output vai ser salvo.

O resultado final da função já são as sequências salvas como <i>.fasta</i>, onde o nome do arquivo é o nome do taxa, no diretério definido por `dir`.

Quando usei apenas Annelida e Cnidaria funcionou.

Veja se o comando abaixo funciona no seu R depois de ja ter chamado a funcao:

```python
# se nao tiver esse pacote instalado, instala
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

# rodando o comando abaixo, deveria funcionar. Eu uso map do pacote "purrr" que ja ta dentro do tidyverse, só porque estou acostumado:

map(taxa,fetch_genbank,k="nucleotide",gene="COI[ALL] OR CO1 [ALL] OR COXI [ALL] OR COX1 [ALL]", dir="suapasta")
```

Lembrando que você tem que colocar o caminho para a pasta onde você quer que salve o output no argumento `dir` e como é muita info, deve demorar um pouco para executar!

Eu usei a função com o comando abaixo, mais enxuto por causa da minha internet a manivela e funcionou:

```python
taxa <- c("Anellida[ORG]","Ctenophora[ORG]")
map(taxa,fetch_genbank,k="nucleotide",gene="COI[ALL] OR CO1 [ALL] OR COXI [ALL] OR COX1 [ALL]",dir="data/")
```

Qualquer coisa avise!

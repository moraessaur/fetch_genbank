## funcao gbif_summary
library(tidyverse)
library(rgbif)

summary_gbif_sp <- function(x){
  y <- NULL
  while( is.null(y)) {
    try(
      y <- occ_search(scientificName = x,limit = 10^4))
  }
  
  if (is.null(y[['data']])){ # adicionar classe erro?
    return( 
    tibble(
      species=x,
      n_records=NA,
      last_recorded_year=NA,
      phylum=NA,
      order=NA,
      family=NA,
      states=NA,
      #locality=NA,
      basisofrecord=NA,
      status="null_df"
    )
    )
  } else if (is.null(y[['data']][['country']])) {
    return( 
      tibble(
        species=x,
        n_records=NA,
        last_recorded_year=NA,
        phylum=NA,
        order=NA,
        family=NA,
        states=NA,
        #locality=NA,
        basisofrecord=NA,
        status="no_country"
      )
    )
  } else {
    k <- y[['data']]
    k <- k %>% filter(country=='Brazil')
    return(
      tibble(
        species=x,
        n_records=y[["meta"]][["count"]],
        last_recorded_year=max(k[["year"]],na.rm=T),
        phylum=paste(unique(k$phylum),collapse=";"),
        order=paste(unique(k$order),collapse=";"),
        family=paste(unique(k$family),collapse=";"),
        states=paste(unique(k$stateProvince),collapse=";"),
        #locality=paste(unique(k$locality),collapse=";"),
        basisofrecord=paste(unique(k$basisOfRecord),collapse=";"),
        status="ok"
      )
    )
  }
  }



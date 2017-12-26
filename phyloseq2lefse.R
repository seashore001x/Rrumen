# phyloseq_to_lefse
require(dplyr)
require(tibble)
# this script convert phyloseq object into lefse recognized file format
phyloseq_to_lefs <- function(physeq){
  # aggregate to genus level
  ps_lefse <- physeq %>% tax_glom(taxrank = 'Genus', NArm = F)
  
  # extract taxonomic data from phyloseq object and then stored in a vector called lefse_tax
  lefse_tax <- ps_lefse %>% tax_table %>% data.frame(stringsAsFactors=FALSE)
  lefse_tax <- replace(lefse_tax, is.na(lefse_tax), 'Unclassified')
  lefse_tax <- lefse_tax %>% group_by(Kingdom, Phylum, Class, Order, Family, Genus) %>% mutate(id = paste(Kingdom, Phylum, Class, Order, Family, Genus, sep = "|")) %>% ungroup %>% pull(id)
  
  # extract otu abundance matrix from phyloeq object and annotated with tax information
  lefse_matrix <- otu_table(ps_lefse) %>% data.frame(stringsAsFactors = F) %>% t %>% data.frame
  colnames(lefse_matrix) <- lefse_tax 
  
  # extract sample matadata and order sample same in lefse_matrix
  lefse_sample <- sample_data(ps_lefse)
  
  # convert factor in lefse_sample into character in order to combine sample and abundance data
  lefse_sample_isfactor <- sapply(lefse_sample, is.factor)
  lefse_sample[,lefse_sample_isfactor] <- lefse_sample[,lefse_sample_isfactor] %>% lapply(as.character)
  lefse_sample <- lefse_sample %>% data.frame
  
  lefse_table <- full_join(rownames_to_column(lefse_sample), rownames_to_column(lefse_matrix), by = ("rowname" = "rowname")) %>% t
  
  return(lefse_table)
}

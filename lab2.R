# Load libraries and import data --------------------------------------------

# Download library

library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)

# Change directory to the location of the file
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Read data 

data <- read_csv("./sdrf_openms_design_msstats_in.csv")

# View the first rows of the data
head(data, 20)


# Data processing ----------------------------------------------------------
## Q1.1 Show the number of unique peptides in each protein. Which protein has the most peptides? How many? Waht is the molecular weight and the lenght of the sequence? 

data %>%
    select(ProteinName, PeptideSequence) %>%
    distinct() %>%
    count(ProteinName) %>% 
    arrange(desc(n))

most_protein <- data %>%
    select(ProteinName, PeptideSequence) %>%
    distinct() %>%
    count(ProteinName) %>% 
    arrange(desc(n)) %>% 
    head(1) %>% pull(ProteinName)

## Q1.2 Select the protein from Q1.2 and show the peptide intensities of each sample. 
data %>% 
    filter(ProteinName == most_protein) %>%
    ggplot(aes(x = reorder(PeptideSequence, Intensity, mean), y = Intensity, color = Reference)) +
    geom_point() + geom_line(aes(group = Reference)) +
    theme_minimal()

## Q1.3 Show the least detected peptide/protein in the data.
data %>%
    select(ProteinName, PeptideSequence) %>%
    distinct() %>%
    count(ProteinName) %>% 
    arrange(n) 
## Why do we need modification of the peptides? 

## Is there any protein that is not detected in any sample?

## Q1.4 Show the distribution of the peptide intensities in the samples.
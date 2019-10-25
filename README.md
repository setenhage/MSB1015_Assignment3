## MSB1015_Assignment3
Welcome to the repository of MSB1015 Assignment 3! Here I keep track of my progress of MSB1015 2019 Assignment 3 at Maastricht University.

## Project description 
The aim of this project is to show that parallel computing improves the calculation time of logP values compared to sequential computing. Here, we use nextflow to control the number of central processing units (CPUs) used during the calculation. 

## Pseudocode 
1. Use getSMILES file provided by Egon Willighagen to obtain all compounds and their corresponding canonical and isomeric SMILES. <br/> 
2. Create nextflow code that uses the query results and calculates logP values for each compound. <br/>
3. Adapt the nextflow code, such that it can be run using different number of CPUs and record the calculation times. <br/>
4. Visualize the results using an Rmarkdown file. <br/>

## Files
`CPU_time_logP.nf` <- contains the code to calculate the logP values for all compounds. This code also times the duration of this calculation and stores the results in a file. </br>
`CPU_duration.tsv` <- tab-delimited text file that stores the number of CPUs with the corresponding calculation time. </br>
`getSMILES` <- contains the query used to obtain the compounds. </br>
`all_canonical_isomeric_smiles.tsv` <- Results from query (downloaded from query.wikiddata.org, using getSMILES) </br>
`short.tsv` <- file with only 5 smiles to test code before running it on 158800 smiles.
`Example_files` <- folder with example files provided by Egon Willighagen. 

## Requirements 
Following software was used on Windows 10: </br>
•	[Rstudio](https://rstudio.com/) </br> 
Following software was used with the virual Linux environment [Debian](https://www.debian.org/index.en.html) on Windows 10: </br> 
•	[Nextflow](https://www.nextflow.io/) </br>
•	[Groovy](https://groovy-lang.org/) </br> 
•	[Java](https://java.com/nl/download/)

## Authors
Suzanne ten Hage
Egon Willighagen (getSMILES.rq)

## References:
•	[Chemistry Development Kit](https://cdk.github.io//) 
•	[Wikidata](https://query.wikidata.org) 

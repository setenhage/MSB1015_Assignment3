## MSB1015_Assignment3
Welcome to the repository of MSB1015 Assignment 3! Here I keep track of my progress of MSB1015 2019 Assignment 3 at Maastricht University.

## Project description 
The aim of this project is to show that parallel computing improves the calculation time of logP values compared to sequential computing. Here, we use nextflow to control the number of central processing units (CPUs) used during the calculation. A more elaborate description of this project and the results can be found [here](https://setenhage.github.io/MSB1015_Assignment3/). 

## Pseudocode 
1. Use getSMILES file provided by Egon Willighagen to obtain all compounds and their corresponding canonical and isomeric SMILES. <br/> 
2. Create nextflow code that uses the query results and calculates logP values for each compound. <br/>
3. Adapt the nextflow code, such that it can be run using different number of CPUs and record the calculation times. <br/>
4. Visualize the results using an Rmarkdown file. <br/>

## Files
`CPU_time_logP.nf` <- contains the code to calculate the logP values for all compounds. This code also times the duration of this calculation and stores the results in a file. </br>
`CPU_duration.tsv` <- tab-delimited text file that stores the number of CPUs with the corresponding calculation time. </br>
`getSMILES` <- contains the query used to obtain the compounds. </br>
`all_canonical_isomeric_smiles.tsv` <- Results from query (downloaded from query.wikiddata.org, using getSMILES). </br>
`short.tsv` <- file with only 5 smiles to test code before running it on 158800 smiles. </br>
`Example_files` <- folder with example files provided by Egon Willighagen. </br>
`Index.rmd` <- Rmarkdown file that contains the code to create index.html. </br>
`Index.html` <- [github page](https://setenhage.github.io/MSB1015_Assignment3/), containing introduction, methods, results and discussion of the project. 

## Requirements 
Following software was used on Windows 10: </br>
•	[Rstudio](https://rstudio.com/) </br> 
Following software was used with the virual Linux environment [Debian](https://www.debian.org/index.en.html) on Windows 10: </br> 
•	[Nextflow](https://www.nextflow.io/) </br>
•	[Groovy](https://groovy-lang.org/) </br> 
•	[Java](https://java.com/nl/download/)

## How to do this experiment yourself
1. Dowload all files and remove the CPU_duration.tsv file. If you don't remove it, your own calculation times will get added to the ones that are already stored. Make sure all other files are saved in the same folder. <br/>
2. Open the CPU_time_logP file in Linux environment and adapt this to match the number of CPUs your computer has (it is indicated in the file where to do this) <br/>
3. Run the CPU_time_logP.nf file in nextflow. <br/>
4. Run the index.rmd file in Rstudio. <br/>

## Authors
Suzanne ten Hage </br>
Egon Willighagen (getSMILES.rq)

## References:
•	[Chemistry Development Kit](https://cdk.github.io//) </br>
•	[Wikidata](https://query.wikidata.org) 

## Licenses 
Software created by others is used in this repository. Please respect the licenses of these other creators. Information on the licenses of these external resources can be found [here](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html).

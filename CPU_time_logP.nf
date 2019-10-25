#!/usr/bin/env nextflow

// Grab and import necessary libraries.
@Grab(group='io.github.egonw.bacting', module='managers-cdk', version='0.0.9')
@Grab(group='org.openscience.cdk', module='cdk-qsarmolecular', version='2.3')

import net.bioclipse.managers.CDKManager
import org.openscience.cdk.interfaces.IAtomContainer
import org.openscience.cdk.qsar.descriptors.molecular.*
import groovy.time.*
import java.io.File

//Create a file to store the time measurement per number of CPUs in. 
def CPUduration = new File ("./CPU_duration.tsv")

//Loop over the number of CPUs the calculation can use. To adjust this to your
//device, please change the "8" to the number of CPUs you want your computer to use.
1.upto(8) {
   //Store the starting time 
   def timeStart = new Date()
  
   //The buffer splits the data into segments, which will be processed in parallel.
   //The data should be split into one segment per CPU that we want to use.
   //Therefore the buffer size is defined as number of SMILES/number of CPUs. 
   int bufferSize = (int) Math.ceil(5/it) 
  
   Channel
       .fromPath("./all_canonical_isomeric_smiles.tsv")
       .splitCsv(header: ['wikidata', 'smiles'], sep:'\t')
       .map{ row -> tuple(row.wikidata, row.smiles) } 
       .buffer(size:bufferSize,remainder:true)
       .set { molecules_ch }

   process calculateLogP {
       input:
       each set from molecules_ch

       exec:
       for (entry in set) {
	       //Each set contains three entries: first, the wikidata identifier, 
	       //second the canonical SMILES and third, the isomeric SMILES.  
	       wikidata = entry[0] 
               canonSmiles = entry[1]
	       isoSmiles = entry[2]
	    
	       // Store the CDKManager class in cdk.
               cdk = new CDKManager(".")
	       logPDescr = new JPlogPDescriptor()
	    
               if(isoSmiles != nulll){ 
	          try {
                     //Use CDKManager to parse SMILES. This will retrun a CDK 
		     //molecule object. It is preferred to use isomeric SMILES, because
		     //these SMILES take into account the fact thatere can be isomeric
		     //differences between two compounds with the same canonical SMILES. 
	             mol = cdk.fromSMILES(isoSmiles)
	    
	             // Convert the CDK molecule object to IAtom container.
	             IAtom = mol.getAtomContainer()  

                     // Calculate logP value using JPlogPDescriptor 
                     LogPValue = JPlogPDescr.calculate(IAtom).value.doubleValue()
 
	          } catch (Exception exc) {
	             // Print the smiles which did not result in a calculated logP value. 
	             println "Error in calculating logP for this isomeric SMILES:" + isoSmiles
	          }
	       //If isomeric SMILES are not available, use the canonical SMILES. 
	       }else{
		  try{
		     //Parse the SMILES to get a CDK molecule object. 
		     mol = cdk.fromSMILES(canonSMILES)
		     
		     //Convert the CDK molecule object to IAtom container. 
		     IAtom = mol.getAtomContainer()
		     
		     //Calculate logP value using JPlogPDescriptor
		     LogPValue = logPDescr.calculate(IAtom).value.doubleValue()
		  }catch (Exception exc) {
		     println "Error in calculating logP for this canonical SMILES:" + canonSmiles
        	  }
   	       } 
   }
   //Record end time (when process is finished calculating LogP values).
   def timeStop = new Date()
   
   //Calculate time duration (timeStop - timeStart).
   TimeDuration duration = TimeCategory.minus(timeStop, timeStart)
   
   //Store time duration in tab-delimited text file. 
   CPUduration.append(" ${it} \t ${duration} \n")
   
   // Print time duration. 
   println "When using ${it} CPUs, the calculation takes" + duration
}

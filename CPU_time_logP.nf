#!/usr/bin/env nextflow

@Grab(group='io.github.egonw.bacting', module='managers-cdk', version='0.0.9')
@Grab(group='org.openscience.cdk', module='cdk-qsarmolecular', version='2.3')

import net.bioclipse.managers.CDKManager
import org.openscience.cdk.interfaces.IAtomContainer
import org.openscience.cdk.qsar.descriptors.molecular.*

Channel
    .fromPath("./short.tsv")
    .splitCsv(header: ['wikidata', 'smiles'], sep:'\t')
    .map{ row -> tuple(row.wikidata, row.smiles) }
    .buffer(size:2, remainder:true)
    .set { molecules_ch } 

process calculateLogP {
    input:
    each set from molecules_ch

    exec:
	for (entry in set) {
	    //Each set contains two entries: first, the wikidata identifier, second the smiles. 
	    wikidata = entry[0] 
            smiles = entry[1]
	    
	    // Store the CDKManager class in cdk.
            cdk = new CDKManager(".")
	    
            try {
              // Use CDKManager to pare SMILES. This will retrun a CDK molecule object. 
	      mol = cdk.fromSMILES(smiles)
	    
	      // Convert the CDK molecule object to IAtom container.
	      IAtom = mol.getAtomContainer()  

              // Calculate logP value 
	      JPlogPDescr = new JPlogPDescriptor()
	      LogPValue = JPlogPDescr.calculate(IAtom).value.doubleValue()

	      // Print logP value. 
	      println "logP value:"  + LogPValue
	   
	    } catch (Exception exc) {
	      // Print the smiles which did not result in a calculated logP value. 
	      println "Error in calculating logP for this SMILE:" + smiles
	    }
        }
}

//Afterwards print into file or something, so you can run a second process to
//calculate min/max/mean. 

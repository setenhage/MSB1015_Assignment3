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
    .buffer (size:2, remainder:true)
    .set { molecules_ch }
 
process calculateLogP {
    input:
    each set from molecules_ch

    exec:
	for (entry in set) {
	    wikidata = entry[0] 
            smiles = entry[1]
	    
	    // Use CDKManager to parse SMILES. This will return a CDK molecule object  
            cdk = new CDKManager(".")
	    mol = cdk.fromSMILES(smiles)
	    
	    // Convert the CDK molecule object to IAtom container.
	    IAtom = mol.getAtomContainer()  

            // Calculate logP value 
	    JPlogPDescr = new JPlogPDescriptor()
	    LogPValue = JPlogPDescr.calculate(IAtom).value.doubleValue()

	    // Print logP value. 
	    println "logP value:"  + LogPValue
	}

}

//Afterwards print into file or something, so you can run a second process to
//calculate min/max/mean. 

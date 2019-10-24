#!/usr/bin/env nextflow

//Grab and import the CDKManager module, so it can be used to parse the smiles into a CDK molecule object.  
@Grab(group='io.github.egonw.bacting', module='managers-cdk', version='0.0.9')
import net.bioclipse.managers.CDKManager

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
            println "${wikidata} has SMILES: ${smiles}"
	    
	    // Use CDKManager to parse SMILES and crate a CDK molecule object (mol).
	    // This will return a CDK moleculair container  
            cdk = new CDKManager(".")
	    mol = cdk.fromSMILES(smiles)
	    
	    // Convert the CDK moleculair container to IAtom container.
	    IAtom = mol.getAtomContainer()

            // create new JPLogDescriptor
	    

            // calculate PLog value 
	    
	}

}

//Afterwards print into file or something, so you can run a second process to
//calculate min/max/mean. 

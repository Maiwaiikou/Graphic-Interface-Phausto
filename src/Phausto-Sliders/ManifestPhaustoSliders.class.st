"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestPhaustoSliders',
	#superclass : 'PackageManifest',
	#category : 'Phausto-Sliders-Manifest',
	#package : 'Phausto-Sliders',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestPhaustoSliders class >> ruleAssignmentInIfTrueRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#ToSliders #value: #false)) #'2025-05-07T15:42:04.267408+02:00') )
]

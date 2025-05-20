"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestPhaustoElement',
	#superclass : 'PackageManifest',
	#category : 'Phausto-Element-Manifest',
	#package : 'Phausto-Element',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestPhaustoElement class >> ruleStringConcatenationRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#ToWidgetElement #drawLabel #false)) #'2025-05-16T09:10:28.242192+02:00') )
]

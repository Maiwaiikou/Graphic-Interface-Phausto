"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestPharoJamSession',
	#superclass : 'PackageManifest',
	#category : 'PharoJamSession-Manifest',
	#package : 'PharoJamSession',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestPharoJamSession class >> ruleReGuardClauseRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#JamAbstractWidgetElement #resetToInit #false)) #'2025-05-22T10:36:14.244194+02:00') )
]

{ #category : 'code-critics' }
ManifestPharoJamSession class >> ruleStringConcatenationRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#JamAbstractWidgetElement #drawLabel #false)) #'2025-05-16T09:10:28.242192+02:00') )
]

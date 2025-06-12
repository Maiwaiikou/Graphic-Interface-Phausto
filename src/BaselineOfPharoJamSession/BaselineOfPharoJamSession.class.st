Class {
	#name : 'BaselineOfPharoJamSession',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfPharoJamSession',
	#package : 'BaselineOfPharoJamSession'
}

{ #category : 'baselines' }
BaselineOfPharoJamSession >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'CoypuIDE'
			with: [ spec repository: 'github://pharo-graphics/CoypuIDE/' ].
		spec
			package: 'PharoJamSession'
			with: [ spec requires: #( 'CoypuIDE' ) ] ]
]

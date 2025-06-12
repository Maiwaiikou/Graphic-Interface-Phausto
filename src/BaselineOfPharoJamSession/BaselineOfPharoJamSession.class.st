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
		spec package: 'PharoJamSession'.
		spec
			baseline: 'Bloc'
			with: [ spec repository: 'github://pharo-graphics/Bloc:v2.4.0/src' ].
		spec
			baseline: 'Toplo'
			with: [
			spec repository: 'github://pharo-graphics/Toplo:v0.5.0/src' ].
		spec
			baseline: 'Phausto'
			with: [ spec repository: 'github://lucretiomsp/phausto:main' ] ]
]

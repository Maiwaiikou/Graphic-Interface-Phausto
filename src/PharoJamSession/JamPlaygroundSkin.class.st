Class {
	#name : 'JamPlaygroundSkin',
	#superclass : 'ToRawSkin',
	#category : 'PharoJamSession-UIElementStyle',
	#package : 'PharoJamSession',
	#tag : 'UIElementStyle'
}

{ #category : 'event handling' }
JamPlaygroundSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt | elt background: (elt valueOfTokenNamed: #'JSPlayground-background') ]
]

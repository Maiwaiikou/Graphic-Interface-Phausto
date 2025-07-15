"
I'm the default skin for the JamSession, I only custom the background
"
Class {
	#name : 'JamSessionSkin',
	#superclass : 'ToRawSkin',
	#category : 'PharoJamSession-UIElementStyle',
	#package : 'PharoJamSession',
	#tag : 'UIElementStyle'
}

{ #category : 'event handling' }
JamSessionSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt | elt background: (elt valueOfTokenNamed: #'JSPlayground-background') ]
]

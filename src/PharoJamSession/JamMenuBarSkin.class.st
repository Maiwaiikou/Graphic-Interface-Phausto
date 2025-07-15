"
I'm the default skin for the JamMenuBar, I only custom the background
"
Class {
	#name : 'JamMenuBarSkin',
	#superclass : 'ToRawSkin',
	#category : 'PharoJamSession-UIElementStyle',
	#package : 'PharoJamSession',
	#tag : 'UIElementStyle'
}

{ #category : 'event handling' }
JamMenuBarSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt | elt background: (elt valueOfTokenNamed: #'menuPane-background') ]
]

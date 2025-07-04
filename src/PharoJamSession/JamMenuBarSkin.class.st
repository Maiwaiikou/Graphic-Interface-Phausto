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
	anEvent elementDo: [ :elt |
		elt background: (Color red alpha: 0.09).]
]

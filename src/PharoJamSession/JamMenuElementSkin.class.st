Class {
	#name : 'JamMenuElementSkin',
	#superclass : 'ToRawSkin',
	#category : 'PharoJamSession-UIElementStyle',
	#package : 'PharoJamSession',
	#tag : 'UIElementStyle'
}

{ #category : 'event handling' }
JamMenuElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt background: (elt valueOfTokenNamed: #'menuPane-background').
		elt height: (elt valueOfTokenNamed: #'menuPane-height').
		elt children do: [ :child |
			child endInterspace: (elt valueOfTokenNamed: #'menu-interspace').
			child endFlexible: true ] ]
]

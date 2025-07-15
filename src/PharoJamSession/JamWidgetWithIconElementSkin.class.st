"
I'm the skin of each JamWidgetWithIconElement.
"
Class {
	#name : 'JamWidgetWithIconElementSkin',
	#superclass : 'ToRawSkin',
	#category : 'PharoJamSession-UIElementStyle',
	#package : 'PharoJamSession',
	#tag : 'UIElementStyle'
}

{ #category : 'as yet unclassified' }
JamWidgetWithIconElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt extent: 70 @ 70.
		elt border: (BlBorder paint: Color black width: 1).
		elt background: (elt valueOfTokenNamed: #'widget-icon-background').
		elt geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
		elt inputConnect ifNotNil: [
			elt inputConnect background:
				(elt valueOfTokenNamed: #'input-connect-background') ].
		elt outputConnect ifNotNil: [
			elt outputConnect background:
				(elt valueOfTokenNamed: #'output-connect-background') ] ]
]

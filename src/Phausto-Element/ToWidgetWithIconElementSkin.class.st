Class {
	#name : 'ToWidgetWithIconElementSkin',
	#superclass : 'ToRawSkin',
	#category : 'Phausto-Element-Style',
	#package : 'Phausto-Element',
	#tag : 'Style'
}

{ #category : 'as yet unclassified' }
ToWidgetWithIconElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt size: 70 @ 70.
		elt border: (BlBorder paint: Color black width: 1).
		elt background: (elt valueOfTokenNamed: #'widget-icon-background').
		elt geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
		elt inputConnect background: ((elt isConnector: elt inputConnect) ifTrue: [
			(elt valueOfTokenNamed: #'input-connect-background')] ifFalse: [ Color transparent ]).
		elt outputConnect background: ((elt isConnector: elt outputConnect) ifTrue: [
			(elt valueOfTokenNamed: #'output-connect-background')] ifFalse: [ Color transparent ]). ]
]

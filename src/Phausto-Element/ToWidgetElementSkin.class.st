Class {
	#name : 'ToWidgetElementSkin',
	#superclass : 'ToRawSkin',
	#category : 'Phausto-Element-Style',
	#package : 'Phausto-Element',
	#tag : 'Style'
}

{ #category : 'as yet unclassified' }
ToWidgetElementSkin >> installSkinEvent: anEvent [
	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt size: 300@200.
		elt border: (BlBorder paint: Color black width: 1).
		elt background: (elt valueOfTokenNamed: #'widget-background').
		elt geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
		elt barElement size: 300@20; background: Color palePeach; border: (BlBorder paint: Color black width: 1).]
]

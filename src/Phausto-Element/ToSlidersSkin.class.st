Class {
	#name : 'ToSlidersSkin',
	#superclass : 'ToRawSkin',
	#category : 'Phausto-Element-Style',
	#package : 'Phausto-Element',
	#tag : 'Style'
}

{ #category : 'event handling' }
ToSlidersSkin >> installSkinEvent: anEvent [
	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt size: 170@20.
		elt border: (BlBorder paint: Color black width: 1).
		elt geometry: (BlRoundedRectangleGeometry cornerRadius: 10).
		elt background: Color lightOrange.
		]
]

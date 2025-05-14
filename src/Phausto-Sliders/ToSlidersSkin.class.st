Class {
	#name : 'ToSlidersSkin',
	#superclass : 'ToRawSkin',
	#category : 'Phausto-Sliders',
	#package : 'Phausto-Sliders'
}

{ #category : 'event handling' }
ToSlidersSkin >> installSkinEvent: anEvent [
	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt size: 200@20.
		elt border: (BlBorder paint: Color black width: 1).
		elt geometry: (BlRoundedRectangleGeometry cornerRadius: 10).
		elt background: Color lightOrange.
		]
]

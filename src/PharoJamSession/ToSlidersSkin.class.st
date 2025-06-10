Class {
	#name : 'ToSlidersSkin',
	#superclass : 'ToRawSkin',
	#category : 'PharoJamSession-UIElementStyle',
	#package : 'PharoJamSession',
	#tag : 'UIElementStyle'
}

{ #category : 'event handling' }
ToSlidersSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt size: 200 @ 20.
		elt background: Color transparent.
		elt sliderBar geometry:
			(BlRoundedRectangleGeometry cornerRadius: 10).
	   elt sliderBar border: (BlBorder paint: Color black width: 1).
		elt sliderBar background: Color lightRed.
		elt sliderBar size: 170 @ elt barThickness ]
]

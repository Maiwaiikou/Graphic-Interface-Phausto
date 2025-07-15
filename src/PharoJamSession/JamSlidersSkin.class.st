"
I'm the JamSliders skin, I can custom the size and background> I can also custo; the button background but in case of the sliderBar, I can custom size, background, border and geometry corner radius
"
Class {
	#name : 'JamSlidersSkin',
	#superclass : 'ToRawSkin',
	#category : 'PharoJamSession-UIElementStyle',
	#package : 'PharoJamSession',
	#tag : 'UIElementStyle'
}

{ #category : 'event handling' }
JamSlidersSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
			elt extent: 200 @ 20.
			elt background: Color transparent.
			elt button background:
				(elt valueOfTokenNamed: #'button-background').
			elt sliderBar geometry:
				(BlRoundedRectangleGeometry cornerRadius: 10).
			elt sliderBar border: (BlBorder paint: Color black width: 1).
			elt sliderBar background:
				(elt valueOfTokenNamed: #'slider-background').
			elt sliderBar extent: 170 @ elt barThickness ]
]

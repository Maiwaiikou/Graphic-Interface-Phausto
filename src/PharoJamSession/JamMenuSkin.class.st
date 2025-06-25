Class {
	#name : 'JamMenuSkin',
	#superclass : 'ToRawSkin',
	#category : 'PharoJamSession-UIElementStyle',
	#package : 'PharoJamSession',
	#tag : 'UIElementStyle'
}

{ #category : 'event handling' }
JamMenuSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt background: Color pink.
		elt height: 40.
		elt geometry: (BlRoundedRectangleGeometry cornerRadius: 3).
		elt border: (BlBorder paint: (Color red alpha: 0.05) width: 1).
		 ]
]

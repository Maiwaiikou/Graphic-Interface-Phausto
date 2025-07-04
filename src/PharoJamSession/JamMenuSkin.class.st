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
		elt subMenuContainer background:
			(elt valueOfTokenNamed: #'subMenuContainer-background');
			effect: (elt valueOfTokenNamed: #'subMenuContainer-effect').
		elt configuredAttributes: {
				(elt valueOfTokenNamed: #'button-width').
				(elt valueOfTokenNamed: #'button-padding').
				(BlTextForegroundAttribute paint:
					 (elt valueOfTokenNamed: #'button-text-color')).
				(BlFontSizeAttribute size:
					 (elt valueOfTokenNamed: #'button-text-size')) } ]
]

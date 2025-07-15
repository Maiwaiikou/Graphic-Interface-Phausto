"
I'm the skin for JamMenu, I custom background, height, geometry and border> I can also custom the subMenuContainer background and effects and the attributes confiredAttributes for custom the button width, padding, text color and text size.
"
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
		elt background: (elt valueOfTokenNamed: #'menu-background').
		elt height: (elt valueOfTokenNamed: #'menu-height').
		elt geometry: (BlRoundedRectangleGeometry cornerRadius: 3).
		elt border: (BlBorder paint: (elt valueOfTokenNamed: #'menu-border-color') width: (elt valueOfTokenNamed: #'menu-border-width')).
		elt subMenuContainer
			background: (elt valueOfTokenNamed: #'subMenuContainer-background');
			effect: (elt valueOfTokenNamed: #'subMenuContainer-effect').
		elt configuredAttributes: {
				(elt valueOfTokenNamed: #'button-width').
				(elt valueOfTokenNamed: #'button-padding').
				(BlTextForegroundAttribute paint:
					 (elt valueOfTokenNamed: #'button-text-color')).
				(BlFontSizeAttribute size:
					 (elt valueOfTokenNamed: #'button-text-size')) } ]
]

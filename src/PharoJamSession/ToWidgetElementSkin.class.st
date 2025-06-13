Class {
	#name : 'ToWidgetElementSkin',
	#superclass : 'ToRawSkin',
	#category : 'PharoJamSession-UIElementStyle',
	#package : 'PharoJamSession',
	#tag : 'UIElementStyle'
}

{ #category : 'as yet unclassified' }
ToWidgetElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt border: (BlBorder paint: Color black width: 1).
		elt background: (elt valueOfTokenNamed: #'widget-background').
		elt geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
		elt barElement
			background: (elt valueOfTokenNamed: #'bar-background');
			border: (BlBorder paint: Color black width: 1);
			size: 300 @ 20.
		elt inputConnect background: ((elt isConnector: elt inputConnect)
				 ifTrue: [ elt valueOfTokenNamed: #'input-connect-background' ]
				 ifFalse: [ Color transparent ]).
		elt outputConnect background: ((elt isConnector: elt outputConnect)
				 ifTrue: [ elt valueOfTokenNamed: #'output-connect-background' ]
				 ifFalse: [ Color transparent ]).

		elt configuredAttributes: {
				(BlTextForegroundAttribute paint:
					 (elt valueOfTokenNamed: #'labels-text-color')).
				(BlFontSizeAttribute size:
					 (elt valueOfTokenNamed: #'labels-text-size')) }.
		elt slidersLabels do: [ :label |
			label text attributes: elt configuredAttributes ] ]
]

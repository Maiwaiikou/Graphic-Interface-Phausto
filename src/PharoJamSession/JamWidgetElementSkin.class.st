Class {
	#name : 'JamWidgetElementSkin',
	#superclass : 'ToRawSkin',
	#category : 'PharoJamSession-UIElementStyle',
	#package : 'PharoJamSession',
	#tag : 'UIElementStyle'
}

{ #category : 'as yet unclassified' }
JamWidgetElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt border: (BlBorder paint: Color black width: 1).
		elt background: (elt valueOfTokenNamed: #'widget-background').
		elt geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (elt valueOfTokenNamed: #'widget-cornerRadius')).
		elt effect: (elt valueOfTokenNamed: #'widget-effect').

		(elt valueOfTokenNamed: #'widget-draggableEverywhere') ifTrue: [
			elt initializeDragWidgetEventOn: elt ].
		elt barElement
			background: (elt valueOfTokenNamed: #'bar-background');
			border: (elt valueOfTokenNamed: #'bar-border');
			width: (elt valueOfTokenNamed: #'bar-width');
			margin: (elt valueOfTokenNamed: #'bar-margin');
			constraintsDo: [ :c |
				(elt valueOfTokenNamed: #'bar-isTop')
					ifTrue: [ c frame vertical alignTop ]
					ifFalse: [ c frame vertical alignBottom ] ].
		elt barElement labelName margin: (BlInsets top: 5 bottom: 5).
		elt barElement labelName text attributes: {
				(BlTextForegroundAttribute paint:
					 (elt valueOfTokenNamed: #'bar-text-color')).
				(BlFontSizeAttribute size:
					 (elt valueOfTokenNamed: #'bar-text-size')) }.
		elt slidersContainer
			background: (elt valueOfTokenNamed: #'slidersContainer-background');
			border: (elt valueOfTokenNamed: #'slidersContainer-border');
			geometry: (BlRoundedRectangleGeometry cornerRadius:
						 (elt valueOfTokenNamed: #'slidersContainer-cornerRadius'));
			effect: (elt valueOfTokenNamed: #'slidersContainer-effect');
			margin: (elt valueOfTokenNamed: #'slidersContainer-margin').
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

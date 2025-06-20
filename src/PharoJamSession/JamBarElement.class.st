"
I'm a menu item bar with 2 subelements, a close button and a label name
"
Class {
	#name : 'JamBarElement',
	#superclass : 'ToElement',
	#instVars : [
		'name',
		'closeButton',
		'labelName',
		'configuredAttributes'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'accessing' }
JamBarElement >> closeButton [
	^ closeButton
]

{ #category : 'accessing' }
JamBarElement >> closeButton: aButton [
	closeButton := aButton.
]

{ #category : 'evaluating' }
JamBarElement >> configuredAttributes [
	^ configuredAttributes
]

{ #category : 'evaluating' }
JamBarElement >> configuredAttributes: anOrderedCollectionOfAttributes [
	configuredAttributes := anOrderedCollectionOfAttributes
]

{ #category : 'evaluating' }
JamBarElement >> configuredString: aString [

	| stringRoped |
	stringRoped := aString asRopedText.
	configuredAttributes ifNotEmpty: [
		stringRoped attributes: configuredAttributes ].
	^ stringRoped
]

{ #category : 'initialization' }
JamBarElement >> drawCloseButton [
	closeButton := ToIconicRemoveButton new.
	closeButton constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignLeft.
		 ].
	self addChild: closeButton. 
]

{ #category : 'initialization' }
JamBarElement >> drawLabelName [

	labelName := BlTextElement new.
	labelName text: (self configuredString: name).
	labelName constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignCenter ].
	self addChild: labelName
]

{ #category : 'initialization' }
JamBarElement >> initialize [

	super initialize.
	name := ''.
	configuredAttributes := OrderedCollection new.
	self drawCloseButton.
	self drawLabelName
]

{ #category : 'accessing' }
JamBarElement >> labelName [
	^ labelName
]

{ #category : 'accessing' }
JamBarElement >> name [
	^ name
]

{ #category : 'accessing' }
JamBarElement >> name: aString [
	name := aString.
	self removeChild: labelName.
	self drawLabelName.
]

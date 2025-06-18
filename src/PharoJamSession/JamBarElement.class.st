"
I'm a menu item bar with 2 subelements, a close button and a label name
"
Class {
	#name : 'JamBarElement',
	#superclass : 'ToElement',
	#instVars : [
		'name',
		'closeButton',
		'labelName'
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
	labelName := ToLabel new.
	labelName text: name.
	labelName constraintsDo: [ :c |
		c frame vertical alignCenter .
		c frame horizontal alignCenter.].
	self addChild: labelName.
	
]

{ #category : 'initialization' }
JamBarElement >> initialize [

	super initialize.
	name := ''.
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

"
I'm a menu item bar with 2 subelements, a close button and a label name
"
Class {
	#name : 'BarElement',
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
BarElement >> closeButton [
	^ closeButton
]

{ #category : 'accessing' }
BarElement >> closeButton: aButton [
	closeButton := aButton.
]

{ #category : 'initialization' }
BarElement >> drawCloseButton [
	closeButton := ToIconicRemoveButton new.
	closeButton constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignLeft.
		 ].
	self addChild: closeButton. 
]

{ #category : 'initialization' }
BarElement >> drawLabelName [
	labelName := ToLabel new.
	labelName text: name.
	labelName constraintsDo: [ :c |
		c frame vertical alignCenter .
		c frame horizontal alignCenter.].
	self addChild: labelName.
	
]

{ #category : 'initialization' }
BarElement >> initialize [

	super initialize.
	name := ''.
	self drawCloseButton.
	self drawLabelName
]

{ #category : 'accessing' }
BarElement >> labelName [
	^ labelName
]

{ #category : 'accessing' }
BarElement >> name [
	^ name
]

{ #category : 'accessing' }
BarElement >> name: aString [
	name := aString.
	self removeChild: labelName.
	self drawLabelName.
]

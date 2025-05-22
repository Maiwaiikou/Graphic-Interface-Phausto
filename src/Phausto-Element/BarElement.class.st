Class {
	#name : 'BarElement',
	#superclass : 'ToPane',
	#instVars : [
		'name',
		'closeButton',
		'labelName'
	],
	#category : 'Phausto-Element-Widget',
	#package : 'Phausto-Element',
	#tag : 'Widget'
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
	self horizontal: true.
	self layout: BlFrameLayout new.
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

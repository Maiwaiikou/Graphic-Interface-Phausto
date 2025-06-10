"
I'm a basic graphic slider who use drag and drop to edit my value by a defined step. I can show my value to other element when their call my callback method (which change when my value is increase or decrease).
"
Class {
	#name : 'ToSliders',
	#superclass : 'ToElement',
	#instVars : [
		'value',
		'button',
		'announcer',
		'minValue',
		'maxValue',
		'step',
		'callBack',
		'sliderBar',
		'barThickness',
		'barMargin'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'as yet unclassified' }
ToSliders class >> withAPhControlParam: aPhControlParam [

	| slider |
	slider := self new
		          value: (aPhControlParam initialValue ifNil: [ 0 ]).
	aPhControlParam max ifNotNil:[ :max | slider maxValue: max].
	aPhControlParam value ifNotNil:[ :min | slider minValue: min].
	aPhControlParam step ifNotNil:[ :step | slider step: step].
	
	^ slider
]

{ #category : 'accessing' }
ToSliders >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : 'accessing' }
ToSliders >> barMargin [
	^ barMargin
]

{ #category : 'accessing' }
ToSliders >> barMargin: anInteger [

	barMargin := anInteger.
]

{ #category : 'accessing' }
ToSliders >> barThickness [
	^ barThickness
]

{ #category : 'accessing' }
ToSliders >> barThickness: anInteger [
	barThickness := anInteger 
]

{ #category : 'accessing' }
ToSliders >> callBack [ 

	^ callBack
]

{ #category : 'accessing' }
ToSliders >> callBack: aBlock [ 

	callBack := aBlock
]

{ #category : 'as yet unclassified' }
ToSliders >> checkBounds: aPosition [

	| slidPosInSpace |
	slidPosInSpace := sliderBar positionInSpace x.

	^ aPosition
		  between: slidPosInSpace + barMargin
		  and: slidPosInSpace + sliderBar size x
]

{ #category : 'as yet unclassified' }
ToSliders >> checkMoveInBounds: aPosition [

	(aPosition < (self positionInSpace + button position x) and:
		 (aPosition isDivisibleBy: 2))
		ifTrue: [ self decreaseValue ]
		ifFalse: [ self increaseValue ]
]

{ #category : 'accessing' }
ToSliders >> createCircle [

	| circle |
	circle := BlElement new
		          background: Color white;
		          border: (BlBorder paint: Color black width: 1);
		          layout: BlFrameLayout new;
		          geometry: BlCircleGeometry new;
		          size: 20 @ 20.
	^ circle
]

{ #category : 'slider - api' }
ToSliders >> decreaseValue [

	value > minValue ifFalse: [ ^ self ].
	self value: value - step.
	self callBack
]

{ #category : 'slider - api' }
ToSliders >> increaseValue [

	value < maxValue ifFalse: [ ^ self ].
	self value: value + step.
	self callBack
]

{ #category : 'initialization' }
ToSliders >> initialize [

	super initialize.
	self layout: BlBasicLayout new.
	value := 0.
	step := 0.01.
	minValue := 0.
	maxValue := 100.
	barMargin := 10.
	barThickness := 5.
	self initializeSliderBar.
	self initializeButton
]

{ #category : 'initialization' }
ToSliders >> initializeButton [

	| offset |
	button := self createCircle.
	button position: barMargin @ 0.
	button addEventHandlerOn: BlDragStartEvent do: [ :evt |
		evt consumed: true.
		offset := evt position - button position ].
	button addEventHandlerOn: BlDragEvent do: [ :evt |
		evt consumed: true.
		(self checkBounds: evt position x) ifTrue: [
			self flag: #ToFix.
			self valueEditor: evt position x.
			button position: (evt position - offset) x @ 0 ] ].
	self flag: #ToAddClickEvent.
	self addChild: button
]

{ #category : 'initialization' }
ToSliders >> initializeSliderBar [

	| pos |
	sliderBar := BlElement new.
	pos := self size x + barMargin @ (self size y + barThickness + 2.5).
	sliderBar position: pos.
	self addChild: sliderBar
]

{ #category : 'slider - api' }
ToSliders >> maxValue [
	^ maxValue
]

{ #category : 'slider - api' }
ToSliders >> maxValue: anInteger [
	maxValue := anInteger.
]

{ #category : 'slider - api' }
ToSliders >> minValue [
	^ minValue
]

{ #category : 'slider - api' }
ToSliders >> minValue: anInteger [
	minValue := anInteger.
]

{ #category : 'instance creation' }
ToSliders >> newRawSkin [
	^ ToSlidersSkin new
]

{ #category : 'accessing' }
ToSliders >> sliderBar [
	^ sliderBar
]

{ #category : 'accessing' }
ToSliders >> sliderBar: aBlElement [

	sliderBar := aBlElement
]

{ #category : 'slider - api' }
ToSliders >> step [
	^ step
]

{ #category : 'slider - api' }
ToSliders >> step: AnIntegerOrFloat [

	step := step
]

{ #category : 'accessing' }
ToSliders >> value [
	^ value
]

{ #category : 'accessing' }
ToSliders >> value: anInteger [

	value := anInteger clampBetween: minValue and: maxValue.

	self callBack ifNotNil: [ :c | c value: value ]
]

{ #category : 'as yet unclassified' }
ToSliders >> valueEditor: aPosition [

	(aPosition < (self positionInSpace + button position x))
		ifTrue: [ self decreaseValue ]
		ifFalse: [ self increaseValue ]
]

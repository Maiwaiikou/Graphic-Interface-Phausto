"
I'm a basic graphic slider who use drag and drop to edit my value by a defined step. I can show my value to other element when their call my callback method (which change when my value is increase or decrease).
"
Class {
	#name : 'JamSliders',
	#superclass : 'ToElement',
	#instVars : [
		'label',
		'value',
		'possibleValues',
		'button',
		'announcer',
		'minValue',
		'maxValue',
		'step',
		'callBack',
		'sliderBar',
		'barThickness',
		'barMargin',
		'offset'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'as yet unclassified' }
JamSliders class >> withAPhControlParam: aPhControlParam [

	| slider |
	slider := self new.
	aPhControlParam initialValue ifNotNil: [ :initVal |
		slider value: initVal ].
	aPhControlParam max ifNotNil: [ :max | slider maxValue: max ].
	aPhControlParam min ifNotNil: [ :min | slider minValue: min ].
	aPhControlParam step ifNotNil: [ :step | slider step: step ].

	^ slider
]

{ #category : 'accessing' }
JamSliders >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : 'accessing' }
JamSliders >> barMargin [
	^ barMargin
]

{ #category : 'accessing' }
JamSliders >> barMargin: anInteger [

	barMargin := anInteger.
]

{ #category : 'accessing' }
JamSliders >> barThickness [
	^ barThickness
]

{ #category : 'accessing' }
JamSliders >> barThickness: anInteger [
	barThickness := anInteger 
]

{ #category : 'accessing' }
JamSliders >> button [
	^ button
]

{ #category : 'accessing' }
JamSliders >> callBack [ 

	^ callBack
]

{ #category : 'accessing' }
JamSliders >> callBack: aBlock [ 

	callBack := aBlock
]

{ #category : 'accessing' }
JamSliders >> createCircle [

	| circle |
	circle := BlElement new
		          border: (BlBorder paint: Color black width: 1);
		          layout: BlFrameLayout new;
		          geometry: BlCircleGeometry new;
		          transformDo: [ :t | t translateBy: -10 @ 0 ];
		          extent: 20 @ 20.
	^ circle
]

{ #category : 'slider - api' }
JamSliders >> decreaseValue [

	value > minValue ifFalse: [ ^ self ].
	self value: value - step.
	self callBack
]

{ #category : 'initialization' }
JamSliders >> handleMoveEvent: aPosition [

	| newPosX |
	newPosX := aPosition x.
	newPosX := newPosX max: sliderBar position x.
	newPosX := newPosX min: (sliderBar position + sliderBar extent) x.
	button position: newPosX @ 0
]

{ #category : 'slider - api' }
JamSliders >> increaseValue [

	value < maxValue ifFalse: [ ^ self ].
	self value: value + step.
	self callBack
]

{ #category : 'initialization' }
JamSliders >> initialize [

	super initialize.
	self layout: BlBasicLayout new.
	value := 0.
	step := 1.
	minValue := 0.
	maxValue := 100.
	barMargin := 10.
	barThickness := 5.
	offset := 0 asPoint.
	self updatePossibleValues.
	self initializeSliderBar.
	self initializeButton
]

{ #category : 'initialization' }
JamSliders >> initializeButton [

	button := self createCircle.
	button position: barMargin @ 0.
	
	"All event which edit value or move the button"
	
	self flag: #TODO.
	"Handle MouseDown and Drag at the same time"
	button addEventHandlerOn: BlDragStartEvent do: [ :evt |
		evt consumed: true.
		offset := evt position - self position ].
	button addEventHandlerOn: BlDragEvent do: [ :evt |
		evt consumed: true.
		self handleMoveEvent: evt position - offset.
		self updateValueAt: button position ].
	self addEventHandlerOn: BlMouseDownEvent do: [ :evt |
		evt consumed: true.
		"offset := evt position - self position."
		self handleMoveEvent: evt position - self positionInSpace ].
	self addEventHandlerOn: BlMouseUpEvent do: [ :evt |
		evt consumed: true.
		self updateValueAt: button position ].

	self addChild: button
]

{ #category : 'initialization' }
JamSliders >> initializeSliderBar [

	| pos |
	sliderBar := BlElement new.
	pos := self extent x + barMargin
	       @ (self extent y + barThickness + 2.5).
	sliderBar position: pos.
	self addChild: sliderBar
]

{ #category : 'accessing' }
JamSliders >> label [
^ label
]

{ #category : 'accessing' }
JamSliders >> label: aString [

label := aString 
]

{ #category : 'slider - api' }
JamSliders >> maxValue [
	^ maxValue
]

{ #category : 'slider - api' }
JamSliders >> maxValue: anInteger [

	maxValue := anInteger.
	self updatePossibleValues.
]

{ #category : 'slider - api' }
JamSliders >> minValue [
	^ minValue
]

{ #category : 'slider - api' }
JamSliders >> minValue: anInteger [

	minValue := anInteger.
	self updatePossibleValues.
]

{ #category : 'accessing' }
JamSliders >> nearestValue: anIntegerOrAFloat [
	
	|val currentMin tmp|
	val := possibleValues first.
	currentMin := (anIntegerOrAFloat - val) abs.
	possibleValues do: [ :v |
		tmp := (anIntegerOrAFloat - v) abs.
		tmp < currentMin ifTrue: [ 
			currentMin := tmp.
			val := v.
			 ] ].
	^ val.
]

{ #category : 'instance creation' }
JamSliders >> newRawSkin [
	^ JamSlidersSkin new
]

{ #category : 'accessing' }
JamSliders >> possibleValues [
	^ possibleValues
]

{ #category : 'accessing' }
JamSliders >> possibleValues: anOrderedCollection [

	possibleValues := anOrderedCollection new.
]

{ #category : 'accessing' }
JamSliders >> sliderBar [
	^ sliderBar
]

{ #category : 'accessing' }
JamSliders >> sliderBar: aBlElement [

	sliderBar := aBlElement
]

{ #category : 'slider - api' }
JamSliders >> step [
	^ step
]

{ #category : 'slider - api' }
JamSliders >> step: anIntegerOrFloat [

	step := anIntegerOrFloat.
	self updatePossibleValues.
]

{ #category : 'accessing' }
JamSliders >> updatePossibleValues [

	possibleValues := (minValue to: maxValue by: step)
		                  asOrderedCollection
]

{ #category : 'accessing' }
JamSliders >> updateValueAt: aPoint [

	| length valueDiff valProd coeff |
	length := (aPoint - sliderBar position) x.
	valProd := minValue.
	length = 0 ifFalse: [
			valueDiff := maxValue - minValue.
			coeff := sliderBar extent x / length.
			valProd := minValue + (valueDiff / coeff) ].
	self value: (self nearestValue: valProd)
]

{ #category : 'accessing' }
JamSliders >> value [
	^ value
]

{ #category : 'accessing' }
JamSliders >> value: anInteger [

	value := anInteger clampBetween: minValue and: maxValue.

	self callBack ifNotNil: [ :c | c value: value ]
]

Class {
	#name : 'ToSliders',
	#superclass : 'ToElement',
	#instVars : [
		'value',
		'button',
		'announcer',
		'minValue',
		'maxValue'
	],
	#category : 'Phausto-Sliders',
	#package : 'Phausto-Sliders'
}

{ #category : 'accessing' }
ToSliders >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : 'as yet unclassified' }
ToSliders >> checkBounds: aPosition [

	| slidPosInSpace |
	slidPosInSpace := self positionInSpace x.
	(aPosition
		 between: slidPosInSpace + 10
		 and: slidPosInSpace + self size x - 10) ifTrue: [ ^ true ].
	^ false
]

{ #category : 'as yet unclassified' }
ToSliders >> checkMoveInBounds: aPosition [

	(aPosition < (self positionInSpace + button position x) and:
		(aPosition isDivisibleBy: 2))
	ifTrue: [ self decreaseValue ]
		ifFalse: [ self increaseValue ].
]

{ #category : 'accessing' }
ToSliders >> createCircle [
	| circle |
	circle := BlElement new
					background: Color white; 
					border: (BlBorder paint: Color black width: 1);
					layout: BlFrameLayout new;
					geometry: BlCircleGeometry new;
					size: 20@20.
	^ circle
]

{ #category : 'evaluating' }
ToSliders >> decreaseValue [
	value > minValue ifFalse: [ ^ self ].
	value := value - 1.
	self notifyValueChange
]

{ #category : 'accessing' }
ToSliders >> drawButton [

	| offset |
	button := self createCircle.
	button addEventHandlerOn: BlDragStartEvent do: [ :evt |
		evt consumed: true.
		self positionInSpace.
		button positionInSpace.
		offset := evt position - button position ].
	button addEventHandlerOn: BlDragEvent do: [ :evt |
		evt consumed: true.
		(self checkBounds: evt position x) ifTrue: [
			self checkMoveInBounds: evt position x.
			button position: (evt position - offset) x @ 0 ] ].
	self addChild: button
]

{ #category : 'evaluating' }
ToSliders >> increaseValue [

	value < maxValue ifFalse: [ ^ self ].
	value := value + 1.
	self notifyValueChange
]

{ #category : 'initialization' }
ToSliders >> initialize [
	super initialize.
	self layout: BlBasicLayout new.
	value := 0.
	minValue := 0.
	maxValue := 100.
	self drawButton.
]

{ #category : 'accessing' }
ToSliders >> maxValue [
	^ maxValue
]

{ #category : 'accessing' }
ToSliders >> maxValue: anInteger [
	maxValue := anInteger.
]

{ #category : 'accessing' }
ToSliders >> minValue [
	^ minValue
]

{ #category : 'accessing' }
ToSliders >> minValue: anInteger [
	minValue := anInteger.
]

{ #category : 'instance creation' }
ToSliders >> newRawSkin [
	^ ToSlidersSkin new
]

{ #category : 'as yet unclassified' }
ToSliders >> notifyValueChange [
	^ self announcer announce: AnnouncerValueChange new.
]

{ #category : 'evaluating' }
ToSliders >> value [
	^ value
]

{ #category : 'evaluating' }
ToSliders >> value: anInteger [

	anInteger < 0
		ifTrue: [ value := 0 ]
		ifFalse: [
			anInteger > 100
				         ifTrue: [ value := 100 ]
				         ifFalse: [ value := anInteger ] ].
]

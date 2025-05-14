Class {
	#name : 'ToSliders',
	#superclass : 'ToElement',
	#instVars : [
		'value',
		'button',
		'announcer'
	],
	#category : 'Phausto-Sliders',
	#package : 'Phausto-Sliders'
}

{ #category : 'accessing' }
ToSliders >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : 'as yet unclassified' }
ToSliders >> checkBounds: pos [

	((pos between: self position x and: self size x) and:
		 pos ~= button position x) ifTrue: [ ^ true ].
	^ false
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
	value := value - 1.
	self notifyValueChange.
]

{ #category : 'accessing' }
ToSliders >> drawButton [

	| offset |
	button := self createCircle.
	"button constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter ]."
	button addEventHandlerOn: BlDragStartEvent do: [ :evt |
		evt consumed: true.
		offset := evt position - button position.].
	button addEventHandlerOn: BlDragEvent do: [ :evt |
		evt consumed: true.
		(self checkBounds: evt localPosition x) ifTrue: [
			evt localPosition x < button position x
				ifTrue: [ self decreaseValue ]
				ifFalse: [ self increaseValue ] ].
		button position: (evt position - offset) x @ 0 ].
	self addChild: button
]

{ #category : 'evaluating' }
ToSliders >> increaseValue [
	value := value + 1.
	self notifyValueChange.
]

{ #category : 'initialization' }
ToSliders >> initialize [
	super initialize.
	self layout: BlBasicLayout new.
	value := 0.
	self drawButton.
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

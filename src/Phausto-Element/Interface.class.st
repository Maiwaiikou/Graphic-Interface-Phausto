Class {
	#name : 'Interface',
	#superclass : 'BlElement',
	#instVars : [
		'menu',
		'childrenElements',
		'micro',
		'audio'
	],
	#category : 'Phausto-Element',
	#package : 'Phausto-Element'
}

{ #category : 'accessing' }
Interface >> audio [
	^ audio
]

{ #category : 'accessing' }
Interface >> childrenElements [
	^ childrenElements
]

{ #category : 'accessing' }
Interface >> childrenElements: aCollectionOfElements [
	childrenElements := aCollectionOfElements.
	self drawElement.
]

{ #category : 'as yet unclassified' }
Interface >> drawChildren [
	childrenElements do: [ :elt | 
		self addChild: elt.
		(elt isKindOf: ToWidgetElement) ifTrue: [
			self addChild: elt currentLine.
			elt lines do: [ :line | self addChild: line. ]
			]]
]

{ #category : 'as yet unclassified' }
Interface >> drawElement [
	self removeChildren.
	self addChild: menu.
	self drawChildren.
]

{ #category : 'initialization' }
Interface >> initialize [
	super initialize.
	childrenElements := OrderedCollection new.
	self size: 800@600.
	menu := MenuElement withWidgets.
	self drawElement.
]

{ #category : 'accessing' }
Interface >> menu [
	^ menu
]

{ #category : 'accessing' }
Interface >> menu: aMenuElement [
	menu := aMenuElement.
	self drawElement.
]

{ #category : 'accessing' }
Interface >> micro [
	^ micro
]

{ #category : 'instance creation' }
Interface >> open [
	|space|
	space := BlSpace new.
	space toTheme: ToWidgetTheme new.
	space root addChild: self.
	space show
]

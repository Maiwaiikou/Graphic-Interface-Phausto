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
			(elt isConnector: elt leftConnect) ifTrue: [
				self addChild: elt leftConnect line ].
			(elt isConnector: elt rightConnect) ifTrue: [
				self addChild: elt rightConnect line ] ] ]
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
	self size: 800 @ 600.
	menu := MenuElement withWidgets.
	self addEventHandlerOn: BlDropEvent do: [ :evt |
		evt consumed: true.
		(evt gestureSource isKindOf: Connector) ifTrue: [
			evt gestureSource line: BlElement new.
			self drawElement ] ].
	self drawElement
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

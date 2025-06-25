Class {
	#name : 'JamMenuBar',
	#superclass : 'ToElement',
	#instVars : [
		'menus',
		'spaceElement'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'as yet unclassified' }
JamMenuBar class >> defaultMenu [

	| menuBar |
	menuBar := self new.
	menuBar addMenu: JamMenu defaultSoundsMenu.
	menuBar updateMenuBar.
	^ menuBar
]

{ #category : 'as yet unclassified' }
JamMenuBar class >> defaultMenuWithSpace: anElement [

	| menuBar |
	menuBar := self new spaceElement: anElement.
	menuBar addMenu: JamMenu defaultSoundsMenu.
	menuBar updateMenuBar.
	^ menuBar
]

{ #category : 'initialization' }
JamMenuBar >> addMenu: aMenu [

	aMenu spaceElement: spaceElement.
	menus add: aMenu
]

{ #category : 'initialization' }
JamMenuBar >> createMenu [

	menus do: [ :menu |
		self addChild: menu.
		menu constraintsDo: [ :c |
			c vertical matchParent.
			 ] ]
]

{ #category : 'initialization' }
JamMenuBar >> initialize [

	super initialize.
	menus := OrderedCollection new.
	"self size: 500 @ 30."
	self layout: BlLinearLayout new
]

{ #category : 'accessing' }
JamMenuBar >> menus [
	^ menus
]

{ #category : 'accessing' }
JamMenuBar >> menus: anOrderedCollectionOfMenu [

	menus := anOrderedCollectionOfMenu.
]

{ #category : 'instance creation' }
JamMenuBar >> newRawSkin [

	^ JamMenuBarSkin new
]

{ #category : 'initialization' }
JamMenuBar >> removeMenu: aMenu [

	menus remove: aMenu ifAbsent: [  ].
	self removeChild: aMenu.
]

{ #category : 'accessing' }
JamMenuBar >> spaceElement [
	^ spaceElement
]

{ #category : 'accessing' }
JamMenuBar >> spaceElement: anElement [
	spaceElement := anElement
]

{ #category : 'initialization' }
JamMenuBar >> updateMenuBar [

	self removeChildren.
	self createMenu
]

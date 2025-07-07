"
I'm a menu bar create for JamSession. I can have many children menu by using addMenu: and then everything is add, I need to update myself (updateMenuBar) for the graphic.
"
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

	^ self new spaceElement: anElement; initializeDefaultMenu.
]

{ #category : 'examples' }
JamMenuBar class >> exampleMenuBar [

	| dict bar menu space |
	self flag: #ToChange.
	dict := Dictionary new.
	dict at: 'Open playground' put: [ Smalltalk tools openWorkspace ].
	bar := self new.
	bar constraintsDo: [ :c | c horizontal matchParent ].
	space := JamSession new clear.
	space addChild: bar.
	bar spaceElement: space.
	menu := JamMenu new
		        title: 'I NEED A PLAYGROUND';
		        categories: { ('File' -> dict) } asDictionary.
	bar addMenu: menu.
	bar addMenu: (JamMenu new
			 title: 'Specials songs';
			 categories:
				 { ('Song' -> { (JamWidgetElement new name: 'Petit poney') }) }
					 asDictionary).
	bar updateMenuBar.
	space open
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

{ #category : 'initialization' }
JamMenuBar >> initializeDefaultMenu [

	self addMenu: JamMenu defaultFileMenu.
	self updateMenuBar.
	self addMenu: JamMenu defaultSoundsMenu.
	self updateMenuBar
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

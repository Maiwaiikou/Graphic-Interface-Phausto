Class {
	#name : 'JamMenuBar',
	#superclass : 'ToElement',
	#instVars : [
		'menus'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'initialization' }
JamMenuBar >> addMenu: aMenu [
	aMenu spaceElement: self parent.
	menus add: aMenu.
]

{ #category : 'initialization' }
JamMenuBar >> createMenu [
	menus do: [ :menu | self addChild: menu ].
]

{ #category : 'initialization' }
JamMenuBar >> initialize [

	super initialize.
	menus := OrderedCollection new.
	self background: (Color red alpha: 0.09).
	self size: 500 @ 100.
	self layout: BlLinearLayout new.
]

{ #category : 'accessing' }
JamMenuBar >> menus [
	^ menus
]

{ #category : 'accessing' }
JamMenuBar >> menus: anOrderedCollectionOfMenu [

	menus := anOrderedCollectionOfMenu.
]

{ #category : 'initialization' }
JamMenuBar >> removeMenu: aMenu [

	menus remove: aMenu ifAbsent: [  ].
	self removeChild: aMenu.
]

{ #category : 'initialization' }
JamMenuBar >> updateMenuBar [

	self removeChildren.
	self createMenu
]

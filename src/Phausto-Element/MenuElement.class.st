Class {
	#name : 'MenuElement',
	#superclass : 'ToMenuPane',
	#instVars : [
		'menuItem'
	],
	#category : 'Phausto-Element-Menu',
	#package : 'Phausto-Element',
	#tag : 'Menu'
}

{ #category : 'as yet unclassified' }
MenuElement class >> withWidgets [

	^ self new menuItem: ToWidgetElement widgetsOscillator.
]

{ #category : 'as yet unclassified' }
MenuElement >> childMenu: aString [

	self children do: [ :aChild |
		(aChild labelText = aString) ifTrue: [^ aChild ]].
	^ nil
]

{ #category : 'instance creation' }
MenuElement >> createFileMenu [

	| menu items  elt |
	menu := ToMenu new labelText: 'File'.
	items := { 'New page'. 'Open a file'. 'Save'. 'Save as'.}.
	items do: [ :i |
		elt := ToMenuItem new labelText: i.
		menu addItem: elt ].
	elt := ToMenuItem new labelText: 'Clear'.
	elt addEventHandlerOn: BlClickEvent do: [
		self parent resetElements.
		self parent childrenElements removeAll.
		self parent drawElement ].
	menu addItem: elt.
	self addChild: menu
]

{ #category : 'instance creation' }
MenuElement >> createSettingMenu [

	| menu items elt |
	menu := ToMenu new labelText: 'Settings'.
	items := { 'Contact support' }.
	items do: [ :i |
		elt := ToMenuItem new labelText: i.
		menu addItem: elt ].
	self addChild: menu
]

{ #category : 'instance creation' }
MenuElement >> createSoundsMenu [
	|menu aMenuEventListener|
	aMenuEventListener := self newMenuEventListener menu:self.
	menu := ToMenu new labelText: 'Sounds'.
	menuItem do: [ :i | 
		|elt|
		i atRandomPos.
		elt := MenuItemElement new widget:i.
		elt addEventHandler: aMenuEventListener.
		menu addItem: elt ].
	self addChild: menu.
]

{ #category : 'as yet unclassified' }
MenuElement >> defaultConstrains [

	self constraintsDo: [ :c |
		c frame vertical alignTop.
		c padding: (BlInsets left: parent size x right: parent size x) ]
]

{ #category : 'accessing' }
MenuElement >> initialize [

	super initialize.
	self horizontal: true.
	self width: 500.
	menuItem := OrderedCollection new.
	self refreshMenu
]

{ #category : 'accessing' }
MenuElement >> menuItem [
	^ menuItem
]

{ #category : 'accessing' }
MenuElement >> menuItem: aCollectionOfMenuItemElement [
	menuItem := aCollectionOfMenuItemElement.
	self refreshMenu.
]

{ #category : 'instance creation' }
MenuElement >> newMenuEventListener [
	^ MenuEventListeners new.
]

{ #category : 'as yet unclassified' }
MenuElement >> refreshMenu [

	self removeChildren.
	self createFileMenu.
	self createSoundsMenu.
	self createSettingMenu
]

{ #category : 'initialization' }
MenuElement >> resetMenu [
	menuItem do: [ :item |
		item enable ].
]

{ #category : 'as yet unclassified' }
MenuElement >> subMenuItem: aMenu [
	^ aMenu itemBar children.
]

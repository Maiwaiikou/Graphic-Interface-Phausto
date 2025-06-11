"
I'm the menu of the interface compose with functionnalities such as Export, Save and help functionnalities.
I'm also compose with many MenuItemElement, each of them handle the creation of a widget song.
"
Class {
	#name : 'MenuElement',
	#superclass : 'ToMenuPane',
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'as yet unclassified' }
MenuElement >> childMenu: aString [

	self children do: [ :aChild |
		(aChild labelText = aString) ifTrue: [^ aChild ]].
	^ nil
]

{ #category : 'as yet unclassified' }
MenuElement >> createEffectsMenu [
	| menu aMenuEventListener |
	aMenuEventListener := self newMenuEventListener menu: self.
	menu := ToMenu new labelText: 'Effects'.
	ToWidgetElement widgetsEffects do: [ :i |
		| elt |
		i atRandomPos.
		elt := MenuItemElement new widget: i.
		elt addEventHandler: aMenuEventListener.
		menu addItem: elt ].
	^ menu
	
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

{ #category : 'as yet unclassified' }
MenuElement >> createInstrumentMenu [

	| menu aMenuEventListener |
	aMenuEventListener := self newMenuEventListener menu: self.
	menu := ToMenu new labelText: 'Instrument'.
	ToWidgetElement widgetsInstruments do: [ :i |
		| elt |
		i atRandomPos.
		elt := MenuItemElement new widget: i.
		elt addEventHandler: aMenuEventListener.
		menu addItem: elt ].
	^ menu
]

{ #category : 'as yet unclassified' }
MenuElement >> createOscillatorMenu [

	| menu aMenuEventListener |
	aMenuEventListener := self newMenuEventListener menu: self.
	menu := ToMenu new labelText: 'Oscillators'.
	ToWidgetElement widgetsOscillator do: [ :i |
		| elt |
		i atRandomPos.
		elt := MenuItemElement new widget: i.
		elt addEventHandler: aMenuEventListener.
		menu addItem: elt ].
	^ menu
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

	| menu aMenuEventListener |
	aMenuEventListener := self newMenuEventListener menu: self.
	menu := ToMenu new labelText: 'Sounds'.
	menu addItem: self createEffectsMenu.
	menu addItem: self createOscillatorMenu.
	menu addItem: self createSynthsMenu.
	menu addItem: self createInstrumentMenu.
	self addChild: menu
]

{ #category : 'as yet unclassified' }
MenuElement >> createSynthsMenu [
	| menu aMenuEventListener |
	aMenuEventListener := self newMenuEventListener menu: self.
	menu := ToMenu new labelText: 'Synths'.
	ToWidgetElement widgetsSynths do: [ :i |
		| elt |
		i atRandomPos.
		elt := MenuItemElement new widget: i.
		elt addEventHandler: aMenuEventListener.
		menu addItem: elt ].
	^ menu
	
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
	self refreshMenu
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

{ #category : 'as yet unclassified' }
MenuElement >> subMenuItem: aMenu [
	^ aMenu itemBar children.
]

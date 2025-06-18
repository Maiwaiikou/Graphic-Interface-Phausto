"
I'm the menu of the interface compose with functionnalities such as Export, Save and help functionnalities.
I'm also compose with many MenuItemElement, each of them handle the creation of a widget song.
"
Class {
	#name : 'JamMenuElement',
	#superclass : 'ToMenuPane',
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'as yet unclassified' }
JamMenuElement >> childMenu: aString [

	self children do: [ :aChild |
		(aChild labelText = aString) ifTrue: [^ aChild ]].
	^ nil
]

{ #category : 'as yet unclassified' }
JamMenuElement >> createEffectsMenu [
	| menu aMenuEventListener |
	aMenuEventListener := self newMenuEventListener menu: self.
	menu := ToMenu new labelText: 'Effects'.
	JamWidgetElement widgetsEffects do: [ :i |
		| elt |
		i atRandomPos.
		elt := JamMenuItemElement new widget: i.
		elt addEventHandler: aMenuEventListener.
		menu addItem: elt ].
	^ menu
	
]

{ #category : 'instance creation' }
JamMenuElement >> createFileMenu [

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
JamMenuElement >> createInstrumentMenu [

	| menu aMenuEventListener |
	aMenuEventListener := self newMenuEventListener menu: self.
	menu := ToMenu new labelText: 'Instrument'.
	JamWidgetElement widgetsInstruments do: [ :i |
		| elt |
		i atRandomPos.
		elt := JamMenuItemElement new widget: i.
		elt addEventHandler: aMenuEventListener.
		menu addItem: elt ].
	^ menu
]

{ #category : 'as yet unclassified' }
JamMenuElement >> createOscillatorMenu [

	| menu aMenuEventListener |
	aMenuEventListener := self newMenuEventListener menu: self.
	menu := ToMenu new labelText: 'Oscillators'.
	JamWidgetElement widgetsOscillator do: [ :i |
		| elt |
		i atRandomPos.
		elt := JamMenuItemElement new widget: i.
		elt addEventHandler: aMenuEventListener.
		menu addItem: elt ].
	^ menu
]

{ #category : 'instance creation' }
JamMenuElement >> createSettingMenu [

	| menu items elt |
	menu := ToMenu new labelText: 'Settings'.
	items := { 'Contact support' }.
	items do: [ :i |
		elt := ToMenuItem new labelText: i.
		menu addItem: elt ].
	self addChild: menu
]

{ #category : 'instance creation' }
JamMenuElement >> createSoundsMenu [

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
JamMenuElement >> createSynthsMenu [
	| menu aMenuEventListener |
	aMenuEventListener := self newMenuEventListener menu: self.
	menu := ToMenu new labelText: 'Synths'.
	JamWidgetElement widgetsSynths do: [ :i |
		| elt |
		i atRandomPos.
		elt := JamMenuItemElement new widget: i.
		elt addEventHandler: aMenuEventListener.
		menu addItem: elt ].
	^ menu
	
]

{ #category : 'initialization' }
JamMenuElement >> initialize [

	super initialize.
	self horizontal: true.
	self refreshMenu
]

{ #category : 'instance creation' }
JamMenuElement >> newMenuEventListener [
	^ JamMenuEventListeners new.
]

{ #category : 'skin' }
JamMenuElement >> newRawSkin [
	^ JamMenuElementSkin new.
]

{ #category : 'as yet unclassified' }
JamMenuElement >> refreshMenu [

	self removeChildren.
	self createFileMenu.
	self createSoundsMenu.
	self createSettingMenu
]

{ #category : 'as yet unclassified' }
JamMenuElement >> subMenuItem: aMenu [
	^ aMenu itemBar children.
]

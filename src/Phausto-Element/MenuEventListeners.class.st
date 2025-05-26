Class {
	#name : 'MenuEventListeners',
	#superclass : 'BlEventListener',
	#instVars : [
		'menu'
	],
	#category : 'Phausto-Element-Menu',
	#package : 'Phausto-Element',
	#tag : 'Menu'
}

{ #category : 'mouse handlers' }
MenuEventListeners >> clickEvent: anEvent [

	menu parent childrenElements add: anEvent currentTarget widget.
	anEvent currentTarget widget announcer
		when: LineCurrentlyDrawAnnouncer
		send: #drawElement
		to: menu parent.
	anEvent currentTarget widget announcer
		when: EnableCreationAnnouncer
		send: #enable 
		to: anEvent currentTarget.
	anEvent currentTarget disable.
	menu parent drawElement
]

{ #category : 'accessing' }
MenuEventListeners >> menu [
	^ menu
]

{ #category : 'accessing' }
MenuEventListeners >> menu: aMenuElement [
	menu := aMenuElement.
]

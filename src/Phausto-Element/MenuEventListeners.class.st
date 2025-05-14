Class {
	#name : 'MenuEventListeners',
	#superclass : 'BlEventListener',
	#instVars : [
		'menu'
	],
	#category : 'Phausto-Element',
	#package : 'Phausto-Element'
}

{ #category : 'mouse handlers' }
MenuEventListeners >> clickEvent: anEvent [
	menu parent childrenElements add: (anEvent currentTarget widget).
	anEvent currentTarget widget announcer when: LineCurrentlyDrawAnnouncer send:#drawElement to: menu parent.
	menu parent drawElement.
]

{ #category : 'accessing' }
MenuEventListeners >> menu [
	^ menu
]

{ #category : 'accessing' }
MenuEventListeners >> menu: aMenuElement [
	menu := aMenuElement.
]

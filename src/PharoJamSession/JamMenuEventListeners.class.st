"
I'm just a little event to permitt the creation of widget when someone click on the MenuItemElement.
"
Class {
	#name : 'JamMenuEventListeners',
	#superclass : 'BlEventListener',
	#instVars : [
		'menu'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'mouse handlers' }
JamMenuEventListeners >> clickEvent: anEvent [

	menu parent addChildElement: anEvent currentTarget widget.
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
JamMenuEventListeners >> menu [
	^ menu
]

{ #category : 'accessing' }
JamMenuEventListeners >> menu: aMenuElement [
	menu := aMenuElement.
]

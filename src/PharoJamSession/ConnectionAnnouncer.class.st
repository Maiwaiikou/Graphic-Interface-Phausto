"
I announce connection between Instruments and Effects
"
Class {
	#name : 'ConnectionAnnouncer',
	#superclass : 'Announcement',
	#instVars : [
		'source'
	],
	#category : 'PharoJamSession-UIElementAnnouncer',
	#package : 'PharoJamSession',
	#tag : 'UIElementAnnouncer'
}

{ #category : 'accessing' }
ConnectionAnnouncer >> source [

	^ source
]

{ #category : 'accessing' }
ConnectionAnnouncer >> source: anObject [

	source := anObject
]

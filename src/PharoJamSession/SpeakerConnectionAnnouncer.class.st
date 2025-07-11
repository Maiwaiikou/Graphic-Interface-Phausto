"
I announce the connection to the Speaker widget for audio output
"
Class {
	#name : 'SpeakerConnectionAnnouncer',
	#superclass : 'Announcement',
	#instVars : [
		'source'
	],
	#category : 'PharoJamSession-UIElementAnnouncer',
	#package : 'PharoJamSession',
	#tag : 'UIElementAnnouncer'
}

{ #category : 'accessing' }
SpeakerConnectionAnnouncer >> source [

	^ source
]

{ #category : 'accessing' }
SpeakerConnectionAnnouncer >> source: anObject [

	source := anObject
]

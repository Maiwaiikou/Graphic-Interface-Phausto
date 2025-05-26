Class {
	#name : 'AnnouncerValueChange',
	#superclass : 'Announcement',
	#instVars : [
		'value'
	],
	#category : 'Phausto-Sliders',
	#package : 'Phausto-Sliders'
}

{ #category : 'evaluating' }
AnnouncerValueChange >> value [ 

	^ value
]

{ #category : 'accessing' }
AnnouncerValueChange >> value: aNumber [ 

	value := aNumber 
]

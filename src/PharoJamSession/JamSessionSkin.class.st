"
I'm the default skin for the JamSession, I only custom the background
"
Class {
	#name : 'JamSessionSkin',
	#superclass : 'ToRawSkin',
	#category : 'PharoJamSession-UIElementStyle',
	#package : 'PharoJamSession',
	#tag : 'UIElementStyle'
}

{ #category : 'as yet unclassified' }
JamSessionSkin >> imgFromURL: anURL size: aSize [

	^ ((ZnEasy getJpeg: anURL) scaledToSize: aSize*1.5) asForm
]

{ #category : 'event handling' }
JamSessionSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
			(elt valueOfTokenNamed: #'JamSession-background-url') = ''
				ifTrue: [ elt background: (elt valueOfTokenNamed: #'JamSession-background') 
					]
				ifFalse: [
						| bg |
						bg := BlImageBackground new.
						bg image: (self
								 imgFromURL:
								 (elt valueOfTokenNamed: #'JamSession-background-url')
								 size: elt sizeElt).
						elt background: bg ] ]
]

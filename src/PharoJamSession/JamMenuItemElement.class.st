"
I'm a ToMenuItemElement which have a attribut widget to it creation when someone click on me.
"
Class {
	#name : 'JamMenuItemElement',
	#superclass : 'ToMenuItem',
	#instVars : [
		'widget'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'initialization' }
JamMenuItemElement >> resetLabelText [
	self labelText: widget name
]

{ #category : 'initialization' }
JamMenuItemElement >> widget [
	^widget
]

{ #category : 'initialization' }
JamMenuItemElement >> widget: aWidget [
	widget := aWidget.
	self resetLabelText.
]

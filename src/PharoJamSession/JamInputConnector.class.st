Class {
	#name : 'JamInputConnector',
	#superclass : 'JamConnector',
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'initialization' }
JamInputConnector >> checkBeforeDisconnect [

	self connectTo ifEmpty: [ ^ self ].
	self disconnect
]

{ #category : 'initialization' }
JamInputConnector >> connectTo: aWidget [

	(connectTo includes: aWidget) ifTrue: [ ^self ].
	aWidget ifNil: [
		self disconnect.
		^ self ].
	connectTo add: aWidget.
	parent notifyConnection
]

{ #category : 'connecting' }
JamInputConnector >> disconnect [
	|connectedWidgets|
	connectedWidgets := connectTo copy.
	connectedWidgets do: [ :widget |
		widget outputConnect connectTo ifNil: [ connectTo remove: widget. parent notifyDisconnection. ] ]
]

{ #category : 'initialization' }
JamInputConnector >> initialize [

	super initialize.
	connectTo := OrderedCollection new
]

{ #category : 'accessing' }
JamInputConnector >> isInputConnect [
	^ true
]

{ #category : 'initialization' }
JamInputConnector >> resetInit [
	connectTo do: [ :widget | widget outputConnect line: BlElement new ].
	self checkBeforeDisconnect
]

{ #category : 'connecting' }
JamInputConnector >> updateLine [
	connectTo do: [ :widget | widget outputConnect updateLine ].
]

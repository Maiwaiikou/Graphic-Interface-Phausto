"
I'm a specific connector for input, I allowed multiple connections and i'm use in case we applied some effects from synthsPaths of my parent (a widget) to each widget connected to me.
"
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
	parent notifyConnectionWith: aWidget synthPatch .
]

{ #category : 'connecting' }
JamInputConnector >> disconnect [

	| connectedWidgets |
	connectedWidgets := connectTo copy.
	connectedWidgets do: [ :widget |
		widget outputConnect connectTo ifNil: [
			connectTo remove: widget.
			widget notifyDisconnection.
			parent notifyDisconnection ] ]
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

	connectTo do: [ :widget | widget outputConnect line: nil ].
	self checkBeforeDisconnect
]

{ #category : 'connecting' }
JamInputConnector >> updateLine [
	connectTo do: [ :widget | widget outputConnect updateLine ].
]

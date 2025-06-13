Class {
	#name : 'InputConnector',
	#superclass : 'Connector',
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'initialization' }
InputConnector >> checkBeforeDisconnect [

	self connectTo ifEmpty: [ ^ self ].
	self disconnect
]

{ #category : 'accessing' }
InputConnector >> connectTo: aWidget [

	connectTo add: aWidget.
	aWidget ifNil: [
		parent notifyDisconnection.
		^ self ].
	parent notifyConnection
]

{ #category : 'connecting' }
InputConnector >> disconnect [
	|connectedWidgets|
	connectedWidgets := connectTo copy.
	connectedWidgets do: [ :widget |
		widget outputConnect connectTo ifNil: [ connectTo remove: widget ] ]
]

{ #category : 'initialization' }
InputConnector >> initialize [
	super initialize.
	connectTo := OrderedCollection new.
]

{ #category : 'accessing' }
InputConnector >> isInputConnect [
	^ true.
]

{ #category : 'connecting' }
InputConnector >> updateLine [
	connectTo do: [ :widget | widget outputConnect updateLine ].
]

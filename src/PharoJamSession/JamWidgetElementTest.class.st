Class {
	#name : 'JamWidgetElementTest',
	#superclass : 'TestCase',
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'tests' }
JamWidgetElementTest >> testIsConnectedTo [

	| w1 w2 |
	w1 := JamWidgetElement new.
	w2 := JamWidgetElement onlyWithInputConnector.
	w1 outputConnect connect: w2 inputConnect.
	self assert: (w1 isConnectedTo: w2)
]

{ #category : 'tests' }
JamWidgetElementTest >> testIsConnectedToWhenThereIsAWidgetBetween [

	| w1 w2 w3 |
	w1 := JamWidgetElement new.
	w2 := JamWidgetElement new.
	w3 := JamWidgetElement onlyWithInputConnector.
	w1 outputConnect connect: w2 inputConnect.
	w2 outputConnect connect: w3 inputConnect.
	self assert: (w1 isConnectedTo: w3)
]

{ #category : 'tests' }
JamWidgetElementTest >> testIsConnectedToWhenThereIsNoConnection [

	| w1 w2 |
	w1 := JamWidgetElement new.
	w2 := JamWidgetElement new.

	self deny: (w1 isConnectedTo: w2)
]

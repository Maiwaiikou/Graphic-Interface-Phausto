Class {
	#name : 'JamWidgetElement',
	#superclass : 'JamAbstractWidgetElement',
	#instVars : [
		'synthPatch'
	],
	#category : 'PharoJamSession-UIElement',
	#package : 'PharoJamSession',
	#tag : 'UIElement'
}

{ #category : 'configuring' }
JamWidgetElement class >> configureFor: anArrayOfClassName [

	| widgetsList widget currentControlParameter phControlParameter |
	widgetsList := OrderedCollection new.
	anArrayOfClassName do: [ :osc |
			widget := (self typeOfWidget: osc new)
				          name: osc asString;
				          phaustoSound: osc .
			 widget synthPatch add: osc.
			currentControlParameter := osc new controlParameters.
			currentControlParameter keysDo: [ :key |
					phControlParameter := currentControlParameter at: key.
					widget slidersDic
						at: key asString
						put: (JamSliders withAPhControlParam: phControlParameter) ].
			widget initializeSliders.
			widgetsList add: widget ].
	^ widgetsList
]

{ #category : 'configuring' }
JamWidgetElement class >> configureWithoutSoundFor: anArrayOfClassName [

	| widgetsList widget currentControlParameter phControlParameter |
	widgetsList := OrderedCollection new.
	anArrayOfClassName do: [ :className |
		widget := (self typeOfWidget: className new)
			          name: className asString.
		currentControlParameter := className new controlParameters.
		currentControlParameter keysDo: [ :key |
			phControlParameter := currentControlParameter at: key.
			widget slidersDic
				at: key asString
				put: (JamSliders withAPhControlParam: phControlParameter) ].
		widget initializeSliders.
		widgetsList add: widget ].
	^ widgetsList
]

{ #category : 'examples' }
JamWidgetElement class >> exampleWidgetWithDifferentTheme [

	<example>
	| interface theme |
	interface := JamSession new clear.
	theme := JamTheme new.
	theme addTokenProperties: {
			(ToTokenProperty name: #'widget-background' value: Color white).
			(ToTokenProperty
				 name: #'bar-background'
				 value: (Color blue alpha: 0.5)).
			(ToTokenProperty
				 name: #'input-connect-background'
				 value: Color pink).
			(ToTokenProperty
				 name: #'output-connect-background'
				 value: Color purple).
			(ToTokenProperty
				 name: #'output-connect-background'
				 value: Color purple).
			(ToTokenProperty name: #'slider-background' value: Color red).
			(ToTokenProperty name: #'button-background' value: Color lightGray).
			(ToTokenProperty name: #'labels-text-color' value: Color magenta).
			(ToTokenProperty name: #'labels-text-size' value: 20).
			(ToTokenProperty
				 name: #'JSPlayground-background'
				 value: Color transparent).
			(ToTokenProperty
				 name: #'bar-border'
				 value: (BlBorder paint: Color transparent width: 1)).
			(ToTokenProperty name: #'widget-cornerRadius' value: 30).
			(ToTokenProperty
				 name: #'widget-effect'
				 value:
				 (BlGaussianShadowEffect color: Color red width: 2 offset: 7 @ 11)).
			(ToTokenProperty
				 name: #'slidersContainer-background'
				 value: Color lightBlue).
			(ToTokenProperty
				 name: #'slidersContainer-border'
				 value: (BlBorder paint: Color black width: 1)).
			(ToTokenProperty name: #'slidersContainer-cornerRadius' value: 20).
			(ToTokenProperty
				 name: #'slidersContainer-effect'
				 value:
				 (BlGaussianShadowEffect color: Color green width: 2 offset: 2 @ 6)).
			((ToTokenProperty name: #'slidersContainer-margin') value:
				 (BlInsets all: 25)).
			ToTokenProperty name: #'bar-isTop' value: false.
			ToTokenProperty name: #'bar-width' value: 500.
			ToTokenProperty name: #'bar-margin' value: (BlInsets left: 30).
			ToTokenProperty name: #'bar-text-color' value: Color green.
ToTokenProperty name: #'bar-text-size' value: 10 }.
	interface theme: theme.
	interface addChildElement: (self new
			 name: 'WindowsXp';
			 slidersDic: { ('Bug Counter' -> JamSliders new) } asDictionary).
	interface open
]

{ #category : 'examples' }
JamWidgetElement class >> exampleWidgetWithInputConnector [

	<example>
	| interface |
	interface := JamSession new clear.
	interface addChildElement: (self onlyWithInputConnector name: 'Beautiful widget' ).
	interface open
]

{ #category : 'examples' }
JamWidgetElement class >> exampleWidgetWithMultipleSliders [

	<example>
	| interface dict |
	dict := OrderedDictionary new.
	'abcdefghijklmnopqstuvwxyz' do: [ :c | dict at: (c asString) put: JamSliders new ].
	interface := JamSession new clear.
	interface addChildElement: (self new
			 name: 'Beautiful widget';
			 slidersDic: dict).
	interface open
]

{ #category : 'examples' }
JamWidgetElement class >> exampleWidgetWithOutputConnector [

	<example>
	| interface |
	interface := JamSession new clear.
	interface addChildElement: (self onlyWithOutputConnector name: 'Beautiful widget' ).
	interface open
]

{ #category : 'examples' }
JamWidgetElement class >> exampleWidgetWithSliders [

	<example>
	| interface |
	interface := JamSession new clear.
	interface addChildElement: (self new
			 name: 'Beautiful widget';
			 slidersDic: { ('Beauty' -> JamSliders new) } asDictionary).
	interface open.
]

{ #category : 'examples' }
JamWidgetElement class >> exampleWidgetWithTwoConnectors [

	<example>
	| interface |
	interface := JamSession new clear.
	interface addChildElement: (self new
			 name: 'Beautiful widget').
	interface open
]

{ #category : 'widgets list' }
JamWidgetElement class >> widgetsEffects [

	| effectsList effectsClass |
	effectsList := OrderedCollection new.
	effectsClass := ((PackageOrganizer default packageNamed:
		                  'PharoJamSession') tagNamed: 'Effect') classes.
	effectsClass do: [ :subClass |
		subClass hasSubclasses
			ifTrue: [ effectsList addAllFirstUnlessAlreadyPresent: subClass subclasses ]
			ifFalse: [
				(effectsList includes: subClass) ifFalse: [
					effectsList add: subClass ] ] ].
	^ self configureFor: effectsList
]

{ #category : 'widgets list' }
JamWidgetElement class >> widgetsInstruments [

	| instList instClasses |
	instList := OrderedCollection new.
	instClasses := ((PackageOrganizer default packageNamed:
		                 'PharoJamSession') tagNamed: 'Instrument') classes.
	instClasses do: [ :subClass |
		subClass hasSubclasses
			ifTrue: [ instList addAllFirstUnlessAlreadyPresent: subClass subclasses ]
			ifFalse: [
			(instList includes: subClass) ifFalse: [ instList add: subClass ] ] ].
	^ self configureFor: instList
]

{ #category : 'widgets list' }
JamWidgetElement class >> widgetsOscillator [

	| oscillators |
	oscillators := OrderedCollection new.
	Oscillator subclasses do: [ :subClass |
			subClass hasSubclasses ifTrue: [oscillators addAll: subClass subclasses] ifFalse: [ oscillators add: subClass ] ].
	^ self configureFor: oscillators
]

{ #category : 'widgets list' }
JamWidgetElement class >> widgetsSynths [

	| synthsList |
	synthsList := OrderedCollection new.
	Synths subclasses do: [ :subClass |
		subClass hasSubclasses
			ifTrue: [ synthsList addAll: subClass subclasses ]
			ifFalse: [ synthsList add: subClass ] ].
	^ self configureWithoutSoundFor: synthsList
]

{ #category : 'as yet unclassified' }
JamWidgetElement >> handleInputConnection [

self synthPatch add: #(1)
]

{ #category : 'as yet unclassified' }
JamWidgetElement >> handleInputConnection: aPatch [

self synthPatch addAllFirst: aPatch source
]

{ #category : 'initialization' }
JamWidgetElement >> initialize [ 

super initialize.
self initializeAnnouncers.
synthPatch := OrderedCollection new  .
]

{ #category : 'initialization' }
JamWidgetElement >> initializeAnnouncers [

^ self announcer
		when: ConnectionAnnouncer
		send: #handleInputConnection: 
		to: self.
]

{ #category : 'announcer connection' }
JamWidgetElement >> notifyConnection [

	self announcer announce: ConnectionAnnouncer new
]

{ #category : 'announcer connection' }
JamWidgetElement >> notifyConnectionWith: aSource [

	self announcer announce: (ConnectionAnnouncer new source: aSource)
]

{ #category : 'announcer connection' }
JamWidgetElement >> notifyDisconnection [

	self announcer announce: DisconnectionAnnouncer new
]

{ #category : 'accessing' }
JamWidgetElement >> synthPatch [

^ synthPatch 
]

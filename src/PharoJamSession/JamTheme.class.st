Class {
	#name : 'JamTheme',
	#superclass : 'ToRawTheme',
	#category : 'PharoJamSession-UIElementStyle',
	#package : 'PharoJamSession',
	#tag : 'UIElementStyle'
}

{ #category : 'accessing' }
JamTheme class >> defaultConnectorTokenProperties [

	^ {
		  (ToTokenProperty
			   name: #'input-connect-background'
			   value: Color lightGreen).
		  (ToTokenProperty
			   name: #'output-connect-background'
			   value: Color red).
		  }
]

{ #category : 'accessing' }
JamTheme class >> defaultJamSessionPlaygroundTokenProperties [

	^ { (ToTokenProperty
		   name: #'JSPlayground-background'
		   value: Color paleBuff ) }
]

{ #category : 'accessing' }
JamTheme class >> defaultLabelsTokenProperties [

	^ {
		  (ToTokenProperty name: #'labels-text-color' value: Color black).
		  (ToTokenProperty name: #'labels-text-size' value: 14) }
]

{ #category : 'accessing' }
JamTheme class >> defaultMenuTokenProperties [

	^ {
		  (ToTokenProperty
			   name: #'menuPane-background'
			   value: Color palePeach).
			(ToTokenProperty
			   name: #'menuPane-height'
			   value: 25).
		  (ToTokenProperty name: #'menu-interspace' value: 15) }
]

{ #category : 'accessing' }
JamTheme class >> defaultSlidersTokenProperties [

	^ {
		  (ToTokenProperty name: #'slider-background' value: Color pink).
		 (ToTokenProperty name: #'button-background' value: Color white).
		  }
]

{ #category : 'accessing' }
JamTheme class >> defaultTokenProperties [

	^ super defaultTokenProperties , self defaultWidgetsTokenProperties
	  , self defaultConnectorTokenProperties
	  , self defaultSlidersTokenProperties
	  , self defaultWidgetBarTokenProperties
	  , self defaultLabelsTokenProperties
	  , self defaultJamSessionPlaygroundTokenProperties,
	self defaultMenuTokenProperties.
]

{ #category : 'accessing' }
JamTheme class >> defaultWidgetBarTokenProperties [

	^ { (ToTokenProperty name: #'bar-background' value: Color palePeach). (ToTokenProperty name: #'bar-border' value: (BlBorder paint: Color black width: 1)) }
]

{ #category : 'accessing' }
JamTheme class >> defaultWidgetsTokenProperties [

	^ {
		  (ToTokenProperty
			   name: #'widget-icon-background'
			   value: Color white).
		  (ToTokenProperty
			   name: #'widget-background'
			   value: Color lightYellow) }
]

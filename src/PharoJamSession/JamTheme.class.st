"
I'm the default theme for the JamSession and each elements. I look like windows Xp
"
Class {
	#name : 'JamTheme',
	#superclass : 'ToRawTheme',
	#category : 'PharoJamSession-UIElementStyle',
	#package : 'PharoJamSession',
	#tag : 'UIElementStyle'
}

{ #category : 'accessing' }
JamTheme class >> defaultButtonTokenProperties [

	^ {
		  (ToTokenProperty name: #'button-width' value: 125).
		  (ToTokenProperty
			   name: #'button-padding'
			   value: (BlInsets left: 0 right: 25)).
		  (ToTokenProperty name: #'button-text-color' value: Color orange).
		  (ToTokenProperty name: #'button-text-size' value: 14) }
]

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

	^ {
		  (ToTokenProperty
			   name: #'JamSession-background'
			   value: Color paleBuff).
		  (ToTokenProperty
			   name: #'JamSession-background-url'
			   value:
			   '') }
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
			   value: (Color red alpha: 0.09)).
		  (ToTokenProperty name: #'menu-background' value: Color pink).
		  (ToTokenProperty name: #'menu-height' value: 40).
		  (ToTokenProperty
			   name: #'menu-border-color'
			   value: (Color red alpha: 0.05)).
		  (ToTokenProperty name: #'menu-border-width' value: 1).
		  (ToTokenProperty
			   name: #'subMenuContainer-background'
			   value: (Color pink alpha: 0.1)).
		  (ToTokenProperty
			   name: #'subMenuContainer-effect'
			   value: BlNullEffect new) }
]

{ #category : 'accessing' }
JamTheme class >> defaultSlidersContainerTokenProperties [

	^ {
		  (ToTokenProperty
			   name: #'slidersContainer-background'
			   value: Color transparent).
		  (ToTokenProperty
			   name: #'slidersContainer-border'
			   value: (BlBorder paint: Color transparent)).
		  (ToTokenProperty name: #'slidersContainer-cornerRadius' value: 0).
		  (ToTokenProperty
			   name: #'slidersContainer-effect'
			   value: BlNullEffect new).
		  ((ToTokenProperty name: #'slidersContainer-margin') value:
			   (BlInsets top: 25)) }
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
	  , self defaultJamSessionPlaygroundTokenProperties
	  , self defaultMenuTokenProperties
	  , self defaultSlidersContainerTokenProperties ,
	self defaultButtonTokenProperties
]

{ #category : 'accessing' }
JamTheme class >> defaultWidgetBarTokenProperties [

	^ {
		  (ToTokenProperty name: #'bar-background' value: Color palePeach).
		  (ToTokenProperty name: #'bar-isTop' value: true).
		  (ToTokenProperty name: #'bar-width' value: 300).
		  (ToTokenProperty name: #'bar-margin' value: (BlInsets all: 0)).
		  (ToTokenProperty name: #'bar-text-color' value: Color black).
		  (ToTokenProperty name: #'bar-text-size' value: 15).
		  (ToTokenProperty
			   name: #'bar-border'
			   value: (BlBorder paint: Color black width: 1)) }
]

{ #category : 'accessing' }
JamTheme class >> defaultWidgetsTokenProperties [

	^ {
		  (ToTokenProperty
			   name: #'widget-icon-background'
			   value: Color white).
		  (ToTokenProperty
			   name: #'widget-background'
			   value: Color lightYellow).
		  (ToTokenProperty name: #'widget-cornerRadius' value: 5).
		  (ToTokenProperty name: #'widget-effect' value: BlNullEffect new).
		(ToTokenProperty name:#'widget-draggableEverywhere' value: false). }
]

"
I'm another default theme for the JamSession and each elements. I'm a kind of minimalist graphics
"
Class {
	#name : 'JamSimpleTheme',
	#superclass : 'ToRawTheme',
	#category : 'PharoJamSession-UIElementStyle',
	#package : 'PharoJamSession',
	#tag : 'UIElementStyle'
}

{ #category : 'accessing' }
JamSimpleTheme class >> defaultButtonTokenProperties [

	^ {
		  (ToTokenProperty name: #'button-width' value: 50).
		  (ToTokenProperty
			   name: #'button-padding'
			   value: (BlInsets left: 0 right: 25)).
		  (ToTokenProperty name: #'button-text-color' value: Color purple).
		  (ToTokenProperty name: #'button-text-size' value: 16) }
]

{ #category : 'accessing' }
JamSimpleTheme class >> defaultConnectorTokenProperties [

	^ {
		  (ToTokenProperty
			   name: #'input-connect-background'
			   value: (Color fromHexString: '3b824b')).
		  (ToTokenProperty
			   name: #'output-connect-background'
			   value: (Color fromHexString: 'b8371a')) }
]

{ #category : 'accessing' }
JamSimpleTheme class >> defaultJamSessionPlaygroundTokenProperties [

	^ { (ToTokenProperty
		   name: #'JSPlayground-background'
		   value: (Color lightYellow alpha: 0.05)) }
]

{ #category : 'accessing' }
JamSimpleTheme class >> defaultLabelsTokenProperties [

	^ {
		  (ToTokenProperty name: #'labels-text-color' value: Color blue).
		  (ToTokenProperty name: #'labels-text-size' value: 16) }
]

{ #category : 'accessing' }
JamSimpleTheme class >> defaultMenuTokenProperties [

	^ {
		  (ToTokenProperty
			   name: #'menuPane-background'
			   value: (Color gray alpha: 0.09)).
		  (ToTokenProperty name: #'menu-background' value: Color white).
		  (ToTokenProperty name: #'menu-height' value: 50).
		  (ToTokenProperty
			   name: #'menu-border-color'
			   value: (Color gray alpha: 0.05)).
		  (ToTokenProperty name: #'menu-border-width' value: 3).
		  (ToTokenProperty
			   name: #'subMenuContainer-background'
			   value: (Color white alpha: 0.1)).
		  (ToTokenProperty
			   name: #'subMenuContainer-effect'
			   value: BlNullEffect new) }
]

{ #category : 'accessing' }
JamSimpleTheme class >> defaultSlidersContainerTokenProperties [

	^ {
		  (ToTokenProperty
			   name: #'slidersContainer-background'
			   value: Color transparent).
		  (ToTokenProperty
			   name: #'slidersContainer-border'
			   value: (BlBorder paint: Color veryLightGray width: 1)).
		  (ToTokenProperty name: #'slidersContainer-cornerRadius' value: 3).
		  (ToTokenProperty
			   name: #'slidersContainer-effect'
			   value: BlNullEffect new).
		  ((ToTokenProperty name: #'slidersContainer-margin') value:
			   (BlInsets top: 25 bottom: 40)) }
]

{ #category : 'accessing' }
JamSimpleTheme class >> defaultSlidersTokenProperties [

	^ {
		  (ToTokenProperty
			   name: #'slider-background'
			   value: (Color fromHexString: 'ffffdb')).
		  (ToTokenProperty name: #'button-background' value: Color white) }
]

{ #category : 'accessing' }
JamSimpleTheme class >> defaultTokenProperties [

	^ super defaultTokenProperties , self defaultWidgetsTokenProperties
	  , self defaultConnectorTokenProperties
	  , self defaultSlidersTokenProperties
	  , self defaultWidgetBarTokenProperties
	  , self defaultLabelsTokenProperties
	  , self defaultJamSessionPlaygroundTokenProperties
	  , self defaultMenuTokenProperties
	  , self defaultSlidersContainerTokenProperties
	  , self defaultButtonTokenProperties
]

{ #category : 'accessing' }
JamSimpleTheme class >> defaultWidgetBarTokenProperties [

	^ {
		  (ToTokenProperty name: #'bar-background' value: Color transparent).
		  (ToTokenProperty name: #'bar-isTop' value: false).
		  (ToTokenProperty name: #'bar-width' value: 300).
		  (ToTokenProperty name: #'bar-margin' value: (BlInsets top: 40 bottom: 5)).
		  (ToTokenProperty name: #'bar-text-color' value: Color brown).
		  (ToTokenProperty name: #'bar-text-size' value: 24).
		  (ToTokenProperty
			   name: #'bar-border'
			   value: (BlBorder paint: Color transparent)) }
]

{ #category : 'accessing' }
JamSimpleTheme class >> defaultWidgetsTokenProperties [

	^ {
		  (ToTokenProperty
			   name: #'widget-icon-background'
			   value: Color white).
		  (ToTokenProperty name: #'widget-background' value: Color white).
		  (ToTokenProperty name: #'widget-cornerRadius' value: 0).
		(ToTokenProperty name:#'widget-draggableEverywhere' value: true).
		  (ToTokenProperty
			   name: #'widget-effect'
			   value:
			   (BlGaussianShadowEffect
				    color: Color black
				    width: 3
				    offset: 5 @ 3)) }
]

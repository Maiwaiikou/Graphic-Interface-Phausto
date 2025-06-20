Class {
	#name : 'JamSimpleTheme',
	#superclass : 'ToRawTheme',
	#category : 'PharoJamSession-UIElementStyle',
	#package : 'PharoJamSession',
	#tag : 'UIElementStyle'
}

{ #category : 'accessing' }
JamSimpleTheme class >> defaultConnectorTokenProperties [

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
JamSimpleTheme class >> defaultJamSessionPlaygroundTokenProperties [

	^ { (ToTokenProperty
		   name: #'JSPlayground-background'
		   value: Color paleBuff ) }
]

{ #category : 'accessing' }
JamSimpleTheme class >> defaultLabelsTokenProperties [

	^ {
		  (ToTokenProperty name: #'labels-text-color' value: Color black).
		  (ToTokenProperty name: #'labels-text-size' value: 14) }
]

{ #category : 'accessing' }
JamSimpleTheme class >> defaultMenuTokenProperties [

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
		  (ToTokenProperty name: #'slider-background' value: (Color fromHexString: 'fff0db')).
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
	  , self defaultMenuTokenProperties,
	self defaultSlidersContainerTokenProperties
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

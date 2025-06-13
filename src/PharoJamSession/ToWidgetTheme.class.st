Class {
	#name : 'ToWidgetTheme',
	#superclass : 'ToRawTheme',
	#category : 'PharoJamSession-UIElementStyle',
	#package : 'PharoJamSession',
	#tag : 'UIElementStyle'
}

{ #category : 'accessing' }
ToWidgetTheme class >> defaultConnectorTokenProperties [

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
ToWidgetTheme class >> defaultLabelsTokenProperties [

	^ {
		  (ToTokenProperty name: #'labels-text-color' value: Color black).
		  (ToTokenProperty name: #'labels-text-size' value: 14) }
]

{ #category : 'accessing' }
ToWidgetTheme class >> defaultSlidersTokenProperties [

	^ {
		  (ToTokenProperty name: #'slider-background' value: Color pink).
		 (ToTokenProperty name: #'button-background' value: Color white).
		  }
]

{ #category : 'accessing' }
ToWidgetTheme class >> defaultTokenProperties [

	^ super defaultTokenProperties , self defaultWidgetsTokenProperties, self defaultConnectorTokenProperties, self defaultSlidersTokenProperties, self defaultWidgetBarTokenProperties, self defaultLabelsTokenProperties.
		  
		  
]

{ #category : 'accessing' }
ToWidgetTheme class >> defaultWidgetBarTokenProperties [

	^ {
		  (ToTokenProperty name: #'bar-background' value: Color palePeach).
		  }
]

{ #category : 'accessing' }
ToWidgetTheme class >> defaultWidgetsTokenProperties [

	^ {
		  (ToTokenProperty
			   name: #'widget-icon-background'
			   value: Color paleBuff).
		  (ToTokenProperty
			   name: #'widget-background'
			   value: Color lightYellow).
		  }
]

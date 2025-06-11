Class {
	#name : 'ToWidgetTheme',
	#superclass : 'ToRawTheme',
	#category : 'PharoJamSession-UIElementStyle',
	#package : 'PharoJamSession',
	#tag : 'UIElementStyle'
}

{ #category : 'accessing' }
ToWidgetTheme class >> defaultTokenProperties [

	^ super defaultTokenProperties , {
		  (ToTokenProperty
			   name: #'widget-icon-background'
			   value: Color paleBuff).
		  (ToTokenProperty
			   name: #'widget-background'
			   value: Color lightYellow).
		  (ToTokenProperty name: #'bar-background' value: Color palePeach).
		  (ToTokenProperty
			   name: #'input-connect-background'
			   value: Color lightGreen).
		  (ToTokenProperty
			   name: #'output-connect-background'
			   value: Color red).
		  (ToTokenProperty name: #'slider-background' value: Color pink).
		 (ToTokenProperty name: #'button-background' value: Color white).}
]

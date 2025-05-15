Class {
	#name : 'ToWidgetTheme',
	#superclass : 'ToRawTheme',
	#category : 'Phausto-Element-Style',
	#package : 'Phausto-Element',
	#tag : 'Style'
}

{ #category : 'accessing' }
ToWidgetTheme class >> defaultTokenProperties [

	^ super defaultTokenProperties , {
		  (ToTokenProperty name: #'widget-icon-background' value: Color paleBuff).
		  (ToTokenProperty
			   name: #'widget-background'
			   value: Color lightYellow).
		  (ToTokenProperty name: #'bar-background' value: Color palePeach) }
]

Class {
	#name : 'ToWidgetTheme',
	#superclass : 'ToRawTheme',
	#category : 'Phausto-Element-Style',
	#package : 'Phausto-Element',
	#tag : 'Style'
}

{ #category : 'accessing' }
ToWidgetTheme class >> defaultTokenProperties [
	^ super defaultTokenProperties , { (ToTokenProperty name:#'widget-border-color' value: Color black). (ToTokenProperty name:#'widget-background' value: Color lightYellow).}
]

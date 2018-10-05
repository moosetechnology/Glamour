Class {
	#name : #JQSGLValidator,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
JQSGLValidator >> buttonsHeight: anInteger [

	self optionAt: 'buttonsHeight' put: anInteger 
]

{ #category : #accessing }
JQSGLValidator >> method [ 
	^ 'sglValidator'
]

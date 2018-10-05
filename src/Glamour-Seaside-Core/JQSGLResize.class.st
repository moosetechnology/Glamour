Class {
	#name : #JQSGLResize,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
JQSGLResize >> method [
	^ 'sglResize'
]

{ #category : #'options-generated' }
JQSGLResize >> paneASpan: anInteger [
	self optionAt: 'paneASpan' put: anInteger 
]

{ #category : #'options-generated' }
JQSGLResize >> remainingSpan: anInteger [
	self optionAt: 'paneBSpan' put: anInteger 
]

{ #category : #'options-generated' }
JQSGLResize >> splitHorizontal [
	self optionAt: 'splitHorizontal' put: true 
]

{ #category : #'options-generated' }
JQSGLResize >> splitVertical [
	self optionAt: 'splitVertical' put: true 
]

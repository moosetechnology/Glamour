Class {
	#name : #JQSGLText,
	#superclass : #JQTabs,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
JQSGLText >> method [
	^ 'glamourText'
]

{ #category : #'events-generated' }
JQSGLText >> onChange: anObject [
	self optionAt: 'change' put: anObject asFunction
]

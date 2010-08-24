Class {
	#name : #JQSGLText,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #actions }
JQSGLText >> changeText: aString [
	self action: 'changeText' arguments: (Array with: aString)
]

{ #category : #accessing }
JQSGLText >> method [
	^ 'glamourText'
]

{ #category : #'events-generated' }
JQSGLText >> onChange: anObject [
	self optionAt: 'change' put: anObject asFunction
]

{ #category : #'events-generated' }
JQSGLText >> onSelect: anObject [
	self optionAt: 'select' put: anObject asFunction
]

{ #category : #actions }
JQSGLText >> selectFrom: start to: end [
	self action: 'changeSelection' arguments: (Array with: start with: end)
]

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
	self action: 'changeSelectionInterval' arguments: (Array with: start with: end)
]

{ #category : #actions }
JQSGLText >> selectText: aString [
	self action: 'changeSelectedText' arguments: (Array with: aString)
]

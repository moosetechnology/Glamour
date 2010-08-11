Class {
	#name : #JQSGLTabs,
	#superclass : #JQTabs,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #actions }
JQSGLTabs >> add: aUrl label: aString actions: htmlContent [	
	self action: 'add' arguments: (Array with: aUrl with: aString).
	self optionAt: 'actionsContent' put: htmlContent
	
]

{ #category : #'options-generated' }
JQSGLTabs >> closable: aBoolean [
	self optionAt: 'closable' put: aBoolean
]

{ #category : #'options-generated' }
JQSGLTabs >> hasActions: aBoolean [
	self optionAt: 'hasActions' put: aBoolean
]

{ #category : #accessing }
JQSGLTabs >> method [
	^ 'glamourTabs'
]

{ #category : #'events-generated' }
JQSGLTabs >> onRemove: anObject [
	"Bind this event with the 'delete' action as 'remove' does not properly work in JQueru-UI 1.8.2 "

	self optionAt: 'glmDelete' put: anObject asFunction
]

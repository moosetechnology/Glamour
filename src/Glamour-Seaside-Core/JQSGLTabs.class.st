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
JQSGLTabs >> hasActions: aBoolean [
	self optionAt: 'hasActions' put: aBoolean
]

{ #category : #accessing }
JQSGLTabs >> method [
	^ 'glamourTabs'
]

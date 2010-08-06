Class {
	#name : #JQSGLTree,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #actions }
JQSGLTree >> init [
	self action: 'initialize'
]

{ #category : #'options-generated' }
JQSGLTree >> isMultiple: aBoolean [
	self optionAt: 'isMultiple' put: aBoolean
]

{ #category : #'options-generated' }
JQSGLTree >> level: anInteger [
	self optionAt: 'level' put: anInteger
]

{ #category : #accessing }
JQSGLTree >> method [
	^ 'glamourTree'
]

{ #category : #'events-generated' }
JQSGLTree >> onExpandToggled: anObject [
	self optionAt: 'onExpandToggled' put: (anObject asFunction: #('$node'))
]

{ #category : #'events-generated' }
JQSGLTree >> onSelect: anObject [
	self optionAt: 'onSelect' put:  (anObject asFunction: #('$anIdOrAList'))
]

{ #category : #'options-generated' }
JQSGLTree >> selectedNodes: anArray [
	self optionAt: 'selectedNodes' put: anArray
]

{ #category : #actions }
JQSGLTree >> update [
	self action: 'update'
]

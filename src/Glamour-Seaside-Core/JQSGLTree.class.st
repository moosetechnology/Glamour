Class {
	#name : #JQSGLTree,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #'as yet unclassified' }
JQSGLTree >> init [
	self action: 'initialize'
]

{ #category : #'as yet unclassified' }
JQSGLTree >> isMultiple: aBoolean [
	self optionAt: 'isMultiple' put: aBoolean
]

{ #category : #'as yet unclassified' }
JQSGLTree >> level: anInteger [
	self optionAt: 'level' put: anInteger
]

{ #category : #'as yet unclassified' }
JQSGLTree >> method [
	^ 'glamourTree'
]

{ #category : #'as yet unclassified' }
JQSGLTree >> onExpandToggled: anObject [
	self optionAt: 'onExpandToggled' put: (anObject asFunction: #('$node'))
]

{ #category : #'as yet unclassified' }
JQSGLTree >> onSelect: anObject [
	self optionAt: 'onSelect' put:  (anObject asFunction: #('$anIdOrAList'))
]

{ #category : #'as yet unclassified' }
JQSGLTree >> update [
	self action: 'update'
]

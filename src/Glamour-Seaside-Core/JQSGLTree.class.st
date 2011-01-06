Class {
	#name : #JQSGLTree,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #actions }
JQSGLTree >> appendRoots: aRenderable [
	self action: 'appendRoots' arguments: (Array with: (self render: aRenderable) )
]

{ #category : #'options-generated' }
JQSGLTree >> appendRootsURL: aString [
	self optionAt: 'appendRootsURL' put: aString
]

{ #category : #actions }
JQSGLTree >> appendSubtree: aRenderable to: node [
	self action: 'appendSubtree' arguments: (Array with: node with: (self render: aRenderable) )
]

{ #category : #'options-generated' }
JQSGLTree >> appendURL: aString [
	self optionAt: 'appendURL' put: aString
]

{ #category : #'options-generated' }
JQSGLTree >> isMultiple: aBoolean [
	self optionAt: 'allowMultipleSelection' put: aBoolean
]

{ #category : #'options-generated' }
JQSGLTree >> maximumSize: anInteger [
	self optionAt: 'maximumSize' put: anInteger
]

{ #category : #accessing }
JQSGLTree >> method [
	^ 'sglTree'
]

{ #category : #'events-generated' }
JQSGLTree >> onSelect: anObject [
	self optionAt: 'onSelect' put:  (anObject asFunction: #('$anIdOrAList'))
]

{ #category : #'events-generated' }
JQSGLTree >> onToggleExpand: anObject [
	self optionAt: 'toggleExpand' put: (anObject asFunction)
]

{ #category : #private }
JQSGLTree >> plugin: aPluginClass [
	| pluginName |
	pluginName := aPluginClass pluginName.
	^self options
		at: pluginName
		ifAbsentPut:
			[(self options
				at: 'plugins'
				ifAbsentPut: [OrderedCollection new]) add: pluginName.
			aPluginClass new]
]

{ #category : #'options-generated' }
JQSGLTree >> selectURL: aString [
	self optionAt: 'selectURL' put: aString
]

{ #category : #'options-generated' }
JQSGLTree >> selectedNodes: anArray [
	self optionAt: 'selectedNodes' put: anArray
]

{ #category : #'options-generated' }
JQSGLTree >> stepSize: anInteger [
	self optionAt: 'stepSize' put: anInteger
]

{ #category : #actions }
JQSGLTree >> toggleExpand: node andTriggerEventIf: shouldTriggerEvent [
	self action: 'toggleExpand' arguments: (Array with: node with: shouldTriggerEvent)
]

{ #category : #plugins }
JQSGLTree >> useAppend [
	^ self plugin: JQSGLTreeAppend 
]

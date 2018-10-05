Class {
	#name : #JQSGLTreeAppend,
	#superclass : #JQSGLTreePlugin,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
JQSGLTreeAppend class >> pluginName [
	^'append'
]

{ #category : #'options-generated' }
JQSGLTreeAppend >> appendRootsURL: aString [
	self optionAt: 'appendRootsURL' put: aString
]

{ #category : #'options-generated' }
JQSGLTreeAppend >> maximumSize: anInteger [
	self optionAt: 'maximumSize' put: anInteger
]

{ #category : #'options-generated' }
JQSGLTreeAppend >> stepSize: anInteger [
	self optionAt: 'stepSize' put: anInteger
]

Class {
	#name : #JQTypeWatch,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #'options-generated' }
JQTypeWatch >> callback: anObject [
	self optionAt: 'callback' put: anObject asFunction
]

{ #category : #'options-generated' }
JQTypeWatch >> captureEnter: aBoolean [
	self optionAt: 'captureEnter' put: aBoolean
]

{ #category : #'options-generated' }
JQTypeWatch >> captureLength: anInteger [
	self optionAt: 'captureLength' put: anInteger
]

{ #category : #'options-generated' }
JQTypeWatch >> highlight: aBoolean [
	self optionAt: 'highlight' put: aBoolean
]

{ #category : #accessing }
JQTypeWatch >> method [
	^ 'typeWatch'
]

{ #category : #'options-generated' }
JQTypeWatch >> wait: anInteger [
	self optionAt: 'wait' put: anInteger
]

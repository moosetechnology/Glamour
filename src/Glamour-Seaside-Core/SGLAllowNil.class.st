Class {
	#name : #SGLAllowNil,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLAllowNil class >> initialize [
	self registerAsApplication: 'glamour/basicExamples/allowNill'
]

{ #category : #'as yet unclassified' }
SGLAllowNil >> browser [
	^GLMBasicExamples new allowNil 
]

{ #category : #'as yet unclassified' }
SGLAllowNil >> model [
	^ 42
]

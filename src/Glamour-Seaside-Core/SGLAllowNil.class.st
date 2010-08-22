Class {
	#name : #SGLAllowNil,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLAllowNil class >> initialize [
	self registerAsApplication: 'glamour/basicExamples/allowNill'
]

{ #category : #accessing }
SGLAllowNil >> browser [
	"self new browser openOn: self new model"
	
	^ GLMBasicExamples new allowNil.
]

{ #category : #accessing }
SGLAllowNil >> model [
	^ 42
]

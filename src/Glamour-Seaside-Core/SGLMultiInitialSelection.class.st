Class {
	#name : #SGLMultiInitialSelection,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLMultiInitialSelection class >> initialize [
	self registerAsApplication: 'glamour/basicExamples/multiInitialSelection'
]

{ #category : #accessing }
SGLMultiInitialSelection >> browser [
	^ GLMBasicExamples new multiInitialSelection.
]

{ #category : #accessing }
SGLMultiInitialSelection >> model [
	^ 5
]

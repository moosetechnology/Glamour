Class {
	#name : #SGLGlamourBasicExamples,
	#superclass : #SGLExamples,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLGlamourBasicExamples class >> initialize [
	self registerAsApplication: 'glamour/glamourBasicExamples'
]

{ #category : #accessing }
SGLGlamourBasicExamples >> browserFromPragma: pragma [
	^ GLMBasicExamples new perform: pragma selector
]

{ #category : #accessing }
SGLGlamourBasicExamples >> model [
	^ GLMBasicExamples allExamples 
]

{ #category : #accessing }
SGLGlamourBasicExamples >> sourceFromPragma: pragma [
	^ GLMBasicExamples sourceCodeAt: pragma selector
]

{ #category : #accessing }
SGLGlamourBasicExamples >> title [
	^ 'Glamour Basic examples'
]

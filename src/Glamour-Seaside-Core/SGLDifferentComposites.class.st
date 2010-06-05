Class {
	#name : #SGLDifferentComposites,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLDifferentComposites class >> initialize [
	self registerAsApplication: 'glamour/basicExamples/differentComposites'
]

{ #category : #'as yet unclassified' }
SGLDifferentComposites >> browser [
	^GLMBasicExamples new differentComposites
]

{ #category : #'as yet unclassified' }
SGLDifferentComposites >> model [
	^ (1 to: 100)
]

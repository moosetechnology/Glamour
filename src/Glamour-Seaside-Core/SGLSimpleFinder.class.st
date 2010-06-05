Class {
	#name : #SGLSimpleFinder,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLSimpleFinder class >> initialize [
	self registerAsApplication: 'glamour/basicExamples/simpleFinder'
]

{ #category : #'as yet unclassified' }
SGLSimpleFinder >> browser [
	| finder |
	finder := GLMFinder new.
	finder title: 'Finder'.
	finder show: [ :a |
		a list 
			display: [:x | 1 to: x] ].
		
	^finder.
]

{ #category : #'as yet unclassified' }
SGLSimpleFinder >> model [
	^100
]

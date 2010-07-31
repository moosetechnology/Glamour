Class {
	#name : #SGLSimpleFinder,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLSimpleFinder class >> initialize [
	self registerAsApplication: 'glamour/finder/simpleFinder'
]

{ #category : #accessing }
SGLSimpleFinder >> browser [
	| finder |
	finder := GLMFinder new.
	finder title: 'Finder'.
	finder show: [ :a |
		a list 
			display: [:x | 1 to: x] ].
		
	^finder.
]

{ #category : #accessing }
SGLSimpleFinder >> model [
	^100
]

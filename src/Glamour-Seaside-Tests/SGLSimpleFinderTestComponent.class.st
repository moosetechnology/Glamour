Class {
	#name : #SGLSimpleFinderTestComponent,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #accessing }
SGLSimpleFinderTestComponent >> browser [
	| finder |
	finder := GLMFinder new.
	finder show: [ :a |
		a list 
			display: [:x | 1 to: x] ].
		
	^finder.
]

{ #category : #accessing }
SGLSimpleFinderTestComponent >> model [
	^ 100
]

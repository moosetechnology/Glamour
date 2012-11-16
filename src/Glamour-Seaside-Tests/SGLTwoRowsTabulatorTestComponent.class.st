Class {
	#name : #SGLTwoRowsTabulatorTestComponent,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #accessing }
SGLTwoRowsTabulatorTestComponent >> browser [
	| browser |
	browser := GLMTabulator new.

	browser row: #first; row: #second.

	^browser.
]

{ #category : #accessing }
SGLTwoRowsTabulatorTestComponent >> model [
	^ nil
]

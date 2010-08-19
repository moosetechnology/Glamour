Class {
	#name : #SGLListsWithUpdatedSelection,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLListsWithUpdatedSelection class >> initialize [
	self registerAsApplication: 'glamour/basicExamples/listWithUpdateSelection'
]

{ #category : #accessing }
SGLListsWithUpdatedSelection >> browser [
	"self new browser openOn: self new model"
	
	^ GLMBasicExamples new listsWithUpdatedSelection
]

{ #category : #accessing }
SGLListsWithUpdatedSelection >> model [
	^ 10
]

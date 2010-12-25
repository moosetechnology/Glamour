Class {
	#name : #SGLMooseFinder,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLMooseFinder class >> initialize [
	self registerAsApplication: 'moose/finder'
]

{ #category : #accessing }
SGLMooseFinder >> browser [
	"self new browser openOn: self new model"

	^ MooseFinder new buildBrowser
]

{ #category : #accessing }
SGLMooseFinder >> model [
	^ MooseModel root allModels first.
]

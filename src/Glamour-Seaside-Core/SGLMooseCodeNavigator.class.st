Class {
	#name : #SGLMooseCodeNavigator,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLMooseCodeNavigator class >> initialize [
	self registerAsApplication: 'glamour/moose/codeNavigator'
]

{ #category : #accessing }
SGLMooseCodeNavigator >> browser [
	"self new browser openOn: self new model"

	^ MooseBrowsers new codeNavigator
]

{ #category : #accessing }
SGLMooseCodeNavigator >> model [
	^ MooseModel root allModels first.
]

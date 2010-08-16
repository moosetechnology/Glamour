Class {
	#name : #SGLMooseCodeBrowser,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLMooseCodeBrowser class >> initialize [
	self registerAsApplication: 'glamour/moose/codeBrowser'
]

{ #category : #accessing }
SGLMooseCodeBrowser >> browser [
	"self new browser openOn: self new model"

	^ MooseBrowsers new codeBrowser
]

{ #category : #accessing }
SGLMooseCodeBrowser >> model [
	^ MooseModel root allModels first.
]

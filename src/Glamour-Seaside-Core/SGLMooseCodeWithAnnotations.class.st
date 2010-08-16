Class {
	#name : #SGLMooseCodeWithAnnotations,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLMooseCodeWithAnnotations class >> initialize [
	self registerAsApplication: 'glamour/moose/codeWithAnnotations'
]

{ #category : #accessing }
SGLMooseCodeWithAnnotations >> browser [
	"self new browser openOn: self new model"

	^ MooseBrowsers new codeWithAnnotationsBrowser

]

{ #category : #accessing }
SGLMooseCodeWithAnnotations >> model [
	^ MooseModel root allModels first.
]

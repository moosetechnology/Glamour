Class {
	#name : #SGLMooseMetaBrowser,
	#superclass : #SGLComponent,
	#instVars : [
		'mooseMetaBrowser'
	],
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #'as yet unclassified' }
SGLMooseMetaBrowser class >> initialize [
	self registerAsApplication: 'glamour/moose/metaBrowser'
]

{ #category : #accessing }
SGLMooseMetaBrowser >> browser [
	"self new browser openOn: self new model."

	^ mooseMetaBrowser buildBrowser
]

{ #category : #initialization }
SGLMooseMetaBrowser >> initialize [ 
	super initialize.
	mooseMetaBrowser := MooseMetaBrowser new
]

{ #category : #accessing }
SGLMooseMetaBrowser >> model [
	|aFMMetaRepository|
	aFMMetaRepository := MooseModel meta.
	mooseMetaBrowser computeChildrenHierarchy:  aFMMetaRepository.
	^ aFMMetaRepository
]

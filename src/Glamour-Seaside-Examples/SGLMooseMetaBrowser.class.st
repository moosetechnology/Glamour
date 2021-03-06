Class {
	#name : #SGLMooseMetaBrowser,
	#superclass : #SGLComponent,
	#instVars : [
		'mooseMetaBrowser'
	],
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #'instance creation' }
SGLMooseMetaBrowser class >> initialize [
	self registerAsApplication: 'moose/metaBrowser'
]

{ #category : #accessing }
SGLMooseMetaBrowser >> browser [
	"
	|component|
	component := self new.
	component browser openOn: component model.
	"

	^ mooseMetaBrowser buildBrowser
]

{ #category : #initialization }
SGLMooseMetaBrowser >> initialize [ 
	super initialize.
	mooseMetaBrowser := MooseMetaBrowser  new
]

{ #category : #accessing }
SGLMooseMetaBrowser >> model [
	|aFMMetaRepository|
	aFMMetaRepository := MooseModel meta.
	"mooseMetaBrowser computeChildrenHierarchy:  aFMMetaRepository."
	^ aFMMetaRepository
]

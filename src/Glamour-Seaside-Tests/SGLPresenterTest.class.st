Class {
	#name : #SGLPresenterTest,
	#superclass : #STTestCase,
	#instVars : [
		'presentation',
		'presenter',
		'app',
		'previousDeprecationWarning'
	],
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #setup }
SGLPresenterTest >> buildPresentation [
	self subclassResponsibility
]

{ #category : #setup }
SGLPresenterTest >> presenterClass [
	self subclassResponsibility
]

{ #category : #setup }
SGLPresenterTest >> setUp [
	super setUp.
	previousDeprecationWarning := Deprecation raiseWarning.
	Deprecation raiseWarning: false.
	
	presentation := self buildPresentation.
	app := self newApplicationWithRootClass: SGLPresenterWrapper initializeWith: [ : wrapper |
		wrapper initializeFor: presentation with: self presenterClass.
		presenter := wrapper presenter].
	SGLComponent applyPreferencesOn: app.
]

{ #category : #setup }
SGLPresenterTest >> tearDown [
	Deprecation raiseWarning: previousDeprecationWarning
]

Class {
	#name : #GLMMondrianPresentationTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #'as yet unclassified' }
GLMMondrianPresentationTest >> testPaintingTakesPresentation [
	| presentation viewRenderer  viewParameter mondrianParameter |
	presentation := GLMMondrianPresentation new.
	viewRenderer := MOViewRenderer new.
	presentation painting: [:view :entity :mondrian | viewParameter := view. mondrianParameter := mondrian ].
	presentation renderOn: viewRenderer.
	self assert: mondrianParameter notNil.
	self assert: mondrianParameter == presentation.
	self assert: viewParameter notNil.
	self assert: viewParameter == viewRenderer.
]

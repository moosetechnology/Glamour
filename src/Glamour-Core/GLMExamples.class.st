Class {
	#name : #GLMExamples,
	#superclass : #Object,
	#category : #'Glamour-Core'
}

{ #category : #'as yet unclassified' }
GLMExamples >> example1 [

	"self new example1"
	
	^ GLMBrowser new
			finder;
			for: [:each | each isCollection ] show: [:each | each ] using: (GLMListRenderer new);
			openOn: #(1 2 3 (11 12 13 (21 22 23 24)))
]

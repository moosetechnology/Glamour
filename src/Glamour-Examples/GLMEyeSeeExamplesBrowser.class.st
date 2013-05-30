"
self new openOn: ESExamples
"
Class {
	#name : #GLMEyeSeeExamplesBrowser,
	#superclass : #GLMParameterizableExamplesBrowser,
	#category : #'Glamour-Examples'
}

{ #category : #'instance creation' }
GLMEyeSeeExamplesBrowser class >> open [ 
	^ self new openOn: ESExamples
]

{ #category : #hooks }
GLMEyeSeeExamplesBrowser >> exampleSelectorsFromClass: exampleClass [
	^ exampleClass selectors select: [ :each | each endsWith: 'With:' ]
]

{ #category : #building }
GLMEyeSeeExamplesBrowser >> installTitle [
	browser title: 'EyeSee Examples'
]

{ #category : #hooks }
GLMEyeSeeExamplesBrowser >> renderedExampleIn: composer [
	composer eyesee
		title: 'Example';
		diagram: [ :renderer :exampleClass :exampleSelector | exampleClass new perform: exampleSelector with: renderer ]
]

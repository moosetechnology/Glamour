"
self new openOn: ROMondrianExample
"
Class {
	#name : #GLMRoassalExamplesBrowser,
	#superclass : #GLMParameterizableExamplesBrowser,
	#category : #'Glamour-Examples'
}

{ #category : #'instance creation' }
GLMRoassalExamplesBrowser class >> open [ 
	^ self new openOn: ROMondrianExample
]

{ #category : #hooks }
GLMRoassalExamplesBrowser >> exampleSelectorsFromClass: exampleClass [
	^ exampleClass selectors select: [ :each | each endsWith: 'On:' ]
]

{ #category : #building }
GLMRoassalExamplesBrowser >> installTitle [
	browser title: 'Roassal Examples'
]

{ #category : #hooks }
GLMRoassalExamplesBrowser >> renderedExampleIn: composer [
	composer roassal
		title: 'Example';
		painting: [ :view :exampleClass :exampleSelector | exampleClass new perform: exampleSelector with: view ]
]

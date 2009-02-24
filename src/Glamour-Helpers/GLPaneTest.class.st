Class {
	#name : #GLPaneTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLPaneTest >> testPorts [
	
	| pane port |
	pane := GLPane new.
	self assert: pane ports isEmpty.
	port := pane port: #foo.
	self assert: pane ports size = 1.
	self assert: pane ports first == port.
	self assert: (pane port: #foo) == port
]

{ #category : #tests }
GLPaneTest >> testPresentationConditions [
	
	| pane presentation1 presentation2 presentation3 |
	pane := GLPane new.
	presentation1 := GLPresentation new
		condition: [:first :second | first = 1 and: [second = 2]].
	presentation2 := GLPresentation new condition: [:first | first = #foo].
	presentation3 := GLPresentation new.
	pane addPresentation: presentation1.
	pane addPresentation: presentation2.
	pane addPresentation: presentation3.
	(pane port: #entity) value: (GLMultiValue withAll: #(1 2)).
	self assert: pane matchingPresentations size = 2.
	self assert: pane matchingPresentations first == presentation1.
	self assert: pane matchingPresentations last == presentation3.
	(pane port: #entity) value: (GLMultiValue withAll: #(#foo 2)).
	self assert: pane matchingPresentations size = 2.
	self assert: pane matchingPresentations first == presentation2.
	self assert: pane matchingPresentations last == presentation3.
	(pane port: #entity) value: (GLMultiValue withAll: #(nil 2)).
	self assert: pane matchingPresentations size = 0
]

{ #category : #tests }
GLPaneTest >> testPresentations [
	
	| pane presentation announcement |
	pane := GLPane new.
	presentation := GLPresentation new.
	self assert: pane presentations isEmpty.
	announcement := nil.
	pane whenPresentationsChanged: [:ann | announcement := ann].
	pane addPresentation: presentation.
	self assert: pane presentations size = 1.
	self assert: pane presentations first == presentation.
	self assert: presentation pane == pane.
	self assert: announcement notNil
]

{ #category : #tests }
GLPaneTest >> testSimplePresentations [
	
	| pane presentation announcement |
	pane := GLPane new.
	presentation := GLPresentation new.
	self assert: pane presentations isEmpty.
	announcement := nil.
	pane whenPresentationsChanged: [:ann | announcement := ann].
	pane addPresentation: presentation.
	self assert: pane presentations size = 1.
	self assert: pane presentations first == presentation.
	self assert: presentation pane == pane.
	self assert: announcement notNil
]

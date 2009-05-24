Class {
	#name : #GLMPaneTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLMPaneTest >> testPorts [ 
	 
	| pane port | 
	pane := GLMPane new. 
	self assert: pane ports isEmpty. 
	port := pane port: #foo. 
	self assert: pane ports size = 1. 
	self assert: pane ports first == port. 
	self assert: (pane port: #foo) == port
]

{ #category : #tests }
GLMPaneTest >> testPresentationConditions [ 
	 
	| pane presentation1 presentation2 presentation3 | 
	pane := GLMPane new. 
	presentation1 := GLMPresentation new 
		condition: [:first :second | first = 1 and: [second = 2]]. 
	presentation2 := GLMPresentation new condition: [:first | first = #foo]. 
	presentation3 := GLMPresentation new. 
	pane addPresentation: presentation1. 
	pane addPresentation: presentation2. 
	pane addPresentation: presentation3. 
	(pane port: #entity) value: (GLMMultiValue withAll: #(1 2)). 
	self assert: pane matchingPresentations size = 2. 
	self assert: pane matchingPresentations first == presentation1. 
	self assert: pane matchingPresentations last == presentation3. 
	(pane port: #entity) value: (GLMMultiValue withAll: #(#foo 2)). 
	self assert: pane matchingPresentations size = 2. 
	self assert: pane matchingPresentations first == presentation2. 
	self assert: pane matchingPresentations last == presentation3. 
	(pane port: #entity) value: (GLMMultiValue withAll: #(nil 2)). 
	self assert: pane matchingPresentations size = 1
]

{ #category : #tests }
GLMPaneTest >> testPresentations [ 
	 
	| pane presentation announcement | 
	pane := GLMPane new. 
	presentation := GLMPresentation new. 
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
GLMPaneTest >> testSimplePresentations [ 
	 
	| pane presentation announcement | 
	pane := GLMPane new. 
	presentation := GLMPresentation new. 
	self assert: pane presentations isEmpty. 
	announcement := nil. 
	pane whenPresentationsChanged: [:ann | announcement := ann]. 
	pane addPresentation: presentation. 
	self assert: pane presentations size = 1. 
	self assert: pane presentations first == presentation. 
	self assert: presentation pane == pane. 
	self assert: announcement notNil
]

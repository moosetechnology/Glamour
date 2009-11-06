Class {
	#name : #GLMPaneTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLMPaneTest >> testCreation [
	 
	| aPane | 
	aPane := GLMPane named: 1 in: 2. 
	self assert: aPane name = 1.
	self assert: aPane browser = 2.
]

{ #category : #tests }
GLMPaneTest >> testDefaultValidate [
	 
	| pane port | 
	pane := GLMPane named: 'test'. 
	self assert: ((pane port: #selection) validate: 5)

]

{ #category : #tests }
GLMPaneTest >> testIn [
	 
	| aPane | 
	aPane := GLMPane in: 1.
	self assert: aPane name = aPane defaultName.
	self assert: aPane browser = 1.
	self assert: aPane ports isEmpty.
	self assert: aPane presentations isEmpty.
]

{ #category : #tests }
GLMPaneTest >> testNamed [
	 
	| aPane | 
	aPane := GLMPane named: 1.
	self assert: aPane name = 1.
	self assert: aPane browser = GLMNoBrowser new.
	self assert: aPane ports isEmpty.
	self assert: aPane presentations isEmpty.
]

{ #category : #tests }
GLMPaneTest >> testNamedIn [
	 
	| aPane | 
	aPane := GLMPane named: 1 in: 2. 
	self assert: aPane name = 1.
	self assert: aPane browser = 2.
	self assert: aPane ports isEmpty.
	self assert: aPane presentations isEmpty.
]

{ #category : #tests }
GLMPaneTest >> testPorts [ 
	 
	| pane port | 
	pane := GLMPane named: 'test'. 
	self assert: pane ports isEmpty. 
	port := pane port: #foo. 
	self assert: pane ports size = 1. 
	self assert: pane ports first == port. 
	self assert: (pane port: #foo) == port
]

{ #category : #tests }
GLMPaneTest >> testPortsInmmutability [
	 
	| aPane ports | 
	aPane := GLMPane in: 1.
	self assert: aPane ports isEmpty.
	ports := aPane ports.
	ports add: 1.
	self assert: ports size = 1.
	self assert: aPane ports isEmpty.
]

{ #category : #tests }
GLMPaneTest >> testPresentationConditions [ 
	 
	| pane presentation1 presentation2 presentation3 | 
	pane := GLMPane named: 'test'. 
	presentation1 := GLMPresentation new condition: [:first :second | first = 1 and: [second = 2]]. 
	presentation2 := GLMPresentation new condition: [:first | first = #foo]. 
	presentation3 := GLMPresentation new useExplicitNotNil. 
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
	pane := GLMPane named: 'test'. 
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
GLMPaneTest >> testPresentationsInmmutability [
	 
	| aPane presentations | 
	aPane := GLMPane in: 1.
	self assert: aPane presentations isEmpty.
	presentations := aPane presentations.
	presentations add: 1.
	self assert: presentations size = 1.
	self assert: aPane presentations isEmpty.
]

{ #category : #tests }
GLMPaneTest >> testSimplePresentations [ 
	 
	| pane presentation announcement | 
	pane := GLMPane named: 'test'. 
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
GLMPaneTest >> testValidate [
	 
	| pane port presentation| 
	pane := GLMPane named: 'test'. 
	presentation := GLMListPresentation new.
	pane addPresentation: presentation.
	presentation entity: (OrderedCollection with: 1 with: 2).
	self assert: ((pane port: #selection) validate: 1).
	self assert: ((pane port: #selection) validate: 2).
	self deny: ((pane port: #selection) validate: 5)

]

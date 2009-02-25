Class {
	#name : #GLMPresentationTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLMPresentationTest >> testAnnouncement [ 
	 
	| pane presentation announcement | 
	pane := GLMPane new. 
	presentation := GLMPresentation new. 
	pane addPresentation: presentation. 
	announcement := nil. 
	presentation 
		when: GLMContextChanged 
		do: [:ann | announcement := ann]. 
	(pane port: #entity) value: 42. 
	self assert: announcement notNil. 
	self assert: announcement property = #entity. 
	self assert: announcement value = 42
]

{ #category : #tests }
GLMPresentationTest >> testContext [ 
	 
	| pane presentation | 
	pane := GLMPane new. 
	presentation := GLMPresentation new. 
	pane addPresentation: presentation. 
	presentation selection: 42. 
	self assert: (pane port: #selection) value = 42. 
	(pane port: #entity) value: 'foo'. 
	self assert: presentation entity = 'foo'
]

{ #category : #tests }
GLMPresentationTest >> testDisplay [ 
	 
	| presentation | 
	presentation := GLMPresentation new. 
	presentation entity: #foo. 
	self assert: presentation displayValue = #foo. 
	presentation entity: #(#foo #bar). 
	self assert: presentation displayValue = #(#foo #bar). 
	presentation entity: (GLMMultiValue withAll: #(#foo #bar)). 
	self assert: presentation displayValue = #foo. 
	presentation transformation: [:first :second | (first , second) asSymbol]. 
	self assert: presentation displayValue = #foobar
]

{ #category : #tests }
GLMPresentationTest >> testMatching [ 
	 
	| presentation | 
	presentation := GLMPresentation new. 
	self assert: presentation usesImplicitNotNil. 
	(presentation pane port: #entity) value: nil. 
	self assert: presentation matches not. 
	(presentation pane port: #entity) value: 1. 
	self assert: presentation matches. 
	presentation useExplicitNotNil. 
	self assert: presentation usesImplicitNotNil not. 
	(presentation pane port: #entity) value: nil. 
	self assert: presentation matches. 
	(presentation pane port: #entity) value: 1. 
	self assert: presentation matches. 
	presentation condition: [:x | x > 1]. 
	presentation useImplicitNotNil. 
	self assert: presentation usesImplicitNotNil. 
	(presentation pane port: #entity) value: nil. 
	self assert: presentation matches not. 
	(presentation pane port: #entity) value: 1. 
	self assert: presentation matches not. 
	(presentation pane port: #entity) value: 2. 
	self assert: presentation matches. 
	presentation useExplicitNotNil. 
	(presentation pane port: #entity) value: 1. 
	self assert: presentation matches not. 
	(presentation pane port: #entity) value: 2. 
	self assert: presentation matches. 
	self assert: presentation usesImplicitNotNil not. 
	[(presentation pane port: #entity) value: nil. 
	presentation matches. 
	self signalFailure: 'Should have raised error'] 
		on: MessageNotUnderstood 
		do: 
			[:err |  
			self assert: err message selector = #>. 
			self assert: err message arguments = (Array with: 1)]
]

{ #category : #tests }
GLMPresentationTest >> testSetup [ 
	 
	| presentation | 
	presentation := GLMPresentation new. 
	self assert: presentation pane notNil. 
	self assert: (presentation pane presentations includes: presentation)
]

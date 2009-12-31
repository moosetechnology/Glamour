Class {
	#name : #GLMPresentationTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #testing }
GLMPresentationTest >> expectedFailures [
	^ #("testUpdateYourselfOnEntityUpdate testUpdateYourselfOnPortsUpdate testUpdateYourselfOnSelectionUpdate")
]

{ #category : #tests }
GLMPresentationTest >> testAnnouncement [ 
	 
	| pane presentation announcement | 
	pane := GLMPane named: 'test'. 
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
	pane := GLMPane named: 'test'. 
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
GLMPresentationTest >> testExplicitNotNilMultipleValues [
	| presentation | 
	presentation := GLMPresentation new. 
	presentation useExplicitNotNil.
	(presentation pane port: #entity) value: (GLMMultiValue withAll: #(nil nil)).
	self assert: presentation matches not.
	(presentation pane port: #entity) value: (GLMMultiValue withAll: #(1 nil)).
	self assert: presentation matches.
	(presentation pane port: #entity) value: (GLMMultiValue withAll: #(nil 1)).
	self assert: presentation matches.
	(presentation pane port: #entity) value: (GLMMultiValue withAll: #(1 2)).
	self assert: presentation matches.
]

{ #category : #tests }
GLMPresentationTest >> testImplicitNotNilMultipleValues [
	| presentation | 
	presentation := GLMPresentation new. 
	presentation useImplicitNotNil.
	(presentation pane port: #entity) value: (GLMMultiValue withAll: #(nil nil)).
	self assert: presentation matches not.
	(presentation pane port: #entity) value: (GLMMultiValue withAll: #(1 nil)).
	self assert: presentation matches not.
	(presentation pane port: #entity) value: (GLMMultiValue withAll: #(nil 1)).
	self assert: presentation matches not.
	(presentation pane port: #entity) value: (GLMMultiValue withAll: #(1 2)).
	self assert: presentation matches.
]

{ #category : #tests }
GLMPresentationTest >> testMatching [ 
	 
	| presentation | 
	presentation := GLMPresentation new. 
	self assert: presentation usesImplicitNotNil. 
	(presentation pane port: #entity) value: (GLMMultiValue withAll: #(nil 1)). 
	self assert: presentation matches not.
	(presentation pane port: #entity) value: 1. 
	self assert: presentation matches. 
	presentation useExplicitNotNil. 
	self assert: presentation usesImplicitNotNil not. 
	(presentation pane port: #entity) value: (GLMMultiValue withAll: #(nil 1)). 
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
	[(presentation pane port: #entity) value: (GLMMultiValue withAll: #(nil 1)). 
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

{ #category : #tests }
GLMPresentationTest >> testTitle [ 
	 
	| presentation | 
	presentation := GLMPresentation new. 
	presentation entity: #foo. 
	self assert: presentation titleValue = 'foo'. 
	presentation entity: '4'. 
	presentation title: [:x | x , '2']. 
	self assert: presentation titleValue = '42'. 
	presentation entity: (GLMMultiValue withAll: #('4' '3')). 
	presentation title: [:first :second | first , second]. 
	self assert: presentation titleValue = '43'
]

{ #category : #tests }
GLMPresentationTest >> testToSend [
	| presentation |
	presentation := GLMPresentation new.
	presentation selection: #foo.
	self assert: presentation selection = #foo.
	presentation selection: #(#foo #bar ).
	self assert: presentation selection = #(#foo #bar ).
	presentation selection: (GLMMultiValue withAll: #(#foo #bar )).
	self assert: presentation selection = #foo.
	presentation selectionTransformation: [ :first :second | (first , second) asSymbol ].
	presentation selection: (GLMMultiValue withAll: #(#foo #bar )).
	self assert: presentation selection = #foobar
]

{ #category : #tests }
GLMPresentationTest >> testUpdateYourselfOnPortsUpdate [
	| pane port presentation timesTriggered announcer col |
	col := OrderedCollection with: 1 with: 2. 
	pane := GLMPane named: 'test'. 
	presentation := GLMListPresentation new.
	announcer := Announcer new.
	pane addPresentation: presentation.
	presentation updateYourselfOn: TestAnnouncement from: [ announcer ].
	presentation entity: col.
	presentation shouldValidate: true.
	presentation registerAnnouncements.
	presentation selection: 2.
	self assert: presentation selection = 2.
	col removeLast.
	announcer announce: TestAnnouncement.
	self assert: presentation selection isNil

]

{ #category : #tests }
GLMPresentationTest >> testUpdateYourselfOnTriggered [
	| pane port presentation timesTriggered announcer | 
	pane := GLMPane named: 'test'. 
	presentation := GLMPresentation new.
	announcer := Announcer new.
	pane addPresentation: presentation.
	timesTriggered := 0.
	presentation when: GLMPresentationUpdated do: [:announcement | timesTriggered := timesTriggered + 1].

	presentation updateYourselfOn: TestAnnouncement from: #yourself.
	presentation entity: announcer.
	presentation registerAnnouncements.
	
	announcer announce: TestAnnouncement.
	self assert: timesTriggered = 1

]

{ #category : #tests }
GLMPresentationTest >> testValidate [
	 
	| pane port presentation| 
	pane := GLMPane named: 'test'. 
	presentation := GLMPresentation new.
	pane addPresentation: presentation.
	presentation entity: (OrderedCollection with: 1 with: 2).
	self assert: (presentation validate: 1 on: (pane port: #foo)).
	self assert: (presentation validate: 2 on: (pane port: #foo)).
	self assert: (presentation validate: 5 on: (pane port: #foo))

]

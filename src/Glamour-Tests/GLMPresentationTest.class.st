Class {
	#name : #GLMPresentationTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

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
GLMPresentationTest >> testCopyAnnouncements [

	| presentation newPresentation |
	presentation := GLMPresentation new.
	presentation when: GLMContextChanged do: [:ann | self fail ].
	self assert: (presentation instVarNamed: #subscriptions) size = 1.
	newPresentation := presentation copy.
	newPresentation announce: GLMContextChanged.
	self assert: (newPresentation instVarNamed: #subscriptions) isNil
]

{ #category : #tests }
GLMPresentationTest >> testCopyRootPrototype [

	| presentation newPresentation yetAnotherPresentation |
	presentation := GLMPresentation new.
	newPresentation := presentation copy.
	self assert: newPresentation rootPrototype = presentation.
	self assert: newPresentation parentPrototype = presentation.
	yetAnotherPresentation := newPresentation copy.
	self assert: yetAnotherPresentation rootPrototype = presentation.
	self assert: yetAnotherPresentation parentPrototype = newPresentation
]

{ #category : #tests }
GLMPresentationTest >> testDefaultPane [
	| presentation pane |
	presentation := GLMPresentation new.
	pane := presentation pane.
	self assert: pane presentations first pane == pane.
	self assert: pane presentations pane == pane.
	self assert: pane presentations first == presentation
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
GLMPresentationTest >> testEquality [
	| presentation |
	presentation := GLMPresentation new.
	self assert: presentation = presentation copy
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
GLMPresentationTest >> testHasTitle [
	| presentation |
	presentation := GLMPresentation new.
	self assert: presentation hasTitle not.
	presentation title: 'something'.
	self assert: presentation hasTitle
]

{ #category : #tests }
GLMPresentationTest >> testHasTitleIcon [
	| presentation |
	presentation := GLMPresentation new.
	self assert: presentation hasTitleIcon not.
	presentation titleIcon: 'something'.
	self assert: presentation hasTitleIcon
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
	self assert: presentation titleValue isNil.
	presentation title: '41'.
	self assert: presentation titleValue = '41'.
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
GLMPresentationTest >> testUnregisterAnnouncements [
	| announcer presentation |
	announcer := Announcer new.
	presentation := GLMPresentation new.
	presentation updateOn: TestAnnouncement from: [ announcer ].
	presentation registerAnnouncements.
	self assert: (announcer instVarNamed: 'subscriptions') size = 1.
	presentation unregisterFromAllAnnouncements.
	self assert: (announcer instVarNamed: 'subscriptions') isEmpty.

]

{ #category : #tests }
GLMPresentationTest >> testUnregisterAnnouncementsWhenEntityChanges [
	| announcer1 presentation |
	announcer1 := Announcer new.
	presentation := GLMPresentation new.
	presentation updateOn: TestAnnouncement from: [ announcer1 ].
	presentation entity: 1.
	presentation registerAnnouncements.
	self assert: (announcer1 instVarNamed: 'subscriptions') size = 1.
	presentation entity: 2.
	self assert: (announcer1 instVarNamed: 'subscriptions') isEmpty.
	presentation registerAnnouncements.
	self assert: (announcer1 instVarNamed: 'subscriptions') size = 1.
	presentation entity: nil.
	self assert: (announcer1 instVarNamed: 'subscriptions') isEmpty.


	
]

{ #category : #tests }
GLMPresentationTest >> testUpdate [
	| col pane presentation |
	col := OrderedCollection with: 1 with: 2. 
	pane := GLMPane named: 'test'. 
	presentation := GLMListPresentation new.
	pane addPresentation: presentation.
	presentation entity: col.
	presentation shouldValidate: true.
	presentation update.
	presentation selection: 2.
	self assert: presentation selection = 2.
	col removeLast.
	presentation update.
	self assert: presentation selection isNil

]

{ #category : #tests }
GLMPresentationTest >> testUpdateConditionallyTriggered [ 
	| pane presentation announcer timesTriggered |
	pane := GLMPane named: 'test'. 
	(pane port: #entity) value: 40.
	presentation := GLMPresentation new.
	announcer := Announcer new.
	pane addPresentation: presentation.
	timesTriggered := 0.
	presentation when: GLMPresentationUpdated do: [:announcement | 
		timesTriggered := timesTriggered + 1].

	presentation 
		updateOn: TestAnnouncement 
		from: [:x | announcer ]
		when: [ :ann :entity | ann parameter + entity = 42].
	presentation registerAnnouncements.
	
	announcer announce: (TestAnnouncement new parameter: 0).
	self assert: timesTriggered = 0.

	announcer announce: (TestAnnouncement new parameter: 2).
	self assert: timesTriggered = 1

]

{ #category : #tests }
GLMPresentationTest >> testUpdateOnFromAllPortsUpdate [
	| pane presentation announcers col updated |
	col := (1 to: 4) asOrderedCollection. 
	pane := GLMPane named: 'test'. 
	presentation := GLMListPresentation new.
	announcers := col collect: [:each | Announcer new].
	pane addPresentation: presentation.
	presentation updateOn: TestAnnouncement fromAll: [ announcers ].
	presentation when: GLMPresentationUpdated do: [:a | updated := true ].
	presentation entity: col.
	presentation shouldValidate: true.
	presentation registerAnnouncements.

	updated := false.
	announcers last announce: TestAnnouncement.
	self assert: updated.
	updated := false.
	announcers last announce: TestAnnouncement.
	self assert: updated.

]

{ #category : #tests }
GLMPresentationTest >> testUpdateOnPortsUpdate [
	| col pane presentation announcer |
	col := OrderedCollection with: 1 with: 2. 
	pane := GLMPane named: 'test'. 
	presentation := GLMListPresentation new.
	announcer := Announcer new.
	pane addPresentation: presentation.
	presentation updateOn: TestAnnouncement from: [ announcer ].
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
GLMPresentationTest >> testUpdateOnTriggered [
	| pane presentation announcer timesTriggered |
	pane := GLMPane named: 'test'. 
	presentation := GLMPresentation new.
	announcer := Announcer new.
	pane addPresentation: presentation.
	timesTriggered := 0.
	presentation when: GLMPresentationUpdated do: [:announcement | timesTriggered := timesTriggered + 1].

	presentation updateOn: TestAnnouncement from: #yourself.
	presentation entity: announcer.
	presentation registerAnnouncements.
	
	announcer announce: TestAnnouncement.
	self assert: timesTriggered = 1

]

{ #category : #tests }
GLMPresentationTest >> testValidate [
	| pane presentation | 
	pane := GLMPane named: 'test'. 
	presentation := GLMPresentation new.
	pane addPresentation: presentation.
	presentation entity: (OrderedCollection with: 1 with: 2).
	self assert: (presentation validate: 1 on: (pane port: #foo)).
	self assert: (presentation validate: 2 on: (pane port: #foo)).
	self assert: (presentation validate: 5 on: (pane port: #foo))

]

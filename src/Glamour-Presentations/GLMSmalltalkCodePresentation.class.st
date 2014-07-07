Class {
	#name : #GLMSmalltalkCodePresentation,
	#superclass : #GLMTextualPresentation,
	#instVars : [
		'highlightSmalltalkContext',
		'variableBindingsBlock',
		'isForScripting'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #actions }
GLMSmalltalkCodePresentation >> beForScripting [

	isForScripting := true
]

{ #category : #actions }
GLMSmalltalkCodePresentation >> compileTextIn: aContext from:  aSession andDo: aBlock [

	self announce: (GLMCompileText new
		presentation: self;
		context: aContext;
		session: aSession;
		action: aBlock)
]

{ #category : #actions }
GLMSmalltalkCodePresentation >> debugSelection [

	self announce: GLMDebugSelection
]

{ #category : #rendering }
GLMSmalltalkCodePresentation >> defaultSelectionActions [

	^ { 
		(GLMGenericAction new) 
				title: 'Print it';
				action: [ :aPresentation |
					aPresentation printSelection ]; 
				shortcut: $p; 
				yourself.
		(GLMGenericAction new) 
				title: 'Do it';
				action: [ :aPresentation |
					aPresentation evaluateSelection ]; 
				shortcut: $d; 
				icon: GLMUIThemeExtraIcons glamorousSpawn;
				yourself.
		(GLMGenericAction new) 
				title: 'Inspect it'; 
				action: [ :aPresentation |
					aPresentation evaluateSelectionAndDo: [ :result | result inspect ] ]; 
				shortcut: $i; 
				icon: GLMUIThemeExtraIcons glamorousInspect;
				yourself.
		(GLMGenericAction new) 
				title: 'Debug it'; 
				action: [ :aPresentation |
					aPresentation debugSelection ]; 
				"shortcut: $D; "
				yourself.
		(GLMGenericAction new) 
				title: 'Profile it'; 
				action: [ :aPresentation |
					aPresentation profileSelection ]; 
				yourself
		 }
]

{ #category : #actions }
GLMSmalltalkCodePresentation >> evaluateSelection [

	self evaluateSelectionAndDo: [ :result | result ]
]

{ #category : #actions }
GLMSmalltalkCodePresentation >> evaluateSelectionAndDo: aBlock [

	self announce: (GLMEvaluateSelection new action: aBlock)
]

{ #category : #accessing }
GLMSmalltalkCodePresentation >> highlightSmalltalkContext [
	^ highlightSmalltalkContext isNil 
		ifTrue: [nil] 
		ifFalse: [highlightSmalltalkContext glamourValue: self entity]
]

{ #category : #rendering }
GLMSmalltalkCodePresentation >> installDefaultSelectionActions [

	self defaultSelectionActions do: [ :anAction |
		self addSelectionAction: anAction ]

	"self
		selectionAct: [ :aPresentation |
				aPresentation evaluateSelection ]
			on: $d
			entitled: 'Do it';
		selectionAct: [ :aPresentation |
				aPresentation evaluateSelectionAndDo: [ :result | result inspect ] ]
			on: $i
			entitled: 'Inspect it';
		selectionAct: [ :aPresentation |
				aPresentation debugSelection ]
			on: $D
			entitled: 'Debug it';
		selectionAct: [ :aPresentation |
				aPresentation profileSelection ]
			entitled: 'Profile it'"
]

{ #category : #accessing }
GLMSmalltalkCodePresentation >> isForScripting [

	^ isForScripting ifNil: [ false ]
]

{ #category : #actions }
GLMSmalltalkCodePresentation >> printSelection [

	self announce: GLMPrintSelection
]

{ #category : #actions }
GLMSmalltalkCodePresentation >> profileSelection [

	self announce: GLMProfileSelection
]

{ #category : #rendering }
GLMSmalltalkCodePresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderSmalltalkCodePresentation: self
]

{ #category : #accessing }
GLMSmalltalkCodePresentation >> smalltalkClass: aBlock [
	"aBlock takes as parameters the entity objects and 
	its evaluation is expected to produce a Smalltalk class"
	highlightSmalltalkContext := aBlock.
]

{ #category : #accessing }
GLMSmalltalkCodePresentation >> updateVariableBindings [

	self announce: (GLMVariableBindingsChanged new presentation: self).
]

{ #category : #accessing }
GLMSmalltalkCodePresentation >> variableBindings [
	^ (variableBindingsBlock glamourValue: self entity) ifNil: [OrderedCollection new]
]

{ #category : #accessing }
GLMSmalltalkCodePresentation >> variableBindings: aBlock [
	^ variableBindingsBlock := aBlock
]

Class {
	#name : #GLMNewSmalltalkCodePresentation,
	#superclass : #GLMRubricTextPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #actions }
GLMNewSmalltalkCodePresentation >> compileTextIn: aContext from:  aSession [ 

	self announce: (GLMCompileText new
		presentation: self;
		context: aContext;
		session: aSession)
]

{ #category : #actions }
GLMNewSmalltalkCodePresentation >> debugSelection [

	self announce: GLMDebugSelection
]

{ #category : #rendering }
GLMNewSmalltalkCodePresentation >> defaultSelectionActions [

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
GLMNewSmalltalkCodePresentation >> evaluateSelection [

	self evaluateSelectionAndDo: [ :result | result ]
]

{ #category : #actions }
GLMNewSmalltalkCodePresentation >> evaluateSelectionAndDo: aBlock [

	self announce: (GLMEvaluateSelection new action: aBlock)
]

{ #category : #rendering }
GLMNewSmalltalkCodePresentation >> installDefaultSelectionActions [

	self defaultSelectionActions do: [ :anAction |
		self addSelectionAction: anAction ]
]

{ #category : #actions }
GLMNewSmalltalkCodePresentation >> printSelection [

	self announce: GLMPrintSelection
]

{ #category : #actions }
GLMNewSmalltalkCodePresentation >> profileSelection [

	self announce: GLMProfileSelection
]

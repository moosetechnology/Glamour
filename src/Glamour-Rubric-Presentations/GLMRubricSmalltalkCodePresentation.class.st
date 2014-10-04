"
I extend the simple Rubric text presentation with basic support for dealing with Smalltalk code.
"
Class {
	#name : #GLMRubricSmalltalkCodePresentation,
	#superclass : #GLMRubricTextPresentation,
	#category : #'Glamour-Rubric-Presentations'
}

{ #category : #actions }
GLMRubricSmalltalkCodePresentation >> compileTextIn: aContext from:  aSession andDo: aBlock [

	self announce: (GLMCompileText new
		presentation: self;
		context: aContext;
		session: aSession;
		action: aBlock)
]

{ #category : #actions }
GLMRubricSmalltalkCodePresentation >> debugSelection [

	self announce: GLMDebugSelection
]

{ #category : #rendering }
GLMRubricSmalltalkCodePresentation >> defaultSelectionActions [

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
				yourself.
		(GLMGenericAction new) 
				title: 'Copy';
				action: [ :aPresentation |
					aPresentation copySelection ]; 
				shortcut: $c; 
				yourself.
		(GLMGenericAction new) 
				title: 'Cut';
				action: [ :aPresentation |
					aPresentation cut ]; 
				shortcut: $x; 
				yourself.
		(GLMGenericAction new) 
				title: 'Paste';
				action: [ :aPresentation |
					aPresentation paste ]; 
				shortcut: $v; 
				yourself.
		(GLMGenericAction new) 
				title: 'Paste...';
				action: [ :aPresentation |
					aPresentation pasteRecent  ]; 
				yourself.
		(GLMGenericAction new) 
				title: 'Extended string search'; 
				action: [ :aPresentation |
					aPresentation selectLine.
					self systemNavigation 
						browseMethodsWithString: aPresentation selectedText
						matchCase: false ]; 
				shortcut: $E;
				yourself
		 }
]

{ #category : #actions }
GLMRubricSmalltalkCodePresentation >> evaluateSelection [

	self evaluateSelectionAndDo: [ :result | result ]
]

{ #category : #actions }
GLMRubricSmalltalkCodePresentation >> evaluateSelectionAndDo: aBlock [

	self announce: (GLMEvaluateSelection new action: aBlock)
]

{ #category : #rendering }
GLMRubricSmalltalkCodePresentation >> installDefaultSelectionActions [

	self defaultSelectionActions do: [ :anAction |
		self addSelectionAction: anAction ]
]

{ #category : #actions }
GLMRubricSmalltalkCodePresentation >> printSelection [

	self announce: GLMPrintSelection
]

{ #category : #actions }
GLMRubricSmalltalkCodePresentation >> profileSelection [

	self announce: GLMProfileSelection
]

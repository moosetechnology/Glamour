"
I extend the simple Rubric text presentation with basic support for dealing with Smalltalk code.
"
Class {
	#name : #GLMRubricSmalltalkCodePresentation,
	#superclass : #GLMRubricTextPresentation,
	#category : #'Glamour-Rubric-Presentations'
}

{ #category : #'actions browsing' }
GLMRubricSmalltalkCodePresentation >> browseIt [

	self announce: (GLMTextEditorRequest for: #browseIt)
]

{ #category : #accessing }
GLMRubricSmalltalkCodePresentation >> browsingSelectionActions [

	^ { (GLMGenericAction new) 
				title: 'browse it';
				action: [ :aPresentation |
					aPresentation browseIt  ]; 
				shortcut: $b; 
				category: 'Extended search...';
				yourself.
		(GLMGenericAction new) 
				title: 'senders of it';
				action: [ :aPresentation |
					aPresentation sendersOfIt ]; 
				shortcut: $n; 
				category: 'Extended search...';
				yourself.
		(GLMGenericAction new) 
				title: 'implementors of it';
				action: [ :aPresentation |
					aPresentation implementorsOfIt ]; 
				shortcut: $m; 
				category: 'Extended search...';
				yourself.
		(GLMGenericAction new) 
				title: 'references to it';
				action: [ :aPresentation |
					aPresentation referencesToIt ]; 
				shortcut: $N; 
				category: 'Extended search...';
				withSeparatorAfter;
				yourself.
		(GLMGenericAction new) 
				title: 'Extended string search'; 
				action: [ :aPresentation |
					aPresentation selectLine.
					self systemNavigation 
						browseMethodsWithString: aPresentation selectedText
						matchCase: false ]; 
				shortcut: $E;
				category: 'Extended search...';
				yourself }
]

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

{ #category : #accessing }
GLMRubricSmalltalkCodePresentation >> defaultSelectionActions [

	^ self executionSelectionActions, 
		self codeEditingSelectionActions, 
		self browsingSelectionActions
	
]

{ #category : #actions }
GLMRubricSmalltalkCodePresentation >> evaluateSelection [

	self evaluateSelectionAndDo: [ :result | result ]
]

{ #category : #actions }
GLMRubricSmalltalkCodePresentation >> evaluateSelectionAndDo: aBlock [

	self announce: (GLMEvaluateSelection new action: aBlock)
]

{ #category : #accessing }
GLMRubricSmalltalkCodePresentation >> executionSelectionActions [

	^ { 
		(GLMGenericAction new) 
				title: 'Do it';
				action: [ :aPresentation |
					aPresentation evaluateSelection ]; 
				shortcut: $d; 
				icon: GLMUIThemeExtraIcons glamorousSpawn;
				yourself.
		(GLMGenericAction new) 
				title: 'Print it';
				action: [ :aPresentation |
					aPresentation printSelection ]; 
				shortcut: $p; 
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
				withSeparatorAfter;
				yourself.
		 }
]

{ #category : #'actions browsing' }
GLMRubricSmalltalkCodePresentation >> implementorsOfIt [

	self announce: (GLMTextEditorRequest for: #implementorsOfIt)
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

{ #category : #'actions browsing' }
GLMRubricSmalltalkCodePresentation >> referencesToIt [

	self announce: (GLMTextEditorRequest for: #referencesToIt)
]

{ #category : #'actions browsing' }
GLMRubricSmalltalkCodePresentation >> sendersOfIt [

	self announce: (GLMTextEditorRequest for: #sendersOfIt)
]

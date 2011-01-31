Extension { #name : #GLMPresentation }

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> act: aBlock entitled: aString [ 
	 
	self 
		addAction: 
			((GLMGenericAction new) 
				action: aBlock; 
				title: aString; 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> act: aBlock entitled: aString categorized: anotherString [
	 
	self 
		addAction: 
			((GLMGenericAction new) 
				action: aBlock; 
				title: aString; 
				category: anotherString;
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> act: aBlock icon: anIcon entitled: aString [
	self 
		addAction: 
			((GLMGenericAction new) 
				action: aBlock; 
				icon: anIcon;
				title: aString;
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> act: aBlock on: aCharacter [ 
	 
	self 
		addAction: 
			((GLMGenericAction new) 
				action: aBlock; 
				shortcut: aCharacter; 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> act: aBlock on: aCharacter entitled: aString [ 
	 
	self 
		addAction: 
			((GLMGenericAction new) 
				action: aBlock; 
				shortcut: aCharacter; 
				title: aString; 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> act: aBlock on: aCharacter entitled: aString categorized: anotherString [ 
	 
	self 
		addAction: 
			((GLMGenericAction new) 
				action: aBlock; 
				shortcut: aCharacter; 
				title: aString; 
				category: anotherString;
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> actions: aBlock [ 
	self deprecated: 'use dynamicActionsOnSelection: for contextual actions, and dynamicActions for presentation-wide actions'.
	^ self dynamicActionsOnSelection: aBlock 
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> allowNil [
	^ self useExplicitNotNil
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> display: aBlock [ 
	 
	self transformation: aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> dynamicActions: aBlock [ 
	dynamicActionsBlock := aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> morphicAct: aBlock entitled: aString [ 
	 
	self addAction: 
			((GLMMorphicAction new) 
				action: aBlock; 
				title: aString; 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> morphicAct: aBlock icon: anIcon entitled: aString [ 
	 
	self addAction: 
			((GLMMorphicAction new) 
				action: aBlock; 
				title: aString; 
				icon: anIcon;
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> morphicAct: aBlock on: aCharacter entitled: aString [ 
	 
	self 
		addAction: 
			((GLMMorphicAction new) 
				action: aBlock; 
				shortcut: aCharacter; 
				title: aString; 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> morphicAct: aBlock on: aCharacter icon: anIcon entitled: aString [ 
	 
	self 
		addAction: 
			((GLMMorphicAction new) 
				action: aBlock; 
				shortcut: aCharacter; 
				icon: anIcon;
				title: aString; 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> morphicSelectionAct: aBlock entitled: aString [ 
	 
	self addSelectionAction: 
			((GLMMorphicAction new) 
				action: aBlock; 
				title: aString; 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> morphicSelectionAct: aBlock icon: anIcon entitled: aString [
	self 
		addSelectionAction: 
			((GLMMorphicAction new) 
				action: aBlock; 
				icon: anIcon;
				title: aString;
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> noSelection [
	self acceptsSelection: false
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> noTitle [
	title := nil
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> open: aBlock on: aCharacter entitled: aString [ 
	 
	self 
		addAction: 
			((GLMGenericAction new) 
				action: aBlock; 
				shortcut: aCharacter; 
				title: aString; 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> populate: aPortSymbol icon: anIcon entitled: aString with: aBlock [ 
	 
	self 
		addAction: 
			((GLMGenericAction new) 
				action: 
						((GLMPortUpdater new) 
								portSymbol: aPortSymbol; 
								valueBlock: aBlock; 
								yourself); 
				icon: anIcon; 
				title: aString;
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> populate: aPortSymbol on: aCharacter entitled: aString with: aBlock [ 
	 
	self 
		addAction: 
			((GLMGenericAction new) 
				action: 
						((GLMPortUpdater new) 
								portSymbol: aPortSymbol; 
								valueBlock: aBlock; 
								yourself); 
				shortcut: aCharacter; 
				title: aString;
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> populate: aPortSymbol on: aCharacter with: aBlock [
	self addAction: 
			((GLMGenericAction new) 
				action: ((GLMPortUpdater new) 
								portSymbol: aPortSymbol; 
								valueBlock: aBlock; 
								yourself); 
				shortcut: aCharacter; 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> selectionAct: aBlock entitled: aString [ 
	 
	self 
		addSelectionAction: 
			((GLMGenericAction new) 
				action: aBlock; 
				title: aString; 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> selectionAct: aBlock entitled: aString categorized: anotherString [
	 
	self 
		addSelectionAction: 
			((GLMGenericAction new) 
				action: aBlock; 
				title: aString; 
				category: anotherString;
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> selectionAct: aBlock icon: anIcon entitled: aString [
	self 
		addSelectionAction: 
			((GLMGenericAction new) 
				action: aBlock; 
				icon: anIcon;
				title: aString;
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> selectionAct: aBlock on: aCharacter [ 
	 
	self 
		addSelectionAction: 
			((GLMGenericAction new) 
				action: aBlock; 
				shortcut: aCharacter; 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> selectionAct: aBlock on: aCharacter entitled: aString [ 
	 
	self 
		addSelectionAction: 
			((GLMGenericAction new) 
				action: aBlock; 
				shortcut: aCharacter; 
				title: aString; 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> selectionPopulate: aPortSymbol on: aCharacter entitled: aString with: aBlock [ 
	 
	self 
		addSelectionAction: 
			((GLMGenericAction new) 
				action: 
						((GLMPortUpdater new) 
								portSymbol: aPortSymbol; 
								valueBlock: aBlock; 
								yourself); 
				shortcut: aCharacter; 
				title: aString;
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> send: aBlock [ 
	self selectionTransformation: aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> when: aBlock [ 
	 
	self condition: aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> whenKindOf: aClass [ 
	 
	self when: [:each | each isKindOf: aClass]
]

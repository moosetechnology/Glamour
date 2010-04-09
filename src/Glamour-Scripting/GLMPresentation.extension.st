Extension { #name : #GLMPresentation }

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> act: aBlock entitled: aString [ 
	 
	self 
		addAction: 
			((GLMAction new) 
				action: aBlock; 
				title: aString; 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> act: aBlock entitled: aString categorized: anotherString [
	 
	self 
		addAction: 
			((GLMAction new) 
				action: aBlock; 
				title: aString; 
				category: anotherString;
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> act: aBlock icon: anIcon entitled: aString [
	self 
		addAction: 
			((GLMAction new) 
				action: aBlock; 
				icon: anIcon;
				title: aString;
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> act: aBlock on: aCharacter [ 
	 
	self 
		addAction: 
			((GLMAction new) 
				action: aBlock; 
				shortcut: aCharacter; 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> act: aBlock on: aCharacter entitled: aString [ 
	 
	self 
		addAction: 
			((GLMAction new) 
				action: aBlock; 
				shortcut: aCharacter; 
				title: aString; 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> act: aBlock on: aCharacter entitled: aString categorized: anotherString [ 
	 
	self 
		addAction: 
			((GLMAction new) 
				action: aBlock; 
				shortcut: aCharacter; 
				title: aString; 
				category: anotherString;
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> actions: aBlock [ 
	dynamicActionsBlock := aBlock
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
GLMPresentation >> noSelection [
	self acceptsSelection: false
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> noTitle [
	title := nil
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> populate: aPortSymbol on: aCharacter entitled: aString with: aBlock [ 
	 
	self 
		addAction: 
			((GLMAction new) 
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
			((GLMAction new) 
				action: ((GLMPortUpdater new) 
								portSymbol: aPortSymbol; 
								valueBlock: aBlock; 
								yourself); 
				shortcut: aCharacter; 
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> send: aBlock [ 
	self selectionTransformation: aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> update: aPortSymbol on: aCharacter entitled: aString categorized: anotherString with: aBlock [ 
	 
	self 
		addAction: 
			((GLMAction new) 
				action: 
						((GLMPortUpdater new) 
								portSymbol: aPortSymbol; 
								valueBlock: aBlock; 
								yourself); 
				shortcut: aCharacter; 
				title: aString;
				category: anotherString;
				yourself)
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> update: aPortSymbol on: aCharacter entitled: aString with: aBlock [
	self deprecated: 'Please use populate: aPortSymbol on: aCharacter entitled: aString with: aBlock	'.
	^ self populate: aPortSymbol on: aCharacter entitled: aString with: aBlock	
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> update: aPortSymbol on: aCharacter with: aBlock [
	self deprecated: 'please use populate: aPortSymbol on: aCharacter with: aBlock'.
	^ self populate: aPortSymbol on: aCharacter with: aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> when: aBlock [ 
	 
	self condition: aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMPresentation >> whenKindOf: aClass [ 
	 
	self when: [:each | each isKindOf: aClass]
]

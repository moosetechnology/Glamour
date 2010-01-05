Extension { #name : #GLMBrowser }

{ #category : #'*glamour-scripting' }
GLMBrowser >> context [

	^OrderedCollection new
]

{ #category : #'*glamour-scripting' }
GLMBrowser >> custom: aPresentation [ 
	 
	self subclassResponsibility
]

{ #category : #'*glamour-scripting' }
GLMBrowser >> defaultRenderer [ 
	 
	^GLMRenderer subclasses first new
]

{ #category : #'*glamour-scripting' }
GLMBrowser >> initializeContextWith: aPane [
]

{ #category : #'*glamour-scripting' }
GLMBrowser >> open [ 
	 
	^self openWith: self defaultRenderer
]

{ #category : #'*glamour-scripting' }
GLMBrowser >> openOn: anObject [ 
	 
	^self 
		openOn: anObject 
		with: self defaultRenderer
]

{ #category : #'*glamour-scripting' }
GLMBrowser >> openOn: anObject with: aRenderer [ 
	 
	self startOn: anObject. 
	^aRenderer open: self
]

{ #category : #'*glamour-scripting' }
GLMBrowser >> openWith: aRenderer [ 
	 
	^self openOn: nil with: aRenderer
]

{ #category : #'*glamour-scripting' }
GLMBrowser >> startOn: anObject [ 
	 
	self initializeScriptingDefaults. 
	self entity: anObject
]

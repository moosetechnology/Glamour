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
GLMBrowser >> initializeScriptingDefaults [ 
	"Initialize some default behavior if the user did not explcitly script it. 
 
	Subclasses can use this to create a default startup transmission or show 
	a default pane or something like that." 
	
	^self
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
GLMBrowser >> screenshot: aFilenameString on: anObject after: aBlock [
	 
	| window |
	window := self openOn: anObject.
	aBlock glamourValue: self asGlamorousMultiValue.
	World doOneCycle.
	PNGReadWriter putForm: window imageForm onFileNamed: aFilenameString.
	^ window
]

{ #category : #'*glamour-scripting' }
GLMBrowser >> startOn: anObject [ 
	 
	self initializeScriptingDefaults. 
	self entity: anObject
]

{ #category : #'*glamour-scripting' }
GLMBrowser >> transmit [
	^ self addTransmission: (GLMTransmission new browser: self; yourself)
]

{ #category : #'*glamour-scripting' }
GLMBrowser class >> withStatusbar [
	^ self new addStatusbar
]

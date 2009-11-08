Extension { #name : #GLMBrowser }

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> actionList [
	^ self custom: GLMActionListPresentation new
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> context [

	^OrderedCollection new
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> custom: aPresentation [ 
	 
	self subclassResponsibility
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> defaultRenderer [ 
	 
	^GLMRenderer subclasses first new
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> diff [
	 
	^self custom: GLMDiffPresentation new
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> dynamic [
	^ self custom: GLMDynamicPresentation new
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> initializeContextWith: aPane [
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> list [ 
	 
	^self custom: GLMListPresentation new
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> magritte [
	^ self custom: GLMMagrittePresentation new
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> mondrian [ 
	 
	^self custom: GLMMondrianPresentation new
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> morph [
	^ self custom: GLMMorphPresentation new
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> open [ 
	 
	^self openWith: self defaultRenderer
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> openOn: anObject [ 
	 
	^self 
		openOn: anObject 
		with: self defaultRenderer
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> openOn: anObject with: aRenderer [ 
	 
	self startOn: anObject. 
	^aRenderer open: self
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> openWith: aRenderer [ 
	 
	^self openOn: nil with: aRenderer
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> startOn: anObject [ 
	 
	self initializeScriptingDefaults. 
	self entity: anObject
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> text [ 
	 
	^self custom: GLMTextPresentation new
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> tree [ 
	 
	^self custom: GLMTreePresentation new
]

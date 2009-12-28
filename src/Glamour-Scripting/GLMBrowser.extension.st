Extension { #name : #GLMBrowser }

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> actionList [
	^ self custom: GLMActionListPresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMBrowser >> composite [
	^ self custom: GLMCompositePresentation new
]

{ #category : #'*Glamour-Scripting' }
GLMBrowser >> compositeList [
	^ self custom: GLMCompositeBuilder new
]

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

{ #category : #'*glamour-scripting-presentations' }
GLMBrowser >> diff [
	^ self custom: GLMDiffPresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMBrowser >> dynamic [
	^ self custom: GLMDynamicPresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMBrowser >> finder [
	^ self custom: GLMFinder new
]

{ #category : #'*glamour-scripting' }
GLMBrowser >> initializeContextWith: aPane [
]

{ #category : #'*glamour-scripting-presentations' }
GLMBrowser >> list [ 
	^ self custom: GLMListPresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMBrowser >> magritte [
	^ self custom: GLMMagrittePresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMBrowser >> mondrian [ 
	^ self custom: GLMMondrianPresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMBrowser >> morph [
	^ self custom: GLMMorphPresentation new
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

{ #category : #'*glamour-scripting-presentations' }
GLMBrowser >> table [
	^ self custom: GLMTablePresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMBrowser >> tabulator [
	^ self custom: GLMTabulator new
]

{ #category : #'*glamour-scripting-presentations' }
GLMBrowser >> text [ 
	^ self custom: GLMTextPresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMBrowser >> tree [ 
	^ self custom: GLMTreePresentation new
]

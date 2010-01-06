Extension { #name : #GLMTPresentationBuilder }

{ #category : #'*glamour-scripting-presentations' }
GLMTPresentationBuilder >> actionList [
	^ self custom: GLMActionListPresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMTPresentationBuilder >> composite [
	^ self custom: GLMCompositePresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMTPresentationBuilder >> composite: aBlock [
	| composite |
	composite := GLMCompositePresentation new.
	aBlock value: composite.
	^ self custom: composite
]

{ #category : #'*glamour-scripting-presentations' }
GLMTPresentationBuilder >> diff [
	^ self custom: GLMDiffPresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMTPresentationBuilder >> dynamic [
	^ self custom: GLMDynamicPresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMTPresentationBuilder >> finder [
	^ self custom: GLMFinder new
]

{ #category : #'*glamour-scripting-presentations' }
GLMTPresentationBuilder >> list [ 
	^ self custom: GLMListPresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMTPresentationBuilder >> magritte [
	^ self custom: GLMMagrittePresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMTPresentationBuilder >> mondrian [ 
	^ self custom: GLMMondrianPresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMTPresentationBuilder >> morph [
	^ self custom: GLMMorphPresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMTPresentationBuilder >> table [
	^ self custom: GLMTablePresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMTPresentationBuilder >> tabulator [
	^ self custom: GLMTabulator new
]

{ #category : #'*glamour-scripting-presentations' }
GLMTPresentationBuilder >> text [ 
	^ self custom: GLMTextPresentation new
]

{ #category : #'*glamour-scripting-presentations' }
GLMTPresentationBuilder >> tree [ 
	^ self custom: GLMTreePresentation new
]

"
This is a helper trait containing the methods for constructing presentations.
"
Trait {
	#name : #GLMTPresentationBuilder,
	#category : #'Glamour-Core'
}

{ #category : #scripting }
GLMTPresentationBuilder >> actionList [
	^ self custom: GLMActionListPresentation new
]

{ #category : #scripting }
GLMTPresentationBuilder >> composite: aBlock [
	| composite |
	composite := GLMCompositePresentation new.
	aBlock value: composite.
	^ self custom: composite
]

{ #category : #scripting }
GLMTPresentationBuilder >> diff [
	^ self custom: GLMDiffPresentation new
]

{ #category : #scripting }
GLMTPresentationBuilder >> dropDownList [
	^ self custom: GLMDropDownListPresentation new
]

{ #category : #scripting }
GLMTPresentationBuilder >> dynamic [
	^ self custom: GLMDynamicPresentation new
]

{ #category : #scripting }
GLMTPresentationBuilder >> eyesee [
	^ self custom: GLMEyeSeePresentation new
]

{ #category : #scripting }
GLMTPresentationBuilder >> finder [
	^ self custom: GLMFinder new
]

{ #category : #scripting }
GLMTPresentationBuilder >> label [
	^ self custom: GLMLabelPresentation new
]

{ #category : #scripting }
GLMTPresentationBuilder >> list [ 
	^ self custom: GLMListPresentation new
]

{ #category : #scripting }
GLMTPresentationBuilder >> magritte [
	^ self custom: GLMMagrittePresentation new
]

{ #category : #scripting }
GLMTPresentationBuilder >> mondrian [ 
	^ self custom: GLMMondrianPresentation new
]

{ #category : #scripting }
GLMTPresentationBuilder >> morph [
	^ self custom: GLMMorphPresentation new
]

{ #category : #scripting }
GLMTPresentationBuilder >> smalltalkCode [
	^ self custom: GLMSmalltalkCodePresentation new
]

{ #category : #scripting }
GLMTPresentationBuilder >> table [
	^ self custom: GLMTablePresentation new
]

{ #category : #scripting }
GLMTPresentationBuilder >> tabulator [
	^ self custom: GLMTabulator new
]

{ #category : #scripting }
GLMTPresentationBuilder >> text [ 
	^ self custom: GLMTextPresentation new
]

{ #category : #scripting }
GLMTPresentationBuilder >> tree [ 
	^ self custom: GLMTreePresentation new
]

"
A GLMPane represents the building blocks of a browser.

Instance Variables
	browser:		Browser
	lastActivePresentation:		Presentation
	name:		<Object>
	ports:		Collection of Ports
	presentations:		Collection of Presentations
"
Class {
	#name : #GLMPane,
	#superclass : #GLMLoggedObject,
	#instVars : [
		'browser',
		'name',
		'presentations',
		'ports',
		'lastActivePresentation',
		'allowedToNotePresentationsChanged'
	],
	#category : #'Glamour-Core'
}

{ #category : #'as yet unclassified' }
GLMPane class >> in: aBrowser [ 
	
	^self new initializeIn: aBrowser
]

{ #category : #'instance creation' }
GLMPane class >> named: aString [ 
	^self new initializeNamed: aString
]

{ #category : #'as yet unclassified' }
GLMPane class >> named: aString in: aBrowser [

	^self new initializeNamed: aString in: aBrowser 

]

{ #category : #private }
GLMPane class >> portClass [ 
	 
	^GLMPanePort
]

{ #category : #accessing }
GLMPane >> addPresentation: aPresentation [
	self addPresentations: (OrderedCollection with: aPresentation)
]

{ #category : #accessing }
GLMPane >> addPresentationSilently: each [
	^ presentations
		add:
			(each
				pane: self;
				yourself)
]

{ #category : #accessing }
GLMPane >> addPresentations: aCollection [
	self notingPresentationChangeDo: [ 
		aCollection do: [ :each | self addPresentationSilently: each ] ]
]

{ #category : #converting }
GLMPane >> asGlamorousPane [ 
	 
	^self
]

{ #category : #accessing }
GLMPane >> browser [ 
	 
	^browser
]

{ #category : #accessing }
GLMPane >> browser: aBrowser [
	browser := aBrowser
]

{ #category : #accessing }
GLMPane >> clearIn: aContext [ 

	self notingPresentationChangeDo: [
		self presentations clear.
		self ports do: [:each | each value: nil in: aContext ]]
]

{ #category : #initialization }
GLMPane >> defaultName [

	^'undefined'
]

{ #category : #testing }
GLMPane >> hasBrowser [ 
	 
	^self browser isNil not
]

{ #category : #initialization }
GLMPane >> initialize [
	super initialize.
	ports := OrderedCollection new.
	presentations := GLMCompositePresentation new pane: self; yourself
]

{ #category : #initialization }
GLMPane >> initializeIn: aBrowser [ 
	
	self initializeNamed: self defaultName in: aBrowser
]

{ #category : #initialization }
GLMPane >> initializeNamed: aString [ 
	self initializeNamed: aString in: GLMNoBrowser new  
]

{ #category : #initialization }
GLMPane >> initializeNamed: aString in: aBrowser [ 
	self initialize.
	name := aString ifNil: [ self defaultName ].
	browser := aBrowser
]

{ #category : #private }
GLMPane >> isAllowedToNotePresentationsChanged [
	^ allowedToNotePresentationsChanged ifNil: [allowedToNotePresentationsChanged := true ]
]

{ #category : #accessing }
GLMPane >> lastActivePresentation [
	^ lastActivePresentation
]

{ #category : #accessing }
GLMPane >> lastActivePresentation: anObject [
	lastActivePresentation := anObject
]

{ #category : #accessing }
GLMPane >> matchingPresentations [
	^ presentations matchingPresentations
]

{ #category : #accessing }
GLMPane >> name [ 
	 
	^name
]

{ #category : #accessing }
GLMPane >> name: aString [
	name := aString
]

{ #category : #private }
GLMPane >> notingPresentationChangeDo: aBlock [
	| oldPresentations oldMatchingPresentations | 
	self isAllowedToNotePresentationsChanged ifFalse: [
		aBlock value.
		^ self].
	"this should create a context and then check for it before announcing.
	Like this we can deal with the problem of announcing the same announcement twice"
	allowedToNotePresentationsChanged := false.
	
	oldPresentations := presentations presentations. 
	oldMatchingPresentations := self matchingPresentations. 

	aBlock value. 
	presentations ~= oldPresentations ifTrue: [
		self announce: ((GLMPresentationsChanged new) 
						pane: self; 
						oldPresentations: oldPresentations; 
						yourself)]. 
	self matchingPresentations ~= oldMatchingPresentations ifTrue: [
		self announce: ((GLMMatchingPresentationsChanged new) 
						pane: self; 
						oldMatchingPresentations: oldMatchingPresentations; 
						yourself)].
	allowedToNotePresentationsChanged := true.

]

{ #category : #accessing }
GLMPane >> port: aSymbol [
	^ ports detect: [ :each | each name = aSymbol ] ifNone: [
		ports addLast: (
			(self class portClass new) 
						pane: self; 
						name: aSymbol; 
						yourself) ]
]

{ #category : #private }
GLMPane >> portEvent: aPortEvent [

	"we unregister all presentations from announcements because they will get replaced anyway"
	aPortEvent portName = #entity ifTrue: [ self unregisterFromAllAnnouncements ].
	self browser innerPortEvent: aPortEvent.
	self presentations withAllDo: [ :each | each outerPortEvent: aPortEvent ]
]

{ #category : #accessing }
GLMPane >> ports [
	^ ports
]

{ #category : #copying }
GLMPane >> postCopy [
	| newPort |
	super postCopy.
	ports := ports collect: [:each | 
		newPort := each copy.
		newPort pane: self.
		self flag: 'what about value?'.
		newPort ]
]

{ #category : #accessing }
GLMPane >> presentations [
	^ presentations
]

{ #category : #accessing }
GLMPane >> presentations: aCompositePresentation [
	self notingPresentationChangeDo: [
		presentations pane: nil.
		presentations resetAnnouncer.
		aCompositePresentation withAllDo: [:each | each pane: self].
		presentations := aCompositePresentation ]
]

{ #category : #printing }
GLMPane >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self identityHash printString;
		nextPutAll: ' ', self name;
		nextPut: $)
]

{ #category : #rendering }
GLMPane >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderPane: self
]

{ #category : #updating }
GLMPane >> unregisterFromAllAnnouncements [
	self presentations unregisterFromAllAnnouncements
]

{ #category : #announcements }
GLMPane >> whenMatchingPresentationsChanged: aBlock [ 
	 
	^self when: GLMMatchingPresentationsChanged do: aBlock
]

{ #category : #announcements }
GLMPane >> whenPresentationsChanged: aBlock [ 
	 
	^self when: GLMPresentationsChanged do: aBlock
]

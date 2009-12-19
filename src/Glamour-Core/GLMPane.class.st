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
	#superclass : #Announcer,
	#instVars : [
		'browser',
		'name',
		'presentations',
		'ports',
		'lastActivePresentation'
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
	 
	self 
		notingPresentationChangeDo: 
			[presentations 
				addLast: 
					(aPresentation 
						pane: self; 
						yourself)]
]

{ #category : #accessing }
GLMPane >> addPresentations: aCollection [
	self notingPresentationChangeDo: [
		aCollection do: [ :each |  
			presentations addLast: (each pane: self; yourself) ] ]
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
GLMPane >> clearIn: aContext [ 

	self notingPresentationChangeDo: [presentations := OrderedCollection new]. 
	self ports do: [:each | each value: nil in: aContext]
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
GLMPane >> initializeIn: aBrowser [ 
	
	self initializeNamed: self defaultName in: aBrowser
]

{ #category : #initialization }
GLMPane >> initializeNamed: aString [ 
	self initializeNamed: aString in: GLMNoBrowser new  
]

{ #category : #initialization }
GLMPane >> initializeNamed: aString in: aBrowser [ 
	name := aString ifNil: [ self defaultName ].
	browser := aBrowser.
	ports := OrderedCollection new.
	presentations := OrderedCollection new.
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
	 
	^presentations select: [:each | each matches]
]

{ #category : #accessing }
GLMPane >> name [ 
	 
	^name
]

{ #category : #private }
GLMPane >> notingPresentationChangeDo: aBlock [
	| oldPresentations oldMatchingPresentations | 
	oldPresentations := self presentations copy. 
	oldMatchingPresentations := self matchingPresentations. 
	aBlock value. 
	self presentations ~= oldPresentations ifTrue: [
		self announce: ((GLMPresentationsChanged new) 
						pane: self; 
						oldPresentations: oldPresentations; 
						yourself)]. 
	self matchingPresentations ~= oldMatchingPresentations ifTrue: [
		self announce: ((GLMMatchingPresentationsChanged new) 
						pane: self; 
						oldMatchingPresentations: oldMatchingPresentations; 
						yourself)]
]

{ #category : #accessing }
GLMPane >> port: aSymbol [ 
	 
	^ports 
		detect: [:each | each name = aSymbol] 
		ifNone: 
			[ports 
				addLast: 
					((self class portClass new) 
						pane: self; 
						name: aSymbol; 
						yourself)]
]

{ #category : #private }
GLMPane >> portEvent: aPortEvent [
	self browser innerPortEvent: aPortEvent.
	self presentations do: [:each | each outerPortEvent: aPortEvent]
]

{ #category : #accessing }
GLMPane >> ports [ 
	 
	^OrderedCollection withAll: ports
]

{ #category : #private }
GLMPane >> postCopy [ 
	 
	super postCopy
]

{ #category : #accessing }
GLMPane >> presentations [ 
	 
	^OrderedCollection withAll: presentations
]

{ #category : #printing }
GLMPane >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self name;
		nextPut: $)
]

{ #category : #rendering }
GLMPane >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderPane: self
]

{ #category : #announcements }
GLMPane >> whenMatchingPresentationsChanged: aBlock [ 
	 
	^self when: GLMMatchingPresentationsChanged do: aBlock
]

{ #category : #announcements }
GLMPane >> whenPresentationsChanged: aBlock [ 
	 
	^self when: GLMPresentationsChanged do: aBlock
]

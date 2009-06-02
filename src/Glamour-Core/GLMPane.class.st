Class {
	#name : #GLMPane,
	#superclass : #Announcer,
	#instVars : [
		'browser',
		'name',
		'presentations',
		'ports'
	],
	#category : #'Glamour-Core'
}

{ #category : #'as yet unclassified' }
GLMPane class >> browser: aBrowser [ 
	
	^self new initializeBrowser: aBrowser
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
			[self presentations 
				addLast: 
					(aPresentation 
						pane: self; 
						yourself)]
]

{ #category : #accessing }
GLMPane >> addPresentations: aCollection [ 
	 
	self 
		notingPresentationChangeDo: 
			[aCollection 
				do: 
					[:each |  
					self presentations 
						addLast: 
							(each 
								pane: self; 
								yourself)]]
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
GLMPane >> clear [ 
	 
	self notingPresentationChangeDo: [presentations := nil]. 
	self ports do: [:each | each value: nil]
]

{ #category : #testing }
GLMPane >> hasBrowser [ 
	 
	^self browser isNil not
]

{ #category : #initialization }
GLMPane >> initializeBrowser: aBrowser [ 
	
	self initializeNamed: 'undefined' in: aBrowser
]

{ #category : #initialization }
GLMPane >> initializeNamed: aString [ 
	self initializeNamed: aString in: GLMNoBrowser new  
]

{ #category : #initialization }
GLMPane >> initializeNamed: aString in: aBrowser [ 
	name := aString.
	browser := aBrowser.
	ports := OrderedCollection new.
	presentations := OrderedCollection new.
]

{ #category : #accessing }
GLMPane >> matchingPresentations [ 
	 
	^self presentations select: [:each | each matches]
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
	self presentations ~= oldPresentations 
		ifTrue: 
			[self 
				announce: 
					((GLMPresentationsChanged new) 
						pane: self; 
						oldPresentations: oldPresentations; 
						yourself)]. 
	self matchingPresentations ~= oldMatchingPresentations 
		ifTrue: 
			[self 
				announce: 
					((GLMMatchingPresentationsChanged new) 
						pane: self; 
						oldMatchingPresentations: oldMatchingPresentations; 
						yourself)]
]

{ #category : #accessing }
GLMPane >> port: aSymbol [ 
	 
	^self ports 
		detect: [:each | each name = aSymbol] 
		ifNone: 
			[self ports 
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
	 
	^ports ifNil: [ports := OrderedCollection new]
]

{ #category : #private }
GLMPane >> postCopy [ 
	 
	super postCopy
]

{ #category : #accessing }
GLMPane >> presentations [ 
	 
	^presentations ifNil: [presentations := OrderedCollection new]
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

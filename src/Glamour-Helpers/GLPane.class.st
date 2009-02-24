Class {
	#name : #GLPane,
	#superclass : #Announcer,
	#instVars : [
		'browser',
		'name',
		'presentations',
		'ports'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLPane class >> browserIcon [
	
	^ListIconLibrary visualFor: #glamourPane
]

{ #category : #private }
GLPane class >> portClass [
	
	^GLPanePort
]

{ #category : #accessing }
GLPane >> addPresentation: aPresentation [
	
	self
		notingPresentationChangeDo:
			[self presentations
				addLast:
					(aPresentation
						pane: self;
						yourself)]
]

{ #category : #accessing }
GLPane >> addPresentations: aCollection [
	
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
GLPane >> asGlamorousPane [
	
	^self
]

{ #category : #accessing }
GLPane >> browser [
	
	^browser
]

{ #category : #accessing }
GLPane >> browser: aBrowser [
	
	browser := aBrowser
]

{ #category : #accessing }
GLPane >> clear [
	
	self notingPresentationChangeDo: [presentations := nil].
	self ports do: [:each | each value: nil]
]

{ #category : #testing }
GLPane >> hasBrowser [
	
	^self browser isNil not
]

{ #category : #accessing }
GLPane >> matchingPresentations [
	
	^self presentations select: [:each | each matches]
]

{ #category : #accessing }
GLPane >> name [
	
	^name
]

{ #category : #accessing }
GLPane >> name: aSymbol [
	
	name := aSymbol
]

{ #category : #private }
GLPane >> notingPresentationChangeDo: aBlock [
	
	| oldPresentations oldMatchingPresentations |
	oldPresentations := self presentations copy.
	oldMatchingPresentations := self matchingPresentations.
	aBlock value.
	self presentations ~= oldPresentations
		ifTrue:
			[self
				announce:
					((GLPresentationsChanged new)
						pane: self;
						oldPresentations: oldPresentations;
						yourself)].
	self matchingPresentations ~= oldMatchingPresentations
		ifTrue:
			[self
				announce:
					((GLMatchingPresentationsChanged new)
						pane: self;
						oldMatchingPresentations: oldMatchingPresentations;
						yourself)]
]

{ #category : #accessing }
GLPane >> port: aSymbol [
	
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
GLPane >> portEvent: aPortEvent [
	
	self hasBrowser ifTrue: [self browser innerPortEvent: aPortEvent].
	self presentations do: [:each | each outerPortEvent: aPortEvent]
]

{ #category : #accessing }
GLPane >> ports [
	
	^ports ifNil: [ports := OrderedCollection new]
]

{ #category : #private }
GLPane >> postCopy [
	
	super postCopy
]

{ #category : #accessing }
GLPane >> presentations [
	
	^presentations ifNil: [presentations := OrderedCollection new]
]

{ #category : #rendering }
GLPane >> renderGlamorouslyOn: aRenderer [
	
	^aRenderer renderPane: self
]

{ #category : #announcements }
GLPane >> whenMatchingPresentationsChanged: aBlock [
	
	^self on: GLMatchingPresentationsChanged do: aBlock
]

{ #category : #announcements }
GLPane >> whenPresentationsChanged: aBlock [
	
	^self on: GLPresentationsChanged do: aBlock
]

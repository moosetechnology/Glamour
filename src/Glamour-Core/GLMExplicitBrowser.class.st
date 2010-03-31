"
A GLMExplicitBrowser is a browser that allows the user to explicitly define the panes and the flow of transmissions between them.
"
Class {
	#name : #GLMExplicitBrowser,
	#superclass : #GLMBrowser,
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMExplicitBrowser >> addNewPane [
	
	^self addNewPaneNamed: 'undefined'
]

{ #category : #accessing }
GLMExplicitBrowser >> addNewPaneNamed: aString [
	^ self addPane: (GLMPane named: aString in: self)
]

{ #category : #accessing }
GLMExplicitBrowser >> addTransmission: aTransmission [ 
	 
	^ self transmissions addLast: aTransmission
]

{ #category : #events }
GLMExplicitBrowser >> innerPortEvent: aPortEvent [ 
	| wantedTransmissions |
	aPortEvent hasChanged ifTrue: [
		wantedTransmissions := self transmissions select: [:each | 
			( each originatesAt: aPortEvent port ) and: [
				( aPortEvent transmissionContext includesPort: each destination ) not ]].
		wantedTransmissions do: [ :each | each transmitIn: aPortEvent transmissionContext copy ]]
]

{ #category : #accessing }
GLMExplicitBrowser >> lastTransmission [
	^ self transmissions last
]

{ #category : #accessing }
GLMExplicitBrowser >> paneNamed: aSymbol [ 
	 
	^self panes detect: [:each | each name = aSymbol]
]

{ #category : #accessing }
GLMExplicitBrowser >> updateContextWith: aPane [ 

]

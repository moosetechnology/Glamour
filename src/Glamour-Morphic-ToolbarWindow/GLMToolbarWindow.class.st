"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	contentMorph:		<Object>
	toolbarMorph:		<Object>


    Implementation Points
"
Class {
	#name : #GLMToolbarWindow,
	#superclass : #GLMSystemWindow,
	#instVars : [
		'contentMorph',
		'toolbarMorph'
	],
	#category : #'Glamour-Morphic-ToolbarWindow'
}

{ #category : #accessing }
GLMToolbarWindow >> contentMorph [
	^ contentMorph
]

{ #category : #accessing }
GLMToolbarWindow >> contentMorph: anObject [
	contentMorph := anObject
]

{ #category : #'open/close' }
GLMToolbarWindow >> delete [
	self isDisplayed ifFalse: [ ^ self ].
	super delete
]

{ #category : #accessing }
GLMToolbarWindow >> disable [ 
	"Adds a 'disabling' morph on top"
	self isEnabled ifFalse: [ ^ self ].
	
	self releaseFocusIfContained.
	self contentMorph addMorphFront: (Morph new
		color: (self theme backgroundColor alpha: 0.9);
		layoutFrame: LayoutFrame identity;
		hResizing: #spaceFill; 
		vResizing: #spaceFill;
		setProperty: #disabledArea toValue: true;
		beSticky;
		yourself)
]

{ #category : #accessing }
GLMToolbarWindow >> enable [ 
	"Assumes that frst morph is a disabling morph and removes it"
	self isEnabled ifTrue: [ ^ self ].
	self contentMorph submorphs first delete

]

{ #category : #'open/close' }
GLMToolbarWindow >> ensureShown [
	| currentPosition |
	self isDisplayed ifTrue: [ ^ self ].
	currentPosition := self position.
	self openAsIs.
	self position: currentPosition. "Restore position to ensure is displayed correctly"
	self announce: (WindowOpened new window: self)
]

{ #category : #initialization }
GLMToolbarWindow >> initialize [
	super initialize.
	"self removeBoxes"
]

{ #category : #testing }
GLMToolbarWindow >> isEnabled [
	^ self contentMorph submorphs isEmpty 
		or: [ ((self contentMorph submorphs first valueOfProperty: #disabledArea) = true) not ]
]

{ #category : #'open/close' }
GLMToolbarWindow >> open [
	super open.
	self announce: (WindowOpened new window: self)	
]

{ #category : #initialization }
GLMToolbarWindow >> removeBoxes [
	expandBox ifNotNil: [expandBox delete. expandBox := nil].
	collapseBox ifNotNil: [collapseBox delete. collapseBox := nil]
]

{ #category : #'open/close' }
GLMToolbarWindow >> silentlyShown [
	| currentPosition |
	self isDisplayed ifTrue: [ ^ self ].
	currentPosition := self position.
	self openAsIs.
	self position: currentPosition. "Restore position to ensure is displayed correctly"
]

{ #category : #'open/close' }
GLMToolbarWindow >> sleep [
	self disable
]

{ #category : #accessing }
GLMToolbarWindow >> toolbarMorph [
	^ toolbarMorph
]

{ #category : #accessing }
GLMToolbarWindow >> toolbarMorph: anObject [
	toolbarMorph := anObject
]

{ #category : #'open/close' }
GLMToolbarWindow >> wakeUp [
	self silentlyShown.
	self enable
]

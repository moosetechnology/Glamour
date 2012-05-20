"
This morph is used as support for the watcher (quick preview) behavior.

GLMWatcherWindow uniqueInstance openInWorld.
GLMWatcherWindow reset.
"
Class {
	#name : #GLMWatcherWindow,
	#superclass : #SystemWindow,
	#instVars : [
		'isOpen',
		'contentsMorph'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #'instance creation' }
GLMWatcherWindow class >> buildKeymapsOn: aBuilder [
	<keymap>
	
	(aBuilder shortcut: #openGlamourWatcher) 
		category: #Glamour
		default: Character space ctrl shift 
		do: [ :morph | self uniqueInstance toggleOpen ].

	aBuilder attachShortcutCategory: #Glamour to: Morph.
]

{ #category : #'instance creation' }
GLMWatcherWindow class >> reset [ 
	"self reset"
	uniqueInstance := nil
]

{ #category : #'instance creation' }
GLMWatcherWindow class >> uniqueInstance [ 
	^ uniqueInstance ifNil: [uniqueInstance := self new]
]

{ #category : #settings }
GLMWatcherWindow >> activeFillStyle [
	"Return the active title fillStyle for the receiver."
	
	^ SolidFillStyle color: (Color gray alpha: 0.6)
]

{ #category : #settings }
GLMWatcherWindow >> activeTitleFillStyle [
	"Return the active title fillStyle for the receiver."
	
	^ SolidFillStyle color: Color transparent
]

{ #category : #initialize }
GLMWatcherWindow >> addContentsMorph [
	self contentsMorph: GLMMorphic emptyMorph.
	self contentsMorph
		layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1) offsets: (10@10 corner: -10@(-10)));
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	self addMorphBack: self contentsMorph
]

{ #category : #accessing }
GLMWatcherWindow >> contentsMorph [
	^ contentsMorph
]

{ #category : #accessing }
GLMWatcherWindow >> contentsMorph: anObject [
	contentsMorph := anObject
]

{ #category : #initialize }
GLMWatcherWindow >> defaultBorderStyle [
	^ FillStyleBorder color: (Color white twiceDarker alpha: 0.2) width: 10
]

{ #category : #initialize }
GLMWatcherWindow >> defaultFillStyle [
	^ SolidFillStyle color: Color transparent
]

{ #category : #'open/close' }
GLMWatcherWindow >> delete [ 
	super delete. 
	isOpen := false
]

{ #category : #initialize }
GLMWatcherWindow >> fastFramingOn [

	^self theme settings fastDragging and: [self isFlexed not]
]

{ #category : #settings }
GLMWatcherWindow >> inactiveFillStyle [
	"Return the active title fillStyle for the receiver."
	
	^ SolidFillStyle color: (Color gray alpha: 0.6)
]

{ #category : #settings }
GLMWatcherWindow >> inactiveTitleFillStyle [
	"Return the active title fillStyle for the receiver."
	
	^ SolidFillStyle color: Color transparent
]

{ #category : #initialize }
GLMWatcherWindow >> initialize [
	super initialize.
	self fillStyle: self defaultFillStyle.
"	self borderStyle: self defaultBorderStyle."
	isOpen := false.
	self setLabel: 'Glamorous Watcher'.
	self addCornerGrips.
	self addEdgeGrips.
	self addContentsMorph.
	self
		on: Character escape
		do: [ self hide ]
]

{ #category : #accessing }
GLMWatcherWindow >> morphicLayerNumber [
	"We want this preview to be always on top"
	
	^ 10
]

{ #category : #'open/close' }
GLMWatcherWindow >> openInWorld [
	super openInWorld.
	isOpen := true.

]

{ #category : #'open/close' }
GLMWatcherWindow >> toggleOpen [ 
	isOpen ifFalse: [ ^ self openInWorld ].
	self visible ifTrue: [self hide] ifFalse: [self show]
]

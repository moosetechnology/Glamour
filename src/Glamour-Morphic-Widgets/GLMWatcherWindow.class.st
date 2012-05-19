"
This morph is used as support for the watcher (quick preview) behavior.

GLMWatcherWindow uniqueInstance openInWorld.
GLMWatcherWindow reset.
"
Class {
	#name : #GLMWatcherWindow,
	#superclass : #SystemWindow,
	#instVars : [
		'isOpen'
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

	aBuilder attachShortcutCategory:  #Glamour to: Morph.
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

{ #category : #'open/close' }
GLMWatcherWindow >> delete [ 
	super delete. 
	isOpen := false
]

{ #category : #initialize }
GLMWatcherWindow >> initialize [ 
	super initialize.
	self initializeStyle.
	isOpen := false.
	
	self 
		on: Character escape 
		do: [ self delete ]
]

{ #category : #initialize }
GLMWatcherWindow >> initializeStyle [
		
	self fillStyle: (SolidFillStyle color: (Color transparent)).
	self borderStyle: (FillStyleBorder color: (Color white twiceDarker alpha: 0.2) width: 10)
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
	isOpen 
		ifTrue: [ self delete ]
		ifFalse: [ self openInWorld ].
]

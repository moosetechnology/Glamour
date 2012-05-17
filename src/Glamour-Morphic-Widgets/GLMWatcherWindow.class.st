"
GLMWatcherWindow uniqueInstance openInWorld.
GLMWatcherWindow reset.
"
Class {
	#name : #GLMWatcherWindow,
	#superclass : #StandardWindow,
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
	isOpen := false.
	
	self 
		on: Character escape 
		do: [ self delete ]
]

{ #category : #'open/close' }
GLMWatcherWindow >> openInWorld [
	super openInWorld.
"	self submorphs last takeKeyboardFocus.
"	isOpen := true.

]

{ #category : #'open/close' }
GLMWatcherWindow >> toggleOpen [ 
	isOpen 
		ifTrue: [ self delete ]
		ifFalse: [ self openInWorld ].
]

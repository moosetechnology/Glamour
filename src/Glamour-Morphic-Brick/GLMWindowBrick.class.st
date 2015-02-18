Class {
	#name : #GLMWindowBrick,
	#superclass : #GLMFoundationBrick,
	#instVars : [
		'activeOnlyOnTop',
		'isCollapsed',
		'label',
		'labelString'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Windows'
}

{ #category : #examples }
GLMWindowBrick class >> example [
	|foundation brick|
	brick := GLMBrick new.
	brick
		color: Color lightBlue;
		vSpaceFill;
		hSpaceFill.
		
	foundation := self new.
	foundation
		color: Color white;
		addBrickBack: brick;
		extent: 400@400;
		openInWorld
	
]

{ #category : #accessing }
GLMWindowBrick >> activeOnlyOnTop [

	^ activeOnlyOnTop ifNil: [ activeOnlyOnTop := false ]
]

{ #category : #announce }
GLMWindowBrick >> announce: anAnnouncement [
	"announcer is lazy initialized. If announcer is not set, this means that there is no listener, no need to propagate the announcement therefore"
	
	anAnnouncement window: self.
	^ self announcer announce: anAnnouncement
]

{ #category : #taskbar }
GLMWindowBrick >> collapseBoxHit [
	"The user has clicked on the collapse box.
	Collapse or expand the receiver as appropriate."
	
	"self isCollapsed
		ifTrue: [ self playRestoreUpSound ]
		ifFalse: [ self playMinimizeSound ]."
	self collapseOrExpand
]

{ #category : #taskbar }
GLMWindowBrick >> collapseOrExpand [
	"Collapse or expand the window, depending on existing state.
	Use the taskbar if present, otherwise do as normal."
	
	self isTaskbarPresent ifTrue: [^self minimizeOrRestore].
	isCollapsed
		ifTrue: 
			["Expand -- restore panes to morphics structure"
			isCollapsed := false.
			self activate.  "Bring to frint first" ]
		ifFalse: 
			["Collapse -- remove panes from morphics structure"
			isCollapsed := true ].
	self layoutChanged.
	
	self announce: 
		(WindowCollapsed new
			window: self;
			yourself).
]

{ #category : #testing }
GLMWindowBrick >> isActive [
	"Answer active if no owner too to avoid color flickering."
	
	self owner ifNil: [ ^ true ].
	self activeOnlyOnTop ifTrue: [ ^ self owner isWindowActive: self ].
	^ true
]

{ #category : #testing }
GLMWindowBrick >> isCollapsed [

	^ isCollapsed ifNil: [ isCollapsed := false ]
]

{ #category : #testing }
GLMWindowBrick >> isMaximized [

	^ false
]

{ #category : #testing }
GLMWindowBrick >> isMinimized [
	"Answer whether we are minimised."

	^ self isCollapsed
]

{ #category : #taskbar }
GLMWindowBrick >> isTaskbarPresent [
	"Answer whether there is a taskbar in the world."

	^ self worldTaskbar notNil
]

{ #category : #accessing }
GLMWindowBrick >> labelString [
	"Answer the actual label string."

	^ labelString ifNil: [ labelString := 'Brick Window' ]
]

{ #category : #taskbar }
GLMWindowBrick >> minimize [
	"Minimise the receiver."

	self isMinimized ifFalse: [ self collapseBoxHit ]
]

{ #category : #taskbar }
GLMWindowBrick >> minimizeOrRestore [
	"Collapse or expand the window, depending on existing state"
	
	| windowEvent |
	isCollapsed
		ifTrue: ["Expand -- restore panes to morphics structure"
			isCollapsed := false.
			"Bring to front first"
			self
				comeToFront;
				show;
				activate ]
		ifFalse: ["Collapse -- remove panes from morphics structure"
			isCollapsed := true.
			self
				hide.
			self isActive ifTrue: [
				self world navigateVisibleWindowForward]].
	self layoutChanged.
	
	"This gets invoked only if the taskbar is present, see sender of minimizeOrRestore"
	windowEvent := 
		self isMinimized 
			ifTrue: [ WindowCollapsed new ]
			ifFalse: [ WindowExpanded new ].

	windowEvent window: self.
	self announce: windowEvent.
]

{ #category : #taskbar }
GLMWindowBrick >> restore [
	"Restore the receiver's normal size."

	self isMinimized
		ifTrue: [ self collapseBoxHit ]
		ifFalse: [self isMaximized ifTrue: [ self expandBoxHit ] ]
]

{ #category : #taskbar }
GLMWindowBrick >> taskbarButtonClicked [
	"The taskbar button for the receiver has been clicked.
	If minimised then restore.
	If active then minimize.
	Otherwise make active."

	self isMinimized
		ifTrue: [ self restore ]
		ifFalse: [self isActive
					ifTrue: [ self minimize ]
					ifFalse: [ self activate ] ]
]

{ #category : #taskbar }
GLMWindowBrick >> taskbarButtonFor: aTaskbar [
	"Answer a new task bar button for the receiver.
	Answer nil if not required."
	|button|
	button := GLMTaskbarButtonBrick new for: self taskbar: aTaskbar.
	button height: 24.
	button doLayoutForce.
	
	^ button
		asBrickedMorph
			extent: button width @ 24
]

{ #category : #taskbar }
GLMWindowBrick >> taskbarIcon [
	"Answer the icon for the receiver in a task bar."

	^ Smalltalk ui icons smallWindowIcon
]

{ #category : #taskbar }
GLMWindowBrick >> taskbarLabel [
	"Answer the label to use for a taskbar button for the receiver."

	^ label isNil
		ifTrue: [ self labelString ]
		ifFalse: [ label contents asString ]
]

{ #category : #taskbar }
GLMWindowBrick >> taskbarState [
	"Answer one of #minimized, #restored, #maximized or #active."

	^ self isMinimized
		ifTrue: [ #minimized ]
		ifFalse: [ self isMaximized
			ifTrue: [ #maximized ]
			ifFalse: [ self isActive
						ifTrue: [ #active ]
						ifFalse: [ #restored ] ] ]
]

{ #category : #taskbar }
GLMWindowBrick >> taskbarTask [
	"Answer a new taskbar task for the receiver.
	Answer nil if not required."

	(self valueOfProperty: #noTaskbarTask ifAbsent: [ false ]) ifTrue: [ ^ nil ].
	^ TaskbarTask
		morph: self
		state: self taskbarState
		icon: self taskbarIcon
		label: self taskbarLabel
]

{ #category : #taskbar }
GLMWindowBrick >> worldTaskbar [
	"Answer the world taskbar or nil if none."

	^ self world submorphThat: [ :m | m isTaskbar ] ifNone: [ ] 
]

Class {
	#name : #GLMCheckboxBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'labelBrick',
		'checkBrick'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #examples }
GLMCheckboxBrick class >> example [
	<example: 'Simple checkbox'>
	^ GLMCheckboxBrick new
		color: Color white;
		vShrinkWrap;
		hShrinkWrap
]

{ #category : #examples }
GLMCheckboxBrick class >> exampleInWindow [

	(GLMBrick new
		addBrickBack: (self exampleWithLabel);
		yourself)
			asBrickedMorph
			extent: 300@50;
			openInWindow
]

{ #category : #examples }
GLMCheckboxBrick class >> exampleWithLabel [
	<example: 'Checkbox with label'>
	^ GLMCheckboxBrick new
		text: 'Send only anonymous usage data';
		color: Color white;
		vShrinkWrap;
		hShrinkWrap
]

{ #category : #accessing }
GLMCheckboxBrick >> box [

	^ checkBrick
]

{ #category : #actions }
GLMCheckboxBrick >> check [
	self box check.
	self label check.
	super check
]

{ #category : #accessing }
GLMCheckboxBrick >> checkBrick: anObject [
	checkBrick := anObject.
	self box
		borderColor: Color lightGray;
		borderWidth: 2;
		vAlign: #center;
		checkedImage: GLMUIThemeExtraIcons glamorousAccept;
		width: 20;
		height: 20.
		
	self addBrickFirst: self box
]

{ #category : #actions }
GLMCheckboxBrick >> click: evt [

	self toggle.
	^ true
]

{ #category : #actions }
GLMCheckboxBrick >> deselect: anEvent [
	super deselect: anEvent.
	self box deselect: anEvent.
	self label deselect: anEvent
]

{ #category : #'brick-layout-properties' }
GLMCheckboxBrick >> hShrinkWrap [
	super hShrinkWrap.
	
	self label hShrinkWrap
]

{ #category : #'brick-layout-properties' }
GLMCheckboxBrick >> hSpaceFill [
	super hSpaceFill.
	
	self label hSpaceFill
]

{ #category : #initialization }
GLMCheckboxBrick >> initialize [
	super initialize.
	
	self
		checkBrick: self newCheckboxBrick;
		labelBrick: self newLabelBrick;
		useHorizontalLinearLayout;
		enable
]

{ #category : #accessing }
GLMCheckboxBrick >> label [

	^ labelBrick
]

{ #category : #accessing }
GLMCheckboxBrick >> labelBrick: anObject [
	labelBrick := anObject.
	
	labelBrick
		vAlign: #center;
		marginLeft: 5;
		textPosition: #leftCenter.
]

{ #category : #'instance creation' }
GLMCheckboxBrick >> newCheckboxBrick [

	^ GLMInteractableBrick new
]

{ #category : #'instance creation' }
GLMCheckboxBrick >> newLabelBrick [

	^ GLMLabelBrick new
]

{ #category : #actions }
GLMCheckboxBrick >> select: anEvent [
	super select: anEvent.
	self box select: anEvent.
	self label select: anEvent
]

{ #category : #accessing }
GLMCheckboxBrick >> text: aString [

	self label text: aString.
	self label text isEmpty
			ifTrue: [ self removeBrick: self label ]
			ifFalse: [ (self hasSubbrick: self label)
				ifFalse: [ self addBrickBack: self label ] ]
]

{ #category : #actions }
GLMCheckboxBrick >> toggle [

	self isChecked
		ifTrue: [ self uncheck ]
		ifFalse: [ self check ]
]

{ #category : #actions }
GLMCheckboxBrick >> uncheck [
	self box uncheck.
	self label uncheck.
	super uncheck
]

{ #category : #'brick-layout-properties' }
GLMCheckboxBrick >> vShrinkWrap [
	super vShrinkWrap.
	
	self label vShrinkWrap
]

{ #category : #'brick-layout-properties' }
GLMCheckboxBrick >> vSpaceFill [
	super vSpaceFill.
	
	self label vSpaceFill
]

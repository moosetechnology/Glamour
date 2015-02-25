"
A GLMButtonBrick is a simple button with support of icons.

Instance Variables
	iconBrick:		<GLMInteractableBrick>
	labelBrick:		<GLMLabelBrick>

iconBrick
	- xxxxx

labelBrick
	- xxxxx

"
Class {
	#name : #GLMButtonBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'iconBrick',
		'labelBrick'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Basic'
}

{ #category : #examples }
GLMButtonBrick class >> example [
	<example: 'Simple button'>
	^ self new
]

{ #category : #examples }
GLMButtonBrick class >> exampleInWindow [

	(GLMBrick new
		addBrickBack: self example;
		yourself)
			openInBrickWindow
]

{ #category : #actions }
GLMButtonBrick >> click: evt [

	super click: evt.
	^ true
]

{ #category : #'brick-layout-properties' }
GLMButtonBrick >> hShrinkWrap [
	super hShrinkWrap.
	
	self label hShrinkWrap
]

{ #category : #'brick-layout-properties' }
GLMButtonBrick >> hSpaceFill [
	super hSpaceFill.
	
	self label hSpaceFill
]

{ #category : #'button-brick-accessing' }
GLMButtonBrick >> icon [

	^ iconBrick
]

{ #category : #'button-brick-accessing' }
GLMButtonBrick >> iconBrick: anObject [
	iconBrick := anObject
]

{ #category : #initialization }
GLMButtonBrick >> initialize [
	super initialize.
	
	self
		enable;
		labelBrick: self newLabelBrick;
		hShrinkWrap;
		vShrinkWrap
]

{ #category : #'button-brick-accessing' }
GLMButtonBrick >> label [

	^ labelBrick
]

{ #category : #'button-brick-accessing' }
GLMButtonBrick >> labelBrick: anObject [
	labelBrick := anObject.
	
	self label
		vShrinkWrap;
		hShrinkWrap;
		text: 'button';
		vAlign: #center;
		hAlign: #center.
	
	self addBrickBack: self label
]

{ #category : #'button-brick-creation' }
GLMButtonBrick >> newLabelBrick [

	^ GLMLabelBrick new
]

{ #category : #'brick-properties-events' }
GLMButtonBrick >> onThemerChanged [
	super onThemerChanged.

	self updateStyle
]

{ #category : #'brick-properties' }
GLMButtonBrick >> text [

	^ self label text
]

{ #category : #'brick-properties' }
GLMButtonBrick >> text: aString [

	self label text: aString.
	self label label doLayoutForce
]

{ #category : #'button-updating' }
GLMButtonBrick >> updateStyle [

	self borderWidth: self themer buttonBorderWidth.
	self borderColor: self themer buttonBorderColor.
	self padding: self themer buttonPadding.
	self normalColor: self themer buttonBackgroundColor.
	self selectedColor: self themer buttonSelectedColor.
	self pressedColor: self themer buttonPressedColor.
	self minWidth: self themer buttonMinWidth.
	self minHeight: self themer buttonMinHeight.
	self doLayoutForce
	
]

{ #category : #'brick-layout-properties' }
GLMButtonBrick >> vShrinkWrap [
	super vShrinkWrap.
	
	self label vShrinkWrap
]

{ #category : #'brick-layout-properties' }
GLMButtonBrick >> vSpaceFill [
	super vSpaceFill.
	
	self label vSpaceFill
]

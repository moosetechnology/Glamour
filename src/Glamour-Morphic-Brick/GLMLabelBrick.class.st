"
A GLMLabelBrick is standard label Brick, that can shrink text if it's size becomes smaller then actual text size.

Text shrinking works out of box, you don't need to do anything

Instance Variables
	dotsBrick		<GLMStringBrick>
	isDotsAdded:		<boolean>
	stringBrick rick		<GLMStringBrick>

dotsBrick
	- represents a Brick that is added at the end of the text when Brick's size becomes smaller than actual text size

isDotsAdded
	- true if dotsBrick is currently added visible, false otherwise

stringBrick
	- represents actual label text Brick

"
Class {
	#name : #GLMLabelBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'isDotsAdded',
		'dotsBrick',
		'stringBrick'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Basic'
}

{ #category : #examples }
GLMLabelBrick class >> example [
	"this example must be called on my subclasses"
	| rootBrick brick1 brick2 brick3 |
	
	rootBrick := GLMInteractableBrick new
		useVerticalLinearLayout;
		height: 400;
		width: 400;
		enable;
		selectedColor: Color blue darker;
		color: Color blue;
		paddingLeft: 10;
		paddingTop: 15;
		paddingRight: 20;
		paddingBottom: 5.
	
	" ---- Creating first brick ---- "
	brick1 := GLMStringBrick new
		text: 'Welcome to Brick!';
		textColor: Color white;
		textPosition: #center;
		color: Color green;
		selectedColor: Color darkGray;
		normalColor: Color red;
		pressedColor: Color gray;
		enable;
		hSpaceFill: 30;
		height: 30.		
		
	" ---- Creating second brick ---- "
	brick2 := GLMInteractableBrick new
		color: Color green;
		selectedColor: Color pink;
		normalColor: Color green;
		pressedColor: Color lightGray;
		enable;
		margin: #(15 20 5 10);
		hSpaceFill: 50;
		vSpaceFill: 50.
		
		
	" ---- Creating third brick ---- "
	brick3 := GLMStringBrick new
		text: 'Welcome to Brick!';
		textColor: Color black;
		color: Color yellow;
		margin: #(15 20 5 10);
		hSpaceFill: 20;
		vSpaceFill: 20.
		
		
	" ---- Add them to the root brick ---- "
	rootBrick
		addBrickBack: brick1;
		addBrickBack: brick2;
		addBrickBack: brick3.
	
	rootBrick asBrickedMorph openInWindow
]

{ #category : #'brick-geometry' }
GLMLabelBrick >> approximateHeight [
	
	^ self label approximateHeight + self vMargin + self vPadding
]

{ #category : #'brick-geometry' }
GLMLabelBrick >> approximateWidth [
	
	^ self label approximateWidth + self hMargin + self hPadding
]

{ #category : #'label-brick-accessing' }
GLMLabelBrick >> contents: aStringOrText [

	self text: aStringOrText asString
]

{ #category : #'label-brick-default' }
GLMLabelBrick >> defaultDotsText [
	^ '...'
]

{ #category : #'label-brick-default' }
GLMLabelBrick >> defaultInsetBeforeDots [
	^ 1
]

{ #category : #'label-brick-accessing' }
GLMLabelBrick >> dotsBrick [

	^ dotsBrick
]

{ #category : #'brick-properties' }
GLMLabelBrick >> familyName: aString [

	self label familyName: aString.
	self dotsBrick familyName: aString
]

{ #category : #'brick-properties' }
GLMLabelBrick >> font: aLogicalFont [

	self label font: aLogicalFont.
	self dotsBrick font: aLogicalFont.
]

{ #category : #'brick-properties' }
GLMLabelBrick >> fontSize [

	^ self label fontSize
]

{ #category : #'brick-properties' }
GLMLabelBrick >> fontSize: aNumber [
	<brickBuilderProperty: #Text name: 'Font size' as: #asInteger getter: #fontSize model: #GLMUIBuilderTextFieldProperty>

	self label fontSize: aNumber.
	self dotsBrick fontSize: aNumber
]

{ #category : #'brick-layout-properties' }
GLMLabelBrick >> hShrinkWrap [
	super hShrinkWrap.
	
	self label hShrinkWrap.
	self dotsBrick hShrinkWrap.
]

{ #category : #'brick-layout-properties' }
GLMLabelBrick >> hSpaceFill [
	super hSpaceFill.
	
	self label hSpaceFill.
	self dotsBrick hShrinkWrap.
]

{ #category : #initialization }
GLMLabelBrick >> initialize [
	super initialize.
	
	stringBrick := self privateAddBrickBack: (
		self newStringBrick
			hSpaceFill;
			vSpaceFill;
			marginRight: self defaultInsetBeforeDots).
	
	"creating dots morph, that will be displayed when text is being clipped"
	dotsBrick := self newStringBrick.
	dotsBrick text: self defaultDotsText.
	dotsBrick fontSize: 9.
	dotsBrick width: [ :b | b approximateWidth ].
	dotsBrick vSpaceFill.
	
	isDotsAdded := false.
	
]

{ #category : #'label-brick-accessing' }
GLMLabelBrick >> isDotsAdded [
	^ isDotsAdded
]

{ #category : #'label-brick-accessing' }
GLMLabelBrick >> label [
	^ stringBrick
]

{ #category : #'label-brick-creation' }
GLMLabelBrick >> newStringBrick [
	^ GLMStringBrick new
]

{ #category : #'brick-properties' }
GLMLabelBrick >> text [
	^ self label text
]

{ #category : #'brick-properties' }
GLMLabelBrick >> text: aString [
	<brickBuilderProperty: #Text name: 'Text' as: #asString getter: #text model: #GLMUIBuilderTextFieldProperty>
	
	self label text: aString
]

{ #category : #'brick-properties' }
GLMLabelBrick >> textColor [

	^ self label textColor
]

{ #category : #'brick-properties' }
GLMLabelBrick >> textColor: aColor [
	<brickBuilderProperty: #Text name: 'Text color' as: #brickBuilderEvaluate getter: #textColor model: #GLMUIBuilderTextFieldProperty>

	self label textColor: aColor.
	self dotsBrick textColor: aColor
]

{ #category : #'brick-properties' }
GLMLabelBrick >> textPosition [

	^ self label textPosition
]

{ #category : #'brick-properties' }
GLMLabelBrick >> textPosition: aSymbol [
	<brickBuilderProperty: #Text name: 'Text position' as: #asSymbol getter: #textPosition model: #GLMUIBuilderTextFieldProperty>

	self label textPosition: aSymbol.
	self dotsBrick textPosition: aSymbol.
]

{ #category : #'brick-layout-properties' }
GLMLabelBrick >> vShrinkWrap [
	super vShrinkWrap.
	
	self label vShrinkWrap.
	self dotsBrick vShrinkWrap
]

{ #category : #'brick-layout-properties' }
GLMLabelBrick >> vSpaceFill [
	super vSpaceFill.
	
	self label vSpaceFill.
	self dotsBrick vShrinkWrap.
]

{ #category : #'brick-properties' }
GLMLabelBrick >> weightValue: anInteger [

	self label weightValue: anInteger.
	self dotsBrick weightValue: anInteger.
]

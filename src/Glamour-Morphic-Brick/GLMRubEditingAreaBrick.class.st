Class {
	#name : #GLMRubEditingAreaBrick,
	#superclass : #GLMRubScrolledTextBrick,
	#instVars : [
		'isLayouting'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #'as yet unclassified' }
GLMRubEditingAreaBrick class >> exampleBand [
	<example: 'Two rubric text areas in band'>
	
	(GLMBandBrick new
		color: Color lightRed;
		addAllBricks: { self new. self new })
			asBrickedMorph
				extent: 300@200;
				openInWindow
]

{ #category : #'as yet unclassified' }
GLMRubEditingAreaBrick class >> exampleScrollPane [
	<example: 'Two rubric text areas in scroll pane'>
	
	(GLMScrollPaneBrick new
		color: Color lightRed;
		addAllBricks: { self new. self new })
			asBrickedMorph
				extent: 300@200;
				openInWindow
]

{ #category : #initialization }
GLMRubEditingAreaBrick >> initialize [
	super initialize.
	
	self
		hSpaceFill.
	isLayouting := false
]

{ #category : #layout }
GLMRubEditingAreaBrick >> layoutChanged [
	super layoutChanged.
	
	self morph ifNil: [ ^ self ].
	
	isLayouting ifFalse: [
		isLayouting := true.
		self height: self morph height.
		isLayouting := false ]
]

{ #category : #'instance creation' }
GLMRubEditingAreaBrick >> newRubricMorph [

	^ RubEditingArea new beWrapped
]

{ #category : #'instance creation' }
GLMRubEditingAreaBrick >> on: aMorph [
	
	aMorph layoutProperties ifNil: [ 
		aMorph layoutProperties: GLMBrickLayoutProperties new ].

	morph := aMorph.
	
	self addBrickBack: morph.
	self height: self morph height.
]

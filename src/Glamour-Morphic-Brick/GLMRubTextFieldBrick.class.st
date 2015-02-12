Class {
	#name : #GLMRubTextFieldBrick,
	#superclass : #GLMRubScrolledTextBrick,
	#instVars : [
		'isLayouting'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #'as yet unclassified' }
GLMRubTextFieldBrick class >> exampleBand [
	<example: 'Two rubric text areas in band'>
	
	(GLMBandBrick new
		color: Color lightRed;
		addAllBricks: { self new. self new })
			asBrickedMorph
				extent: 300@200;
				openInWindow
]

{ #category : #'as yet unclassified' }
GLMRubTextFieldBrick class >> exampleScrollPane [
	<example: 'Two rubric text areas in scroll pane'>
	
	(GLMScrollPaneBrick new
		color: Color lightRed;
		addAllBricks: { self new. self new })
			asBrickedMorph
				extent: 300@200;
				openInWindow
]

{ #category : #'as yet unclassified' }
GLMRubTextFieldBrick >> initialize [
	super initialize.
	
	self hSpaceFill.
	isLayouting := false
]

{ #category : #'as yet unclassified' }
GLMRubTextFieldBrick >> layoutChanged [
	super layoutChanged.
	
	self morph ifNil: [ ^ self ].
	
	isLayouting ifFalse: [
		isLayouting := true.
		self height: self morph height.
		isLayouting := false ]
]

{ #category : #'instance creation' }
GLMRubTextFieldBrick >> newRubricMorph [

	^ RubEditingArea new beWrapped
]

{ #category : #'as yet unclassified' }
GLMRubTextFieldBrick >> on: aMorph [
	
	aMorph layoutProperties ifNil: [ 
		aMorph layoutProperties: GLMBrickLayoutProperties new ].

	morph := aMorph.
	
	self addBrickBack: morph
]

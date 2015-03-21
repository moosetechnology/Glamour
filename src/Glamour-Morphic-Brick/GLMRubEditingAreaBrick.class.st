Class {
	#name : #GLMRubEditingAreaBrick,
	#superclass : #GLMRubScrolledTextBrick,
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #examples }
GLMRubEditingAreaBrick class >> exampleBand [
	<example: 'Two rubric text areas in band'>
	
	^ GLMBandBrick new
		padding: #(20 20);
		hSpaceFill;
		vShrinkWrap;
		color: Color veryVeryLightGray;
		addAllBricks: { self new. self new };
		yourself
]

{ #category : #examples }
GLMRubEditingAreaBrick class >> exampleBandOpen [

	self exampleBand openInBrickWindow
]

{ #category : #examples }
GLMRubEditingAreaBrick class >> exampleScrollPane [
	<example: 'Two rubric text areas in scroll pane'>
	
	^ GLMScrollPaneBrick new
		hSpaceFill;
		vSpaceFill;
		color: Color veryVeryLightGray;
		layoutMorphs: true;
		addAllBricks: { self new. self new };
		yourself
]

{ #category : #examples }
GLMRubEditingAreaBrick class >> exampleScrollPaneOpen [
	
	self exampleScrollPane openInBrickWindowLabeled: 'Rubric in ScrollPane'
]

{ #category : #initialization }
GLMRubEditingAreaBrick >> initialize [
	super initialize.
	
	self
		hSpaceFill;
		vShrinkWrap
]

{ #category : #'instance creation' }
GLMRubEditingAreaBrick >> newRubricMorph [

	^ RubEditingArea new beWrapped
]

{ #category : #'brick-properties' }
GLMRubEditingAreaBrick >> withoutBackground [

	self rubric color: Color transparent
]

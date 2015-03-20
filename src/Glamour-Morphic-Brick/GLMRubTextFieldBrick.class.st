Class {
	#name : #GLMRubTextFieldBrick,
	#superclass : #GLMRubScrolledTextBrick,
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #examples }
GLMRubTextFieldBrick class >> exampleShrinking [
	<example: 'Rubric text field shrinking height and width'>
	
	^ GLMBrick new
		padding: #(20 20);
		hShrinkWrap;
		vShrinkWrap;
		color: Color veryVeryLightGray;
		addBrickBack: (
			self new
				hShrinkWrap;
				vShrinkWrap;
				yourself);
		yourself
]

{ #category : #examples }
GLMRubTextFieldBrick class >> exampleShrinkingOpen [

	self exampleShrinking openCenteredInBrickWindow
]

{ #category : #'instance creation' }
GLMRubTextFieldBrick >> newRubricMorph [

	^ GLMRubTextFieldMorph new
]

{ #category : #'brick-geometry' }
GLMRubTextFieldBrick >> shrinkingWidth [

	self rubric width: self rubric textArea width.
	self onLayouted.
	^ self rubric textArea width
]

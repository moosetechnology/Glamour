"
A GLMRubScrolledTextBrick is a wrapper for rubric scrolled text morph, to allow simple integration of rubric text field in brick

Instance Variables
	rubricMorph:		<Object>

rubricMorph
	- xxxxx

"
Class {
	#name : #GLMRubScrolledTextBrick,
	#superclass : #GLMMorphBrick,
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #examples }
GLMRubScrolledTextBrick class >> example [
	<example: 'Two rubric text areas filling half of size'>
	
	^ GLMBrick new
		useVerticalLinearLayout;
		padding: #(20 20);
		hSpaceFill;
		vSpaceFill;
		color: Color veryVeryLightGray;
		addAllBricks: { self new vSpaceFill: 50. self new vSpaceFill: 50 };
		yourself
]

{ #category : #examples }
GLMRubScrolledTextBrick class >> exampleBand [
	<example: 'Two rubric text areas in band'>
	
	^ GLMBandBrick new
		padding: #(20 20);
		hSpaceFill;
		color: Color veryVeryLightGray;
		addAllBricks: { self new vShrinkWrap. self new vShrinkWrap};
		yourself
]

{ #category : #examples }
GLMRubScrolledTextBrick class >> exampleBandOpen [

	self exampleBand openInBrickWindow
]

{ #category : #examples }
GLMRubScrolledTextBrick class >> exampleOpen [

	self example openInBrickWindow
]

{ #category : #'reflective operations' }
GLMRubScrolledTextBrick >> doesNotUnderstand: aMessage [
	^ self rubric
		perform: aMessage selector 
		withArguments: aMessage arguments
]

{ #category : #initialization }
GLMRubScrolledTextBrick >> initialize [
	super initialize.
	
	self rubric: self newRubricMorph
]

{ #category : #'instance creation' }
GLMRubScrolledTextBrick >> newRubricMorph [

	^ RubScrolledTextMorph new
]

{ #category : #'brick-properties-events' }
GLMRubScrolledTextBrick >> onThemerChanged [

	self updateStyle
]

{ #category : #accessing }
GLMRubScrolledTextBrick >> rubric [

	^ self morph
]

{ #category : #accessing }
GLMRubScrolledTextBrick >> rubric: aMorph [

	self morph ifNotNil: [ self removeMorph: self morph ].
	self on: aMorph
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricBackgroundColor [

	^ self valueOfProperty: #brickRubricBackgroundColor ifAbsent: [ self themer rubricBackgroundColor ]
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricBackgroundColor: aColor [

	self setProperty: #brickRubricBackgroundColor toValue: aColor.
	self updateStyle
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricBorderColor [

	^ self valueOfProperty: #brickRubricBorderColor ifAbsent: [ self themer rubricBorderColor ]
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricBorderColor: aColor [

	self setProperty: #brickRubricBorderColor toValue: aColor.
	self updateStyle
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricBorderWidth [

	^ self valueOfProperty: #brickRubricBorderWidth ifAbsent: [ self themer rubricBorderWidth ]
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricBorderWidth: aColor [

	self setProperty: #brickRubricBorderWidth toValue: aColor.
	self updateStyle
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricTextColor [

	^ self valueOfProperty: #brickRubricTextColor ifAbsent: [ self themer rubricTextColor ]
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricTextColor: aColor [

	self setProperty: #brickRubricTextColor toValue: aColor.
	self updateStyle
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricTextFamilyName [

	^ self valueOfProperty: #brickRubricTextFamilyName ifAbsent: [ self themer rubricTextFamilyName ]
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricTextFamilyName: aString [

	self setProperty: #brickRubricTextFamilyName toValue: aString.
	self updateStyle
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricTextFontSize [

	^ self valueOfProperty: #brickRubricTextFontSize ifAbsent: [ self themer rubricTextFontSize ]
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> rubricTextFontSize: aFloat [

	self setProperty: #brickRubricTextFontSize toValue: aFloat.
	self updateStyle
]

{ #category : #'brick-properties' }
GLMRubScrolledTextBrick >> text: aText [

	self rubric updateTextWith: aText
]

{ #category : #'rubric-updating' }
GLMRubScrolledTextBrick >> updateStyle [

	self rubric color: self rubricBackgroundColor.
	self rubric borderColor: self rubricBorderColor.
	self rubric borderWidth: self rubricBorderWidth.
	self rubric textColor: self rubricTextColor.
	self rubric font: (LogicalFont familyName: self rubricTextFamilyName pointSize: self rubricTextFontSize)
]

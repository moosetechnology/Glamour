"
|browser|
browser := GLMTabulator new.
browser row: #row.

browser transmit to: #row; andShow: [ :composite |
	composite custom: (GLMRubricHighlightedTextPresentation new
		editingMode: [GLMHighlighterTextRubEditingMode 
			withStylerDecorator: (RbEPersonDecorator new
				styler:  (GLMHighlighterTextParserStyler new
					parser: RbEPersonColorizer new))]) ].
	
browser openOn: '
person {	
	name	=	''Phil'';
	age = ''23'';	
}
person {}
'.
"
Class {
	#name : #GLMRubricHighlightedTextPresentation,
	#superclass : #GLMRubricTextPresentation,
	#instVars : [
		'editingMode'
	],
	#category : #'Glamour-Rubric-Presentations'
}

{ #category : #examples }
GLMRubricHighlightedTextPresentation class >> decoratorStylerExample [
	"
	self decoratorStylerExample
	"
	|browser|
browser := GLMTabulator new.
browser row: #row.

browser transmit to: #row; andShow: [ :composite |
	composite custom: (GLMRubricHighlightedTextPresentation new
		editingMode: [GLMHighlighterTextRubEditingMode 
			withStylerDecorator: (GLMRubricPersonDecorator new
				styler:  (GLMHighlighterTextParserStyler new
					parser: GLMRubricPersonColorizer new))]) ].
	
browser openOn: '
person {	
	name	=	''Phil'';
	age = ''23'';	
}
person {}
'.
]

{ #category : #examples }
GLMRubricHighlightedTextPresentation class >> parserStylerExample [
	"
	self parserStylerExample
	"
	| browser |
	browser := GLMTabulator new.
	browser row: #row.
	browser transmit
		to: #row;
		andShow: [ :composite | 
					composite
						custom:
							(GLMRubricHighlightedTextPresentation new
								editingMode: [ GLMHighlighterTextRubEditingMode withParserStyler: GLMRubricPersonColorizer new ]) ].
	browser
		openOn:
			'
person {	
	name	=	''Phil'';
	age = ''23'';	
}
person {}
'
]

{ #category : #accessing }
GLMRubricHighlightedTextPresentation >> editingMode [
	^ editingMode isNil 
		ifTrue: [nil] 
		ifFalse: [editingMode glamourValue: self]
]

{ #category : #accessing }
GLMRubricHighlightedTextPresentation >> editingMode: aBlock [
	
	editingMode := aBlock
]

{ #category : #accessing }
GLMRubricHighlightedTextPresentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^ aRenderer renderRubricHighlightedTextPresentation: self
]

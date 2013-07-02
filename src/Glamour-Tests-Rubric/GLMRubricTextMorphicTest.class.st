Class {
	#name : #GLMRubricTextMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Rubric'
}

{ #category : #tests }
GLMRubricTextMorphicTest >> testAcceptKeyCanBeOverriden [
	| composite textMorph overriden |
	overriden := false.
	composite := GLMCompositePresentation new with: [ :a | a rubricText act: [ :text | overriden := true ] on: $s entitled: 'Override'].
	window := composite openOn: 4.
	textMorph := self find: RubScrolledTextMorph in: window.
	textMorph simulateClick.
	self simulateKeyStroke: $s command.
	self assert: overriden.
]

{ #category : #tests }
GLMRubricTextMorphicTest >> testEnteringTextInPort [
	| composite textMorph |
	composite := GLMCompositePresentation new with: [ :a | a rubricText display: '' ].
	window := composite openOn: 4.
	textMorph := self find: RubScrolledTextMorph in: window.
	textMorph simulateClick.
	self simulateKeyStrokes: 'hello'.
	self assert: (composite pane port: #text) value asString equals: 'hello'
]

{ #category : #tests }
GLMRubricTextMorphicTest >> testExplicitAcceptDoesNotAffectTextPort [
	| composite textMorph |
	composite := GLMCompositePresentation new with: [ :a | a rubricText display: '123' ].
	window := composite openOn: 4.
	textMorph := self find: RubScrolledTextMorph in: window.
	textMorph simulateClick.
	self simulateKeyStrokes: '4'.
	self assert: (composite pane port: #text) value asString equals: '1234'.
	self simulateKeyStroke: $s command.
	self simulateKeyStrokes: '56'.
	self assert: (composite pane port: #text) value asString equals: '123456'
]

{ #category : #tests }
GLMRubricTextMorphicTest >> testMultipleSelectionWithChange [
	| composite textMorph textPresentation |
	composite := GLMCompositePresentation new with: [ :a | a rubricText display: '123456789' ].
	window := composite openOn: 4.
	textMorph := self find: RubScrolledTextMorph in: window.
	self assert: textMorph selectionInterval isEmpty.
	textPresentation := composite presentations first.
	textPresentation selectionInterval: (2 to: 5).
	self assert: textMorph textArea selection asString equals: '2345'.
	self assert: textPresentation selectedText asString equals: '2345'
]

{ #category : #tests }
GLMRubricTextMorphicTest >> testPastingUpdatesTextPort [
	| composite textMorph |
	composite := GLMCompositePresentation new with: [ :a | a rubricText display: '' ].
	window := composite openOn: 42.
	textMorph := self find: RubScrolledTextMorph in: window.
	Clipboard clipboardText: '42'.
	textMorph simulateClick.
	self simulateKeyStroke: $v command.
	self assert: (composite pane port: #text) value asString equals: '42'
]

{ #category : #tests }
GLMRubricTextMorphicTest >> testResettingTheSelection [
	| composite textPresentation |
	composite := GLMCompositePresentation new with: [ :a | a rubricText display: '123456789' ].
	window := composite openOn: 4.
	textPresentation := composite presentations first.
	textPresentation selectionInterval: (2 to: 5).
	self shouldnt: [textPresentation selectionInterval: nil] raise: Error
]

{ #category : #tests }
GLMRubricTextMorphicTest >> testTextPortPopulatedByDefault [
	| composite |
	composite := GLMCompositePresentation new with: [:a | a rubricText ].
	window := composite openOn: '42'.
	self assert: (composite pane port: #text) value asString equals: '42'
]

{ #category : #tests }
GLMRubricTextMorphicTest >> testUnregisterFromAnnouncementsWhenUpdating [
	| composite announcingCollection numberOfExecutions |
	numberOfExecutions := 0.
	announcingCollection := GLMAnnouncingCollection new.
	composite :=  GLMCompositePresentation new with: [ :a | 
					(a rubricText)
						updateOn: GLMItemAdded from: [ announcingCollection ];
						display: [ numberOfExecutions := numberOfExecutions + 1 ] ].
	window := composite openOn: announcingCollection.
	1 to: 3 do: [ :each | announcingCollection add: each ].
	self assert: numberOfExecutions equals: 4	"it should not be 8"
]

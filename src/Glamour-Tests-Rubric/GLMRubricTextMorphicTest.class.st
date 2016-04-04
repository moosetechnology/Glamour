Class {
	#name : #GLMRubricTextMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Rubric'
}

{ #category : #tests }
GLMRubricTextMorphicTest >> expectedFailures [
	^ #(testUpdatingTextPortUpdatesTheMorph)
]

{ #category : #private }
GLMRubricTextMorphicTest >> simulateOnlyOneClickOn: aMorph [
	"(Delay forMilliseconds: HandMorph doubleClickTime + 1) wait."
	aMorph simulateClick
]

{ #category : #tests }
GLMRubricTextMorphicTest >> testAcceptKeyCanBeOverriden [
	| composite textMorph overriden shortcut event|
	overriden := false.
	composite := GLMCompositePresentation new with: [ :a | a text act: [self logCr. self halt. overriden := true ] on: $s entitled: 'Override'].
	window := composite openOn: '4'.
	textMorph := self find: RubScrolledTextMorph in: window.
	"self simulateOnlyOneClickOn: textMorph."
	self assert: ActiveHand keyboardFocus equals: textMorph textArea.
	
	shortcut := $s meta asKeyCombination.
	event := KeyboardEvent new
		setType: #keystroke
		buttons: shortcut modifier eventCode
		position: textMorph textArea center
		keyValue: shortcut key asciiValue
		charCode: shortcut key asciiValue
		hand: nil
		stamp: DateAndTime now.
	event logCr.
		
		
	shortcut logCr.
	'global' logCr.
	KMRepository default globalCategories do: [ :aCategory | 
		aCategory allEntries keymaps do: [:aKeyMap |
			aKeyMap crLog.
			(aKeyMap matches: {event}) logCr]].
	'direct' logCr.

	textMorph textArea kmDispatcher directKeymaps allEntries keymaps do: [:aKeyMap |
			aKeyMap crLog.
			(aKeyMap matches: {event}) logCr].
	textMorph textArea kmDispatcher targets do: [ :aTarget |
		aTarget logCr.
		aTarget category allEntries keymaps do: [:aKeyMap |
			aKeyMap crLog.
			(aKeyMap matches: {event}) logCr] ].

	textMorph textArea handleKeystroke: (KeyboardEvent new
		setType: #keystroke
		buttons: shortcut modifier eventCode
		position: textMorph textArea center
		keyValue: shortcut key asciiValue
		charCode: shortcut key asciiValue
		hand: nil
		stamp: DateAndTime now).
	overriden logCr.
	self assert: overriden
]

{ #category : #tests }
GLMRubricTextMorphicTest >> testEnteringTextInPort [
	| composite textMorph |
	composite := GLMCompositePresentation new with: [ :a | a text display: '' ].
	window := composite openOn: 4.
	textMorph := self find: RubScrolledTextMorph in: window.
	self simulateOnlyOneClickOn: textMorph.
	self simulateKeyStrokes: 'hello'.
	self assert: (composite pane port: #text) value asString equals: 'hello'
]

{ #category : #tests }
GLMRubricTextMorphicTest >> testExplicitAcceptDoesNotAffectTextPort [
	| composite textMorph |
	composite := GLMCompositePresentation new with: [ :a | a text display: '123' ].
	window := composite openOn: 4.
	textMorph := self find: RubScrolledTextMorph in: window.
	self simulateOnlyOneClickOn: textMorph.
	self simulateKeyStrokes: '4'.
	self assert: (composite pane port: #text) value asString equals: '1234'.
	self simulateKeyStroke: $s meta.
	self simulateKeyStrokes: '56'.
	self assert: (composite pane port: #text) value asString equals: '123456'
]

{ #category : #tests }
GLMRubricTextMorphicTest >> testMultipleSelectionWithChange [
	| composite textMorph textPresentation |
	composite := GLMCompositePresentation new with: [ :a | a text display: '123456789' ].
	window := composite openOn: 4.
	textMorph := self find: RubScrolledTextMorph in: window.
	self assert: textMorph selectionInterval isEmpty.
	textPresentation := composite presentations first.
	textPresentation selectionInterval: (2 to: 5).
	self assert: textMorph textArea selection asString equals: '2345'.
	self assert: textPresentation selectedText asString equals: '2345'
]

{ #category : #tests }
GLMRubricTextMorphicTest >> testOKeyWithCtrlCannotBeOverriden [
	| composite textMorph overriden |
	overriden := false.
	composite := GLMCompositePresentation new with: [ :a | a text act: [ :text | overriden := true ] on: $o entitled: 'Override'].
	window := composite openOn: '4'.
	textMorph := self find: RubScrolledTextMorph in: window.
	self simulateOnlyOneClickOn: textMorph.
	self simulateKeyStroke: $o meta.
	self assert: overriden not
]

{ #category : #tests }
GLMRubricTextMorphicTest >> testPastingUpdatesTextPort [
	| composite textMorph  |
	composite := GLMCompositePresentation new with: [ :a | a text display: '' ].
	window := composite openOn: 42.
	textMorph := self find: RubEditingArea in: window.
	Clipboard clipboardText: '42'.
	textMorph editor paste.
	self assert: (composite pane port: #text) value asString equals: '42'
]

{ #category : #tests }
GLMRubricTextMorphicTest >> testResettingTheSelection [
	| composite textPresentation |
	composite := GLMCompositePresentation new with: [ :a | a text display: '123456789' ].
	window := composite openOn: 4.
	textPresentation := composite presentations first.
	textPresentation selectionInterval: (2 to: 5).
	self shouldnt: [textPresentation selectionInterval: nil] raise: Error
]

{ #category : #tests }
GLMRubricTextMorphicTest >> testTextPortPopulatedByDefault [
	| composite |
	composite := GLMCompositePresentation new with: [:a | a text ].
	window := composite openOn: '42'.
	self assert: (composite pane port: #text) value asString equals: '42'
]

{ #category : #tests }
GLMRubricTextMorphicTest >> testUnregisterFromAnnouncementsWhenUpdating [
	| composite announcingCollection numberOfExecutions |
	numberOfExecutions := 0.
	announcingCollection := GLMAnnouncingCollection new.
	composite :=  GLMCompositePresentation new with: [ :a | 
					(a text)
						updateOn: GLMItemAdded from: [ announcingCollection ];
						display: [ 
								numberOfExecutions := numberOfExecutions + 1. 
								numberOfExecutions asString ] ].
	window := composite openOn: announcingCollection.
	1 to: 3 do: [ :each | announcingCollection add: each ].
	self assert: numberOfExecutions equals: 4	"it should not be 8"
]

{ #category : #tests }
GLMRubricTextMorphicTest >> testUpdatingTextPortUpdatesTheMorph [
	| composite textMorph |
	composite := GLMCompositePresentation new with: [:a | a text ].
	window := composite openOn: 'fourtytwo'.
	composite first text: '42'.
	self assert: (composite pane port: #text) value asString equals: '42'.
	textMorph := self find: RubScrolledTextMorph in: window.
	self assert: textMorph text asString equals: '42'
]

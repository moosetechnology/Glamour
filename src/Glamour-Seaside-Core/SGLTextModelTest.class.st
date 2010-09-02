Class {
	#name : #SGLTextModelTest,
	#superclass : #TestCase,
	#instVars : [
		'presentation',
		'model'
	],
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #setup }
SGLTextModelTest >> setUp [
	presentation := GLMTextPresentation new.
	model := SGLTextModel for: presentation
]

{ #category : #testing }
SGLTextModelTest >> testAnnouncerslInitialization [
	|count1 count2 count3|
	count1 := 0. 
	count2 := 0.
	count3 := 0.
	model announcer on: SGLTextPresenterTextChanged do: [ :ann | count1 := count1 +1].
	model announcer on: SGLTextPresenterSelectedTextChanged do: [ :ann | count2 := count2 +1].
	model announcer on: SGLTextPresenterSelectionIntervalChanged do: [ :ann | count3 := count3 +1].
	model anounceTextChangedTo: 'text'.
	self assert: count1 = 1.
	self assert: count2 = 0.
	self assert: count3 = 0.
	model anounceSelectedTextChangedTo: 'text'.
	self assert: count1 = 1.
	self assert: count2 = 1.
	self assert: count3 = 0.
	model anounceSelectionIntervalChangedTo: (1 to: 4).
	self assert: count1 = 1.
	self assert: count2 = 1.
	self assert: count3 = 1.
	self assert: model text = nil.
	self assert: model selectionInterval = nil.
	self assert: model selectedText = nil
]

{ #category : #testing }
SGLTextModelTest >> testIntervalForSelection [
	self assert: (model intervalForSelection: nil) = nil.
	self assert: (model intervalForSelection: 'text') = nil.
	model text: 'a test text'.
	self assert: (model intervalForSelection: '') = nil.
	self assert: (model intervalForSelection: 'test t') = (3 to: 8).
	self assert: (model intervalForSelection: 'a test text') =  (1 to: 11).
	self assert: (model intervalForSelection: 't') =  (3 to: 3).
	self assert: (model intervalForSelection: 'not found') = nil.
	
]

{ #category : #testing }
SGLTextModelTest >> testModelInitialization [
	self assert: model glamourPresentation == presentation.
	self assert: model text = nil.
	self assert: model selectedText = nil.
	self assert: model selectionInterval = nil.
	self assert: model announcer notNil.

]

{ #category : #testing }
SGLTextModelTest >> testSelectedTextChanged [
	|count selectedText|
	count := 0.
	model announcer on: SGLTextPresenterSelectedTextChanged do: [ :ann | 
		count := count + 1.
		selectedText := ann selectedText ].
	model selectedText: 'a text'.
	model selectedText: 'a text'.
	model selectedText: 'a text'.
	self assert: count = 1.
	self assert: selectedText  = 'a text'.
	self assert: model selectedText = 'a text'.
	self assert: model glamourPresentation selectedText = 'a text'.
	self assert: model text = nil.
	self assert: model selectionInterval = nil.
	model selectedText: nil.
	self assert: count = 2.
	self assert: selectedText  = nil.
	self assert: model selectedText = nil.
	self assert: model glamourPresentation selectedText = ''.
	
]

{ #category : #testing }
SGLTextModelTest >> testSelectionForInterval [
	self assert: (model selectionForInterval: nil) = nil.
	self assert: (model selectionForInterval: (1 to: 100)) = nil.
	model text: 'a test text'.
	self assert: (model selectionForInterval: (1 to: 11)) =  'a test text'.
	self assert: (model selectionForInterval: (6 to: 1)) =  'a test'.
	self assert: (model selectionForInterval: (-2311 to: 21211)) =  'a test text'.
	self assert: (model selectionForInterval: (20 to: 100)) = nil.
	self assert: (model selectionForInterval: (-10 to: 0)) = nil.
	
]

{ #category : #testing }
SGLTextModelTest >> testSelectionIntervalAndSelectedTextChanged [
	|count1 count2 selectionInterval selectedText|
	count1 := 0.
	count2 := 0.
	model announcer on: SGLTextPresenterSelectionIntervalChanged do: [ :ann | 
		count1 := count1 + 1.
		selectionInterval := ann selectionInterval ].
	model announcer on: SGLTextPresenterSelectedTextChanged do: [ :ann | 
		count2 := count2 + 1.
		selectedText := ann selectedText ].
	model selectionInterval: (1 to: 100) withSelectedText: 'some text'.
	model selectionInterval: (1 to: 100).
	model selectionInterval: (1 to: 100).
	self assert: count1 = 1.
	self assert: count2 = 1.
	self assert: selectionInterval  = (1 to: 100).
	self assert: selectedText = 'some text'.
	self assert: model selectionInterval = (1 to: 100).
	self assert: model selectedText = 'some text'.
	self assert: model glamourPresentation selectionInterval = (1 to: 100).
	self assert: model glamourPresentation selectedText = 'some text'.
	self assert: model text = nil.
	model selectionInterval: nil withSelectedText: nil.
	self assert: count1 = 2.
	self assert: count2 = 2.
	self assert: selectionInterval  = nil.
	self assert: selectedText = nil.
	self assert: model selectionInterval = nil.
	self assert: model selectedText = nil.
	self assert: model glamourPresentation selectionInterval = nil.
	self assert: model glamourPresentation selectedText = ''
	
]

{ #category : #testing }
SGLTextModelTest >> testSelectionIntervalChanged [
	|count selectionInterval|
	count := 0.
	model announcer on: SGLTextPresenterSelectionIntervalChanged do: [ :ann | 
		count := count + 1.
		selectionInterval := ann selectionInterval ].
	model selectionInterval: (1 to: 100).
	model selectionInterval: (1 to: 100).
	model selectionInterval: (1 to: 100).
	self assert: count = 1.
	self assert: selectionInterval  = (1 to: 100).
	self assert: model selectionInterval = (1 to: 100).
	self assert: model glamourPresentation selectionInterval = (1 to: 100).
	self assert: model selectedText = nil.
	self assert: model text = nil.
	model selectionInterval: nil.
	self assert: count = 2.
	self assert: selectionInterval  = nil.
	self assert: model selectionInterval = nil.
	self assert: model glamourPresentation selectionInterval = nil.
	
]

{ #category : #testing }
SGLTextModelTest >> testTextChanged [
	|count text|
	count := 0.
	model announcer on: SGLTextPresenterTextChanged do: [ :ann | 
		count := count + 1.
		text := ann text ].
	model text: 'a text'.
	model text: 'a text'.
	model text: 'a text'.
	self assert: count = 1.
	self assert: text  = 'a text'.
	self assert: model text = 'a text'.
	self assert: model glamourPresentation text = 'a text'.
	self assert: model selectedText = nil.
	self assert: model selectionInterval = nil.
	model text: nil.
	self assert: count = 2.
	self assert: text  = nil.
	self assert: model text = nil.
	self assert: model glamourPresentation text = nil.
	
]

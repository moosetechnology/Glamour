Class {
	#name : #SGLTextPresenterTest,
	#superclass : #SGLPresenterTest,
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #setup }
SGLTextPresenterTest >> expectedFailures [
	^ #(testTextWithSelectedTextAnnouncements testTextWithSelectionIntervalAnnouncements)
]

{ #category : #setup }
SGLTextPresenterTest >> presentationClass [
	^ GLMTextPresentation
]

{ #category : #setup }
SGLTextPresenterTest >> presenterClass [
	^ SGLTextPresenter
]

{ #category : #testing }
SGLTextPresenterTest >> testModelInitialization [
	self establishSession.
	self assert: presenter model notNil.
	self assert: presenter model glamourPresentation = presentation
]

{ #category : #testing }
SGLTextPresenterTest >> testSelectedTextPortAnnouncement [
	self establishSession.
	self assert: presenter model selectedText isNil.
	presentation selectedText: 'Some text'.

	self assert: presenter model selectedText = 'Some text'.
	self assert: presenter model text isNil.
	self assert: presenter model selectionInterval isNil
]

{ #category : #testing }
SGLTextPresenterTest >> testSelectedTextPortInitialization [
	presentation selectedText: 'test'.
	self establishSession.
	
	self assert: presentation text = nil.
	self assert: presentation selectedText = 'test'.
	self assert: presentation selectionInterval = nil.
	
	self assert: presenter model text = nil.
	self assert: presenter model selectedText = 'test'.
	self assert: presenter model selectionInterval = nil
]

{ #category : #testing }
SGLTextPresenterTest >> testSelectionIntervalPortAnnouncement [
	self establishSession.
	self assert: presenter model selectionInterval isNil.
	presentation selectionInterval: (-12 to: 20).

	self assert: presenter model selectionInterval = (-12 to: 20).
	self assert: presenter model text isNil.
	self assert: presenter model selectedText isNil
]

{ #category : #testing }
SGLTextPresenterTest >> testSelectionIntervalPortInitialization [
	presentation selectionInterval: (2 to: 10000).
	self establishSession.
	
	self assert: presentation text = nil.
	self assert: presentation selectedText = ''.
	self assert: presentation selectionInterval = (2 to: 10000).
	
	self assert: presenter model text = nil.
	self assert: presenter model selectedText = nil.
	self assert: presenter model selectionInterval = (2 to: 10000)
]

{ #category : #testing }
SGLTextPresenterTest >> testSelectionPortsInitialization [
	presentation selectedText: 'a selection'.
	presentation selectionInterval: (20 to: 200).
	self establishSession.
	
	self assert: presentation text = nil.
	self assert: presentation selectedText = 'a selection'.
	self assert: presentation selectionInterval = (20 to: 200).
	
	self assert: presenter model text = nil.
	self assert: presenter model selectedText = 'a selection'.
	self assert: presenter model selectionInterval = (20 to: 200)
]

{ #category : #testing }
SGLTextPresenterTest >> testTextPortAnnouncement [
	self establishSession.
	self assert: presenter model text isNil.
	presentation text: 'Some text'.

	self assert: presenter model text = 'Some text'.
	self assert: presenter model selectedText isNil.
	self assert: presenter model selectionInterval isNil
]

{ #category : #testing }
SGLTextPresenterTest >> testTextPortWithDifferentSelectionsInitialization [
	presentation entity: 'A test text'.
	presentation selectedText: 'test'.
	presentation selectionInterval: (-1 to: 3).
	self establishSession.
	
	self assert: presentation text = 'A test text'.
	self assert: presentation selectedText = 'A t'.
	self assert: presentation selectionInterval = (-1 to: 3).
	
	self assert: presenter model text = 'A test text'.
	self assert: presenter model selectedText = 'A t'.
	self assert: presenter model selectionInterval = (-1 to: 3)
]

{ #category : #testing }
SGLTextPresenterTest >> testTextPortWithSelectedTextInitialization [
	presentation entity: 'A test text'.
	presentation selectedText: 'text'.
	self establishSession.
	
	self assert: presentation text = 'A test text'.
	self assert: presentation selectedText = 'text'.
	self assert: presentation selectionInterval = (8 to: 11).
	
	self assert: presenter model text = 'A test text'.
	self assert: presenter model selectedText = 'text'.
	self assert: presenter model selectionInterval = (8 to: 11)
]

{ #category : #testing }
SGLTextPresenterTest >> testTextPortWithSelectionInitialization [
	presentation entity: 'A test text'.
	presentation selectedText: 'test text'.
	presentation selectionInterval: (3 to: 11).
	self establishSession.
	
	self assert: presentation text = 'A test text'.
	self assert: presentation selectedText = 'test text'.
	self assert: presentation selectionInterval = (3 to: 11).
	
	self assert: presenter model text = 'A test text'.
	self assert: presenter model selectedText = 'test text'.
	self assert: presenter model selectionInterval = (3 to: 11)
]

{ #category : #testing }
SGLTextPresenterTest >> testTextPortWithSelectionIntervalInitialization [
	presentation entity: 'A test text'.
	presentation selectionInterval: (1 to: 1).
	self establishSession.
	
	self assert: presentation text = 'A test text'.
	self assert: presentation selectionInterval = (1 to: 1).
	self assert: presentation selectedText = 'A'.
	
	self assert: presenter model text = 'A test text'.
	self assert: presenter model selectionInterval = (1 to: 1).
	self assert: presenter model selectedText = 'A'.
]

{ #category : #testing }
SGLTextPresenterTest >> testTextPortWithoutSelectionInitialization [
	presentation entity: 'A test text'.
	self establishSession.
	
	self assert: presentation text = 'A test text'.
	self assert: presenter model text = 'A test text'.
	self assert: presenter model selectedText isNil.
	self assert: presenter model selectionInterval isNil
]

{ #category : #testing }
SGLTextPresenterTest >> testTextWithSelectedTextAnnouncements [
	self establishSession.
	presentation text: 'Some text to test'.
	presentation selectedText: 'text'.

	self assert: presenter model text = 'Some text to test'.
	self assert: presenter model selectedText = 'text'.
	self assert: presenter model selectionInterval = (6 to: 9).
	self assert: presentation selectionInterval = (6 to: 9).
	
	presentation selectedText: 'not found'.
	self assert: presenter model selectedText = 'not found'.
	self assert: presenter model selectionInterval = nil.
	
]

{ #category : #testing }
SGLTextPresenterTest >> testTextWithSelectionIntervalAnnouncements [
	self establishSession.
	presentation text: 'Some text to test'.
	presentation selectionInterval: '2 to: 5'.

	self assert: presenter model text = 'Some text to test'.
	self assert: presenter model selectionInterval = (2 to: 5).
	self assert: presenter model selectedText = 'ome t'.
	
	presentation selectionInterval: (100 to: 101).
	self assert: presenter model selectionInterval = (100 to: 101).
	self assert: presenter model selectedText = nil.
	
]

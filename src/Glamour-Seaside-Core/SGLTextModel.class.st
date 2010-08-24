Class {
	#name : #SGLTextModel,
	#superclass : #SGLModel,
	#instVars : [
		'text',
		'selectionInterval',
		'selectedText'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
SGLTextModel >> selectedText [
	^ selectedText
]

{ #category : #private }
SGLTextModel >> selectionForInterval: anInterval [
	| from to |
	from := (anInterval first max: 1) min: self text size.
	to :=  (anInterval last min: self text size) max: 1.
	"Transcript show: from asString , '  ', to asString ; cr."
	^ self text copyFrom: from to: to
	
]

{ #category : #accessing }
SGLTextModel >> selectionInterval [
	^ selectionInterval
]

{ #category : #callbacks }
SGLTextModel >> selectionInterval: anInterval [
	self selectionInterval: anInterval withText: nil
]

{ #category : #callbacks }
SGLTextModel >> selectionInterval: anInterval withText: aSelection [
	| interval selection |
	(anInterval first > anInterval last )
		ifTrue: [ interval := Interval from: anInterval last to: anInterval first ]
		ifFalse: [ interval := anInterval ].
	aSelection 
		ifNil: [ selection := self selectionForInterval: interval. ]  
		ifNotNil: [ selection := aSelection ].
	"Transcript show: self selectionInterval asString, '  ',interval asString , ' --- ',self selectedText asString, ' // ',selection ; cr."
	(self selectionInterval = interval and: [ self selectedText = selection ]) 
		ifFalse: [
			selectionInterval := interval.
			selectedText := selection.
			self announcer announce: (
				SGLTextPresenterSelectionChanged  new 
					selectionInterval: interval;
					selectedText: selection;
					yourself) ]
]

{ #category : #accessing }
SGLTextModel >> text [
	^ text
]

{ #category : #callbacks }
SGLTextModel >> text: aString [
	self text = aString 
		ifFalse: [
			text := aString.
			self announcer announce: (
				SGLTextPresenterTextChanged  new 
					text: aString;
					yourself) ]
]

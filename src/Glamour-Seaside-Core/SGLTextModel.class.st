Class {
	#name : #SGLTextModel,
	#superclass : #SGLModel,
	#instVars : [
		'text',
		'selectionInterval',
		'selectedText'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #'instance creation' }
SGLTextModel class >> for: aPresentation [
	|model|
	model := self new glamourPresentation: aPresentation.
	
	"When the presenter changes, we want to update the glamour model"
	model announcer on: SGLTextPresenterTextChanged do: [ :ann | 
		aPresentation announcer suspendAllWhile: [
			aPresentation text: ann text ] ].
	model announcer on: SGLTextPresenterSelectedTextChanged do: [ :ann | 
		aPresentation announcer suspendAllWhile: [
			aPresentation selectedText: ann selectedText ] ].
	model announcer on: SGLTextPresenterSelectionIntervalChanged do: [ :ann | 
		aPresentation announcer suspendAllWhile: [
			aPresentation selectionInterval: ann selectionInterval ] ].
	^ model

]

{ #category : #private }
SGLTextModel >> anounceSelectedTextChangedTo: aString [
	self announcer announce: (
			SGLTextPresenterSelectedTextChanged  new 
				selectedText: aString;
				yourself)
]

{ #category : #private }
SGLTextModel >> anounceSelectionIntervalChangedTo: anInterval [
	self announcer announce: (
			SGLTextPresenterSelectionIntervalChanged  new 
				selectionInterval: anInterval;
				yourself)
]

{ #category : #private }
SGLTextModel >> anounceTextChangedTo: aString [
	self announcer announce: (
				SGLTextPresenterTextChanged  new 
					text: aString;
					yourself)
]

{ #category : #private }
SGLTextModel >> intervalForSelection: aString [
	|index|
	index := aString 
		ifNil: [^ nil] 
		ifNotNil: [self text ifNil: [^ nil] ifNotNil: [ self text findString: aString ]].
	(index = 0)
		ifTrue: [^ nil] 
		ifFalse: [ ^ Interval from: index to: (index + aString size -1) ]
]

{ #category : #accessing }
SGLTextModel >> selectedText [
	^ selectedText
]

{ #category : #callbacks }
SGLTextModel >> selectedText: aString [
	self selectedText = aString 
		ifFalse: [
			selectedText := aString.
			self anounceSelectedTextChangedTo: aString ]
]

{ #category : #private }
SGLTextModel >> selectionForInterval: anInterval [
	| from to interval |
	(anInterval isNil or: [self text isNil] ) ifTrue: [^nil].
	(anInterval first > anInterval last )
		ifTrue: [ interval := Interval from: anInterval last to: anInterval first ]
		ifFalse: [ interval := anInterval ].
	(interval first > self text size or: [interval last < 1] ) ifTrue: [^nil].
	from := interval first max: 1.
	to :=  interval last min: self text size.
	^ self text copyFrom: from to: to
	
]

{ #category : #accessing }
SGLTextModel >> selectionInterval [
	^ selectionInterval
]

{ #category : #callbacks }
SGLTextModel >> selectionInterval: anInterval [
	self selectionInterval = anInterval
		ifFalse: [
			selectionInterval := anInterval.
			self anounceSelectionIntervalChangedTo: anInterval ]
]

{ #category : #callbacks }
SGLTextModel >> selectionInterval: anInterval withSelectedText: aString [	
	(self selectionInterval = anInterval and: [ self selectedText = aString ]) 
		ifFalse: [
			selectionInterval := anInterval.
			selectedText := aString.
			self anounceSelectionIntervalChangedTo: anInterval.
			self anounceSelectedTextChangedTo: aString ]
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
			self anounceTextChangedTo: aString ]
]

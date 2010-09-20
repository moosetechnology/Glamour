Class {
	#name : #SGLTextModel,
	#superclass : #SGLWidgetModel,
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

{ #category : #selection }
SGLTextModel >> addInitialSelections [
	| selection |
	"We populate the text port"
	self text: self glamourPresentation displayValue.
	
	(self glamourPresentation selectionInterval isNil) 
		ifTrue: [
			selection := (self glamourPresentation selectedText = '') ifTrue: [nil] ifFalse: [self glamourPresentation selectedText].
			(selection isNil) 
				ifFalse:  [
					self selectedText: selection.
					self selectionInterval: (self intervalForSelection: selection) ] ] 
		ifFalse:  [
			selection := self selectionForInterval: self glamourPresentation selectionInterval.
			self selectionInterval:  self glamourPresentation selectionInterval.
			self selectedText: (selection isNil 
				ifTrue: [(self glamourPresentation selectedText = '') ifTrue: [nil] ifFalse: [self glamourPresentation selectedText]] 
				ifFalse: [selection]) ]
	
	
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
	self text ifNil: [^ self selectionInterval].
	index := aString 
		ifNil: [0] 
		ifNotNil: [self text findString: aString ].
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
	self text isNil ifTrue: [^self selectedText].
	anInterval isNil ifTrue: [^nil].
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

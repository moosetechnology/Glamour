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
		ifNil: [0] 
		ifNotNil: [self text ifNil: [0] ifNotNil: [ self text findString: aString ]].
	(index = 0)
		ifTrue: [^ nil] 
		ifFalse: [ ^ Interval from: index to: (index + aString size -1) ]
]

{ #category : #accessing }
SGLTextModel >> selectedText [
	^ selectedText
]

{ #category : #callbacks }
SGLTextModel >> selectedText: aString withUpdate: aBoolean [
	self selectedText = aString 
		ifFalse: [
			selectedText := aString.
			aBoolean ifTrue: [
				self anounceSelectedTextChangedTo: aString ] ]
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
SGLTextModel >> selectionInterval: anInterval withText: aString [	
	(self selectionInterval = anInterval and: [ self selectedText = aString ]) 
		ifFalse: [
			selectionInterval := anInterval.
			selectedText := aString.
			self anounceSelectionIntervalChangedTo: anInterval.
			self anounceSelectedTextChangedTo: aString ]
]

{ #category : #callbacks }
SGLTextModel >> selectionInterval: anInterval withUpdate: aBoolean [
	self selectionInterval = anInterval
		ifFalse: [
			selectionInterval := anInterval.
			aBoolean ifTrue: [
				self anounceSelectionIntervalChangedTo: anInterval ] ]
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

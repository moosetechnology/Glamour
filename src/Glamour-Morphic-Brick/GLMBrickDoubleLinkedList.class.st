Class {
	#name : #GLMBrickDoubleLinkedList,
	#superclass : #DoubleLinkedList,
	#category : #'Glamour-Morphic-Brick-Utils'
}

{ #category : #enumerating }
GLMBrickDoubleLinkedList >> detectMax: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Answer the element for which aBlock evaluates to the highest magnitude.
	If collection empty, return nil.  This method might also be called elect:."

	| maxElement maxValue |
	self do: [:each | | val | 
		maxValue == nil
			ifFalse: [
				(val := aBlock value: each) > maxValue ifTrue: [
					maxElement := each.
					maxValue := val]]
			ifTrue: ["first element"
				maxElement := each.
				maxValue := aBlock value: each].
				"Note that there is no way to get the first element that works 
				for all kinds of Collections.  Must test every one."].
	^ maxElement
]

{ #category : #'as yet unclassified' }
GLMBrickDoubleLinkedList >> ifEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value if the receiver is empty, otherwise answer the receiver."
	
	"Note that the fact that this method returns its argument in case the receiver is not empty allows one to write expressions like the following ones: self classifyMethodAs: (myProtocol ifEmpty: ['As yet unclassified'])"

	^ self isEmpty 
		ifTrue: [ ^aBlock value ]
		ifFalse: [ self ]
]

{ #category : #enumerating }
GLMBrickDoubleLinkedList >> inject: thisValue into: binaryBlock [ 
	"Accumulate a running value associated with evaluating the argument, 
	binaryBlock, with the current value of the argument, thisValue, and the 
	receiver as block arguments. For instance, to sum the numeric elements 
	of a collection, aCollection inject: 0 into: [:subTotal :next | subTotal + 
	next]."

	| nextValue |
	nextValue := thisValue.
	self do: [:each | nextValue := binaryBlock value: nextValue value: each].
	^nextValue
]

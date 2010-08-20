Class {
	#name : #SGLTextModel,
	#superclass : #SGLModel,
	#instVars : [
		'text'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
SGLTextModel >> text [
	^ text
]

{ #category : #callbacks }
SGLTextModel >> text: aString [
	self text = aString 
		ifFalse: [
			self text: aString.
			self announcer announce: (
				SGLTextPresenterTextChanged  new 
					text: aString
					yourself) ]
]

{ #category : #updating }
SGLTextModel >> updateText [
]

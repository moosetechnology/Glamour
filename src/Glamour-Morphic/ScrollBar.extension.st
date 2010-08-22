Extension { #name : #ScrollBar }

{ #category : #'*Glamour-Morphic' }
ScrollBar >> glmAnimateValue: aNumber duration: anInteger [
	anInteger <= 0
		ifTrue: [ self setValue: aNumber ]
		ifFalse: [
			| startTime start end |
			startTime := Time millisecondClockValue.
			start := value roundTo: scrollDelta.
			[ | delta |
			[ (delta := Time millisecondClockValue - startTime) < anInteger ] whileTrue: [
				self setValue: (aNumber - start) * (delta / anInteger) + start.
				Processor yield ].
				self setValue: aNumber ]
					fork ]
]

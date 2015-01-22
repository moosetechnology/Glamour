Extension { #name : #LayoutClassScope }

{ #category : #'*Glamour-Morphic-Brick' }
LayoutClassScope >> slotsDictionary [
	| result |
	result := Dictionary new.
	self do: [ :slot |  result at: slot name put: slot].
	^ result
]

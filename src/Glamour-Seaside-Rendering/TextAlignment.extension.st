Extension { #name : #TextAlignment }

{ #category : #'*glamour-seaside-rendering' }
TextAlignment >> cssPropertyAndValue [

	| strm |
	self alignment = Centered ifTrue: [^ ('text-align' -> 'center') ].
	self alignment = Justified ifTrue: [^ ('text-align' -> 'justify') ].
	self alignment = LeftFlush ifTrue: [^ ('text-align' -> 'left')].
	self alignment = RightFlush ifTrue: [^ ('text-align' -> 'right')].
	^ (nil -> nil)
]

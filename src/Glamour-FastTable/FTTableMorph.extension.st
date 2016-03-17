Extension { #name : #FTTableMorph }

{ #category : #'*Glamour-FastTable' }
FTTableMorph >> step [
	self wantsSteps ifFalse: [ ^ self ].
	self window ifNil: [ ^ self ].
	self window isActive ifFalse: [ ^ self ].
	(self window boundsInWorld containsRect: self boundsInWorld) ifFalse: [ ^ self ].
	self dataSource resetElements.
	self refresh.
]

{ #category : #'*Glamour-FastTable' }
FTTableMorph >> stepTime [
	^ self dataSource stepTime
]

{ #category : #'*Glamour-FastTable' }
FTTableMorph >> wantsSteps [
	^ self dataSource wantsSteps
]

Extension { #name : #WATagBrush }

{ #category : #'*glamour-seaside' }
WATagBrush >> boxFlex: anObject [
	self style: '-webkit-box-flex: ' , anObject asString.
	self style: '-moz-box-flex: ' , anObject asString.
	self style: 'box-flex: ' , anObject asString
]

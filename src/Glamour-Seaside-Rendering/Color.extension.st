Extension { #name : #Color }

{ #category : #'*glamour-seaside-rendering' }
Color >> glmAsHtmlColor [

	self = Color transparent ifTrue: [^ 'transparent'].
	^ '#',self printHtmlString 
]

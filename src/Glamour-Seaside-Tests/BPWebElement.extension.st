Extension { #name : #BPWebElement }

{ #category : #'*glamour-seaside-tests' }
BPWebElement >> dragAndDropBy: aPoint [

	(BPActions driver: driver)
		drag: self andDropBy: aPoint;
		perform.
]

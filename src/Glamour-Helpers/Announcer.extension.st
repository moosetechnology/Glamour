Extension { #name : #Announcer }

{ #category : #'*Glamour-Helpers' }
Announcer >> reset [
	subscriptions := nil
]

{ #category : #'*Glamour-Helpers' }
Announcer >> unsubscribeNonIdentical: anObject [
	subscriptions ifNil: [ ^ self ].
	subscriptions keysAndValuesDo: [ :class :actions |
		subscriptions at: class put: (actions 
			reject: [ :each | each receiver = anObject ]) ].
	subscriptions keysAndValuesRemove: [ :class :actions |
		actions isEmpty ]
]

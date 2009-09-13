Extension { #name : #GLMListPresentation }

{ #category : #'*Glamour-Scripting' }
GLMListPresentation >> beMultiple [
	allowsMultipleSelection := true
]

{ #category : #'*Glamour-Scripting' }
GLMListPresentation >> beSingle [
	allowsMultipleSelection := false
]

{ #category : #'*Glamour-Scripting' }
GLMListPresentation >> filterOn: aBlock [ 
	filterBlock := aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMListPresentation >> itemAct: aBlock on: aCharacter [ 
	 
	
]

{ #category : #'*Glamour-Scripting' }
GLMListPresentation >> search: aText on: aList [
	self painting glamourValue: 
			((self entity isKindOf: GLMMultiValue) 
				ifTrue: [(GLMMultiValue with: aText with: aList) , self entity] 
				ifFalse: 
					[GLMMultiValue 
						with: aText
						with: aList
						with: self entity])
]

{ #category : #'*Glamour-Scripting' }
GLMListPresentation >> searchOn: aBlock [
	searchBlock := aBlock
]

{ #category : #'*Glamour-Scripting' }
GLMListPresentation >> searchStrategy [
	^ searchBlock
]

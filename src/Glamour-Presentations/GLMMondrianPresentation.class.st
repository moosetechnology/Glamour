Class {
	#name : #GLMMondrianPresentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'painting'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMMondrianPresentation >> painting [ 
	 
	^painting
]

{ #category : #accessing }
GLMMondrianPresentation >> painting: anObject [ 
	 
	painting := anObject
]

{ #category : #rendering }
GLMMondrianPresentation >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderMondrianPresentation: self
]

{ #category : #accessing }
GLMMondrianPresentation >> renderView [ 
	 
	| view | 
	view := ViewRenderer new. 
	self painting 
		glamourValue: 
			((self entity isKindOf: GLMMultiValue) 
				ifTrue: [(GLMMultiValue with: view) , self entity] 
				ifFalse: 
					[GLMMultiValue 
						with: view 
						with: self entity]). 
	^view
]

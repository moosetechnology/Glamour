Extension { #name : #GLMFinder }

{ #category : #'*Glamour-Scripting' }
GLMFinder >> context [

	context isNil ifTrue: [context := OrderedCollection new].
	^context
]

{ #category : #'*Glamour-Scripting' }
GLMFinder >> custom: aPresentation [ 
	 
	scriptTransmission isNil 
		ifTrue: [self addPresentation: aPresentation] 
		ifFalse: [self scriptTransmission addPresentation: aPresentation]. 
	^aPresentation
]

{ #category : #'*Glamour-Scripting' }
GLMFinder >> fromPrevious: aPortSymbol [ 
	 
	self scriptTransmission addActiveOrigin: (GLMPort new name: aPortSymbol)
]

{ #category : #'*Glamour-Scripting' }
GLMFinder >> initializeContextWith: aPane [

	context := OrderedCollection with: aPane
]

{ #category : #'*Glamour-Scripting' }
GLMFinder >> passivelyFromPrevious: aPortSymbol [
	self scriptTransmission addPassiveOrigin: (GLMPort new name: aPortSymbol)
]

{ #category : #'*Glamour-Scripting' }
GLMFinder >> scriptTransmission [ 
	 
	^scriptTransmission 
		ifNil: [scriptTransmission := GLMTransmission new ensureBundleStrategy]
]

{ #category : #'*Glamour-Scripting' }
GLMFinder >> updateContextWith: aPane [ 
	context isNil ifTrue: [context := OrderedCollection new].
	context add: aPane
]

{ #category : #'*Glamour-Scripting' }
GLMFinder >> using: aBlock [ 
	 
	aBlock value. 
	self addTransmission: scriptTransmission. 
	scriptTransmission := nil
]

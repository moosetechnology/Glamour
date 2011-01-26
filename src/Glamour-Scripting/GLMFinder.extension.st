Extension { #name : #GLMFinder }

{ #category : #'*Glamour-Scripting' }
GLMFinder >> fromPrevious: aPortSymbol [
	self scriptTransmission addActiveOrigin: (GLMPort new name: aPortSymbol)
]

{ #category : #'*Glamour-Scripting' }
GLMFinder >> passivelyFromPrevious: aPortSymbol [
	self scriptTransmission addPassiveOrigin: (GLMPort new name: aPortSymbol)
]

{ #category : #'*Glamour-Scripting' }
GLMFinder >> using: aBlock [ 
	 
	aBlock value. 
	self addTransmission: scriptTransmission. 
	scriptTransmission := nil
]

{ #category : #'*Glamour-Scripting' }
GLMFinder >> variableSizePanes [
	self hasFixedSizePanes: false
]

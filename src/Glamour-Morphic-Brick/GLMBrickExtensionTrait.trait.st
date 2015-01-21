"
asdad
"
Trait {
	#name : #GLMBrickExtensionTrait,
	#category : #'Glamour-Morphic-Brick-Traits'
}

{ #category : #'private-extension' }
GLMBrickExtensionTrait >> removeProperty: aSymbol [
	
	^ self explicitRequirement
]

{ #category : #'private-extension' }
GLMBrickExtensionTrait >> setProperty: aSymbol toValue: anObject [
	
	^ self explicitRequirement
]

{ #category : #'private-extension' }
GLMBrickExtensionTrait >> valueOfProperty: aSymbol [
	
	^ self explicitRequirement
]

{ #category : #'private-extension' }
GLMBrickExtensionTrait >> valueOfProperty: aSymbol ifAbsent: aBlock [
	
	^ self explicitRequirement
]

{ #category : #'private-extension' }
GLMBrickExtensionTrait >> valueOfProperty: aSymbol ifAbsentPut: aBlock [ 
	
	^ self explicitRequirement
]

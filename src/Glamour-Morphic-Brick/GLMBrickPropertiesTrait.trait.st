"
asdadsad

"
Trait {
	#name : #GLMBrickPropertiesTrait,
	#traits : 'GLMBrickExtensionTrait',
	#classTraits : 'GLMBrickExtensionTrait classTrait',
	#category : #'Glamour-Morphic-Brick-Traits'
}

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> color [

	^ self valueOfProperty: #brickBackgroundColor ifAbsentPut: [ Color transparent ]
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> color: aColor [

	self setProperty: #brickBackgroundColor toValue: aColor
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> data [

	^ self valueOfProperty: #brickDataObject ifAbsentPut: [ nil ]
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> data: anObject [

	^ self setProperty: #brickDataObject  toValue:  anObject
]

{ #category : #'private-extension' }
GLMBrickPropertiesTrait >> removeProperty: aSymbol [
	
	^ self explicitRequirement
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> renderer [

	^ self valueOfProperty: #brickRenderer ifAbsentPut: [ nil ]
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> renderer: aRenderer [

	self setProperty: #brickRenderer toValue: aRenderer
]

{ #category : #'private-extension' }
GLMBrickPropertiesTrait >> setProperty: aSymbol toValue: anObject [
	
	^ self explicitRequirement
]

{ #category : #'private-extension' }
GLMBrickPropertiesTrait >> valueOfProperty: aSymbol [
	
	^ self explicitRequirement
]

{ #category : #'private-extension' }
GLMBrickPropertiesTrait >> valueOfProperty: aSymbol ifAbsent: aBlock [
	
	^ self explicitRequirement
]

{ #category : #'private-extension' }
GLMBrickPropertiesTrait >> valueOfProperty: aSymbol ifAbsentPut: aBlock [ 
	
	^ self explicitRequirement
]

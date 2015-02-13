"
I declare api and logic to work with properties of a Brick, such as color, shadow, renderer and more
"
Trait {
	#name : #GLMBrickPropertiesTrait,
	#traits : 'GLMBrickExtensionTrait',
	#classTraits : 'GLMBrickExtensionTrait classTrait',
	#category : #'Glamour-Morphic-Brick-Traits'
}

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> border [

	^ self valueOfProperty: #brickBorder ifAbsentPut: [ GLMBrickBorder new ]
	
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> border: aBorder [

	self setProperty: #brickBorder toValue: aBorder
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> borderColor [
	
	^ self border color
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> borderColor: anObject [
	<brickBuilderProperty: #'Look&Feel' name: 'Border color' as: #brickBuilderEvaluate getter: #borderColor model: #GLMUIBuilderTextFieldProperty>

	self border color: anObject
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> borderDo: aBlock [

	aBlock cull: self border.
	^ self
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> borderWidth [

	^ self border width
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> borderWidth: anObject [
	<brickBuilderProperty: #'Look&Feel' name: 'Border width' as: #brickBuilderEvaluate getter: #borderWidth model: #GLMUIBuilderTextFieldProperty>

	self border width: anObject
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> color [

	^ self valueOfProperty: #brickBackgroundColor ifAbsent: [ self themer backgroundColor ]
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> color: aColor [
	<brickBuilderProperty: #'Look&Feel' name: 'Color' as: #brickBuilderEvaluate getter: #color model: #GLMUIBuilderTextFieldProperty>

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

{ #category : #'brick-properties-testing' }
GLMBrickPropertiesTrait >> isColorSet [

	^ self hasProperty: #brickBackgroundColor
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> markBorderColor: aColor width: anInteger [

	self setProperty: #brickMarkBorderColor toValue: aColor.
	self setProperty: #brickMarkBorderWidth toValue: anInteger
]

{ #category : #'brick-properties-events' }
GLMBrickPropertiesTrait >> onThemerChanged [

]

{ #category : #'private-properties' }
GLMBrickPropertiesTrait >> privateThemer [

	^ self valueOfProperty: #brickThemer ifAbsentPut: [ nil ]
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

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> shadowColor [

	^ self valueOfProperty: #brickShadowColor ifAbsentPut: [ Color transparent ]
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> shadowColor: aColor [
	<brickBuilderProperty: #'Look&Feel' name: 'Shadow Color' as: #brickBuilderEvaluate getter: #shadowColor model: #GLMUIBuilderTextFieldProperty>

	self setProperty: #brickShadowColor toValue: aColor
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> shadowWidth [

	^ self valueOfProperty: #brickShadowWidth ifAbsentPut: [ 0 ]
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> shadowWidth: anInteger [
	<brickBuilderProperty: #'Look&Feel' name: 'Shadow Width' as: #asInteger getter: #shadowWidth model: #GLMUIBuilderTextFieldProperty>

	self setProperty: #brickShadowWidth toValue: anInteger
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> themer [

	^ self privateThemer
		ifNotNil: [ self privateThemer ]
		ifNil: [ self hasOwner
			ifTrue: [ self owner themer ]
			ifFalse: [ self theme brickThemer ] ]
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> themer: aThemer [

	self setProperty: #brickThemer toValue: aThemer.
	self themerChanged
]

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> themerChanged [

	self onThemerChanged.
	self subbricks do: #themerChanged
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

{ #category : #'brick-properties' }
GLMBrickPropertiesTrait >> with: aBlock [

	aBlock cull: self
]

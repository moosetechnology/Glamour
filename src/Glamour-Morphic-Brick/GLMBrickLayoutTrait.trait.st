"
I declare api and logic to layout Bricks
"
Trait {
	#name : #GLMBrickLayoutTrait,
	#category : #'Glamour-Morphic-Brick-Traits'
}

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> doLayout [

	GLMBrickLayouter uniqueInstance layoutIn: self
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> doLayoutForce [

	self wrappedBounds
		markHeightDirty;
		markWidthDirty.
	
	self doLayout
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> hResizing [

	^ self layout hResizing
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> hResizing: aSymbol [

	self layout hResizing: aSymbol
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> hShrinkWrap [

	self layout hShrinkWrap
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> hSpaceFill [

	self layout hSpaceFill
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> hSpaceFill: anInteger [

	self layout hSpaceFill: anInteger
]

{ #category : #'brick-geometry' }
GLMBrickLayoutTrait >> innerBounds [

	^ self explicitRequirement
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> invalidateLayout [

	self layoutPolicy layout: self in: self wrappedBounds innerBounds
]

{ #category : #'brick-structure-testing' }
GLMBrickLayoutTrait >> isHeightDependsOnChildren [
	"Returns true if my height depends only from my children, otherwise false.
	It means that layouter should first position my children and only then based on their
	sizes set my height"
	
	^ self vResizing = #shrinkWrap
]

{ #category : #'brick-structure-testing' }
GLMBrickLayoutTrait >> isHeightDependsOnMyself [
	"Returns true if my height depends only from myself, otherwise false.
	It means that layouter can immediately calculate and set it"
	
	^ self isHeightCustom
]

{ #category : #'brick-structure-testing' }
GLMBrickLayoutTrait >> isHeightDependsOnParent [
	"Returns true if my height depends only from my parent, otherwise false.
	It means that layouter must first calculate height of my parent and only then my"
	
	^ self vResizing = #spaceFill
]

{ #category : #'brick-structure-testing' }
GLMBrickLayoutTrait >> isHeightDependsOnWidth [
	"Returns true if my height depends from my width, otherwise false.
	It means that layouter must first calculate my width and as soon as it is done my height"
	
	^ self vResizing = #opposite
]

{ #category : #'brick-structure-testing' }
GLMBrickLayoutTrait >> isWidthDependsOnChildren [
	"Returns true if my width depends only from my children, otherwise false.
	It means that layouter should first position my children and only then based on their
	sizes set my width"
	
	^ self hResizing = #shrinkWrap
]

{ #category : #'brick-structure-testing' }
GLMBrickLayoutTrait >> isWidthDependsOnHeight [
	"Returns true if my width depends from my height, otherwise false.
	It means that layouter must first calculate my width and as soon as it is done my width"
	
	^ self hResizing = #opposite
]

{ #category : #'brick-structure-testing' }
GLMBrickLayoutTrait >> isWidthDependsOnMyself [
	"Returns true if my width depends only from myself, otherwise false.
	It means that layouter can immediately calculate and set it"
	
	^ self isWidthCustom
]

{ #category : #'brick-structure-testing' }
GLMBrickLayoutTrait >> isWidthDependsOnParent [
	"Returns true if my width depends only from my parent, otherwise false.
	It means that layouter must first calculate width of my parent and only then my"
	
	^ self hResizing = #spaceFill
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> layout [
	"Alias for layoutProperies"
	^ self layoutProperties
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> layout: aLayout [
	"Alias for layoutPolicy:"
	self layoutPolicy: aLayout
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> layoutAfter: aBlock [

	aBlock cull: self.
	self doLayout
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> layoutPolicy [

	^ self explicitRequirement
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> layoutPolicy: aLayout [

	self explicitRequirement
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> layoutProperties [

	^ self explicitRequirement
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> layoutProperties: aLayoutProperties [

	self explicitRequirement
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> layoutSubbricks [

	self layoutPolicy layout: self in: self innerBounds
]

{ #category : #'brick-layout-events' }
GLMBrickLayoutTrait >> onChildrenLayouted [
	"called when all my children finished layouting"
	self changed
]

{ #category : #'brick-layout-events' }
GLMBrickLayoutTrait >> onLayoutEvent: aLayoutEvent [
	"in case layout want's to trigger any specific event"
]

{ #category : #'brick-layout-events' }
GLMBrickLayoutTrait >> onLayouted [
	"called when I'm layouted in my parent"
	
]

{ #category : #'brick-structure' }
GLMBrickLayoutTrait >> subbricks [

	^ self explicitRequirement
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> useHorizontalLinearLayout [

	self layout: GLMHorizontalLinearLayout uniqueInstance
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> useVerticalLinearLayout [

	self layout: GLMVerticalLinearLayout uniqueInstance
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> vResizing [

	^ self layout vResizing
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> vResizing: aSymbol [

	self layout vResizing: aSymbol
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> vShrinkWrap [

	self layout vShrinkWrap
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> vSpaceFill [

	self layout vSpaceFill
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> vSpaceFill: anInteger [

	self layout vSpaceFill: anInteger
]

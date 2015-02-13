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
GLMBrickLayoutTrait >> hAlign [

	^ self layout hAlign
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> hAlign: aSymbol [
	<brickBuilderProperty: #Layout name: 'Horizontal align' as: #asSymbol getter: #hAlign model: #GLMUIBuilderTextFieldProperty>

	self layout hAlign: aSymbol
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> hPercent [

	^ self layout hPercent
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> hPercent: anInteger [

	self layout hPercent: anInteger
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> hResizing [

	^ self layout hResizing
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> hResizing: aSymbol [
	<brickBuilderProperty: #Layout name: 'Horizontal resizing' as: #asSymbol getter: #hResizing model: #GLMUIBuilderTextFieldProperty>

	self layout hResizing: aSymbol
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> hShrinkWrap [

	self layout hShrinkWrap.
	self privateWidth: nil
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> hSpaceFill [

	self layout hSpaceFill.
	self privateWidth: nil
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> hSpaceFill: anInteger [
	<brickBuilderProperty: #Layout name: 'Horizontal percent' as: #asInteger getter: #hPercent model: #GLMUIBuilderTextFieldProperty>

	self layout hSpaceFill: anInteger.
	self privateWidth: nil
]

{ #category : #'brick-geometry' }
GLMBrickLayoutTrait >> innerBounds [

	^ self explicitRequirement
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> invalidateLayout [

	self layoutPolicy layout: self in: self wrappedBounds innerBounds
]

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> invalidateWith: aBlock [

	self changed.
	aBlock cull: self.
	self doLayoutForce.
	self changed.
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
	<brickBuilderProperty: #Layout name: 'Orientation' as: #brickBuilderLayout getter: #layoutPolicy model: #GLMUIBuilderTextFieldProperty>

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

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> resetLayout [

	self vResizing: #rigid.
	self hResizing: #rigid.
	self height: nil.
	self width: nil
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
GLMBrickLayoutTrait >> vAlign [

	^ self layout vAlign
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> vAlign: aSymbol [
	<brickBuilderProperty: #Layout name: 'Vertical align' as: #asSymbol getter: #vAlign model: #GLMUIBuilderTextFieldProperty>

	self layout vAlign: aSymbol
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> vPercent [

	^ self layout vPercent
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> vPercent: anInteger [

	self layout vPercent: anInteger
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> vResizing [

	^ self layout vResizing
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> vResizing: aSymbol [
	<brickBuilderProperty: #Layout name: 'Vertical resizing' as: #asSymbol getter: #vResizing model: #GLMUIBuilderTextFieldProperty>

	self layout vResizing: aSymbol
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> vShrinkWrap [

	self layout vShrinkWrap.
	self privateHeight: nil
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> vSpaceFill [

	self layout vSpaceFill.
	self privateHeight: nil
]

{ #category : #'brick-layout-properties' }
GLMBrickLayoutTrait >> vSpaceFill: anInteger [
	<brickBuilderProperty: #Layout name: 'Vertical percent' as: #asInteger getter: #vPercent model: #GLMUIBuilderTextFieldProperty>

	self layout vSpaceFill: anInteger.
	self privateHeight: nil
]

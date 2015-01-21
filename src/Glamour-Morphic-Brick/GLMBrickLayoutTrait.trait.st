"
sss

"
Trait {
	#name : #GLMBrickLayoutTrait,
	#category : #'Glamour-Morphic-Brick-Traits'
}

{ #category : #'brick-layout' }
GLMBrickLayoutTrait >> doLayout [

	self layoutSubbricks.
	self subbricks do: [ :each | each doLayout ]
]

{ #category : #'brick-geometry' }
GLMBrickLayoutTrait >> innerBounds [

	^ self explicitRequirement
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
GLMBrickLayoutTrait >> onLayoutEvent: aLayoutEvent [
	"in case layout want's to trigger any specific event"
]

{ #category : #'brick-layout-events' }
GLMBrickLayoutTrait >> onPrepareLayout [
	"is called before I'm started layouting"
]

{ #category : #'brick-structure' }
GLMBrickLayoutTrait >> subbricks [

	^ self explicitRequirement
]

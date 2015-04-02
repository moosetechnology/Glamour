Class {
	#name : #GLMBrickWrapper,
	#superclass : #GLMBrickGeneralWrapper,
	#category : #'Glamour-Morphic-Brick-Layouts-Utils'
}

{ #category : #api }
GLMBrickWrapper >> brickBounds: aRectangle [

	^ self brick brickBounds: aRectangle
]

{ #category : #api }
GLMBrickWrapper >> customHeight [

	^ self brick customHeight
]

{ #category : #api }
GLMBrickWrapper >> customWidth [

	^ self brick customWidth
]

{ #category : #api }
GLMBrickWrapper >> extent [

	^ self brick extent
]

{ #category : #api }
GLMBrickWrapper >> floating [

	^ self brick floating
]

{ #category : #api }
GLMBrickWrapper >> hAlign [

	^ self brick hAlign
]

{ #category : #api }
GLMBrickWrapper >> hResizing [

	^ self brick hResizing
]

{ #category : #api }
GLMBrickWrapper >> height [

	^ self brick height
]

{ #category : #api }
GLMBrickWrapper >> innerBounds [

	^ self brick innerBounds
]

{ #category : #api }
GLMBrickWrapper >> invalidateLayout [

	^ self brick invalidateLayout
]

{ #category : #api }
GLMBrickWrapper >> isHeightDependsOnChildren [

	"Returns true if my height depends only from my children, otherwise false.
	It means that layouter should first position my children and only then based on their
	sizes set my height"
	
	^ self layout isVShrinkWrap
]

{ #category : #api }
GLMBrickWrapper >> isHeightDependsOnMyself [

	"Returns true if my height depends only from myself, otherwise false.
	It means that layouter can immediately calculate and set it"
	
	^ self layout isHeightCustom
]

{ #category : #api }
GLMBrickWrapper >> isHeightDependsOnParent [

	"Returns true if my height depends only from my parent, otherwise false.
	It means that layouter must first calculate height of my parent and only then my"
	
	^ self layout isVSpaceFill
]

{ #category : #api }
GLMBrickWrapper >> isHeightDependsOnWidth [

	"Returns true if my height depends from my width, otherwise false.
	It means that layouter must first calculate my width and as soon as it is done my height"
	
	^ self layout isVOpposite
]

{ #category : #api }
GLMBrickWrapper >> isWidthDependsOnChildren [

	"Returns true if my width depends only from my children, otherwise false.
	It means that layouter should first position my children and only then based on their
	sizes set my width"
	
	^ self layout isHShrinkWrap
]

{ #category : #api }
GLMBrickWrapper >> isWidthDependsOnHeight [
	"Returns true if my width depends from my height, otherwise false.
	It means that layouter must first calculate my width and as soon as it is done my width"
	
	^ self layout isHOpposite
]

{ #category : #api }
GLMBrickWrapper >> isWidthDependsOnMyself [
	"Returns true if my width depends only from myself, otherwise false.
	It means that layouter can immediately calculate and set it"
	
	^ self layout isWidthCustom
]

{ #category : #api }
GLMBrickWrapper >> isWidthDependsOnParent [
	"Returns true if my width depends only from my parent, otherwise false.
	It means that layouter must first calculate width of my parent and only then my"
	
	^ self layout isHSpaceFill
]

{ #category : #api }
GLMBrickWrapper >> marginBottom [

	^ self brick marginBottom
]

{ #category : #api }
GLMBrickWrapper >> marginLeft [

	^ self brick marginLeft
]

{ #category : #api }
GLMBrickWrapper >> marginRight [

	^ self brick marginRight
]

{ #category : #api }
GLMBrickWrapper >> marginTop [

	^ self brick marginTop
]

{ #category : #api }
GLMBrickWrapper >> onChildrenLayouted [

	^ self brick onChildrenLayouted
]

{ #category : #api }
GLMBrickWrapper >> onLayoutEvent: aLayoutEvent [

	^ self brick onLayoutEvent: aLayoutEvent
]

{ #category : #api }
GLMBrickWrapper >> onLayouted [

	^ self brick onLayouted
]

{ #category : #api }
GLMBrickWrapper >> outerBounds [

	^ self brick outerBounds
]

{ #category : #api }
GLMBrickWrapper >> paddingBottom [

	^ self brick paddingBottom
]

{ #category : #api }
GLMBrickWrapper >> paddingLeft [

	^ self brick paddingLeft
]

{ #category : #api }
GLMBrickWrapper >> paddingRight [

	^ self brick paddingRight
]

{ #category : #api }
GLMBrickWrapper >> paddingTop [

	^ self brick paddingTop
]

{ #category : #api }
GLMBrickWrapper >> translateX: anObject [

	^ self brick translateX: anObject
]

{ #category : #api }
GLMBrickWrapper >> translateY: anObject [

	^ self brick translateY: anObject
]

{ #category : #api }
GLMBrickWrapper >> vAlign [

	^ self brick vAlign
]

{ #category : #api }
GLMBrickWrapper >> vResizing [

	^ self brick vResizing
]

{ #category : #api }
GLMBrickWrapper >> width [

	^ self brick width
]

{ #category : #api }
GLMBrickWrapper >> wrappedBounds [

	^ self brick wrappedBounds
]

Class {
	#name : #GLMLinearLayout,
	#superclass : #LayoutPolicy,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #layout }
GLMLinearLayout >> align: aBrick in: parentBrick anchorPoint: aPoint [

	^ self subclassResponsibility
]

{ #category : #height }
GLMLinearLayout >> heightChildrenDependency: aBrick [

	^ self subclassResponsibility
]

{ #category : #height }
GLMLinearLayout >> heightMyselfDependency: aBrick [
	"when height depends only from aBrick just return its cutom height"
	
	^ aBrick customHeight
]

{ #category : #height }
GLMLinearLayout >> heightParentDependency: aBrick [

	^ self subclassResponsibility
]

{ #category : #layout }
GLMLinearLayout >> layout: aBrick in: newBounds [

	^ self subclassResponsibility
]

{ #category : #height }
GLMLinearLayout >> updateHeight: aBrick [
	"this method should be called only when height of aBrick is dirty"
	aBrick wrappedBounds isHeightClean ifTrue: [ Exception signal: 'Clean height can''t be updated!' ].
	"when my height depends on children I set it to be able to fit the highest subbrick"
	aBrick isHeightDependsOnChildren ifTrue: [ aBrick wrappedBounds outerHeight: (self heightChildrenDependency: aBrick) ].
	"when my height depends only from myself I can directly set it"
	aBrick isHeightDependsOnMyself ifTrue: [ aBrick wrappedBounds outerHeight: (self heightMyselfDependency: aBrick) ].
	"when my height depends only from my parent"
	aBrick isHeightDependsOnParent ifTrue: [ aBrick wrappedBounds outerHeight: (self heightParentDependency: aBrick) ].
	
	
	
]

{ #category : #width }
GLMLinearLayout >> updateWidth: aBrick [
	"aBrick is a Brick that uses me as current layout"
	"this method should be called only when width of aBrick is dirty"
	aBrick wrappedBounds isWidthClean ifTrue: [ Exception signal: 'Clean width can''t be updated!' ].
	"when my width depends on children I set it to be able to fit all subbricks"
	aBrick isWidthDependsOnChildren ifTrue: [ aBrick wrappedBounds outerWidth: (self widthChildrenDependency: aBrick) ].
	"when my width depends only from myself I can directly set it"
	aBrick isWidthDependsOnMyself ifTrue: [ aBrick wrappedBounds outerWidth: (self widthMyselfDependency: aBrick) ].
	"when my width depends only from my parent"
	aBrick isWidthDependsOnParent ifTrue: [ aBrick wrappedBounds outerWidth: (self widthParentDependency: aBrick) ].
	
	
	
]

{ #category : #width }
GLMLinearLayout >> widthChildrenDependency: aBrick [

	^ self subclassResponsibility
]

{ #category : #width }
GLMLinearLayout >> widthMyselfDependency: aBrick [

	^ aBrick customWidth
]

{ #category : #width }
GLMLinearLayout >> widthParentDependency: aBrick [
	
	^ self subclassResponsibility
]

"
A GLMBrickLayoutProperties is  a holder class of layout properties used by layout policy

Instance Variables
	horizontalPercent:		<Object>
	marginBottom:		<Object>
	marginLeft:		<Object>
	marginRight:		<Object>
	marginTop:		<Object>
	maxHeightBlock:		<Object>
	maxWidthBlock:		<Object>
	minHeight:		<Object>
	minWidth:		<Object>
	paddingBottom:		<Object>
	paddingLeft:		<Object>
	paddingRight:		<Object>
	paddingTop:		<Object>
	verticalPercent:		<Object>

horizontalPercent
	- xxxxx

marginBottom
	- xxxxx

marginLeft
	- xxxxx

marginRight
	- xxxxx

marginTop
	- xxxxx

maxHeightBlock
	- xxxxx

maxWidthBlock
	- xxxxx

minHeight
	- xxxxx

minWidth
	- xxxxx

paddingBottom
	- xxxxx

paddingLeft
	- xxxxx

paddingRight
	- xxxxx

paddingTop
	- xxxxx

verticalPercent
	- xxxxx

"
Class {
	#name : #GLMBrickLayoutProperties,
	#superclass : #TableLayoutProperties,
	#instVars : [
		'horizontalPercent',
		'verticalPercent',
		'maxWidthBlock',
		'maxHeightBlock',
		'minHeightBlock',
		'minWidthBlock',
		'floating',
		'zIndex',
		'widthDependencies',
		'heightDependencies',
		'vAlign',
		'hAlign'
	],
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #accessing }
GLMBrickLayoutProperties >> floating [
	^ floating
]

{ #category : #accessing }
GLMBrickLayoutProperties >> floating: aSymbol [
	floating := aSymbol
]

{ #category : #accessing }
GLMBrickLayoutProperties >> hAlign [

	^ hAlign
]

{ #category : #accessing }
GLMBrickLayoutProperties >> hAlign: aSymbol [

	hAlign := aSymbol
]

{ #category : #scripting }
GLMBrickLayoutProperties >> hPercent [

	^ self horizontalPercent
]

{ #category : #scripting }
GLMBrickLayoutProperties >> hPercent: anInteger [

	self horizontalPercent: anInteger
]

{ #category : #scripting }
GLMBrickLayoutProperties >> hShrinkWrap [
	"my width will change to fit children"
	self hResizing: #shrinkWrap
]

{ #category : #scripting }
GLMBrickLayoutProperties >> hSpaceFill [
	"my width will change to fill 100% of my parent"
	self hPercent: 100.
	self hResizing: #spaceFill
]

{ #category : #scripting }
GLMBrickLayoutProperties >> hSpaceFill: anInteger [
	"my width will change to fill anInteger percents of my parent"
	self hPercent: anInteger.
	self hResizing: #spaceFill
]

{ #category : #private }
GLMBrickLayoutProperties >> heightDependencies [

	^ heightDependencies ifNil: [ heightDependencies := OrderedCollection new ]
]

{ #category : #layout }
GLMBrickLayoutProperties >> heightDependency: anObject [

	self heightDependencies add: anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> horizontalPercent [
	^ horizontalPercent
]

{ #category : #accessing }
GLMBrickLayoutProperties >> horizontalPercent: anObject [
	horizontalPercent := anObject
]

{ #category : #initialization }
GLMBrickLayoutProperties >> initialize [
	super initialize.
	
	horizontalPercent := 0.
	verticalPercent := 0.
	zIndex := 1. "the lowest one"
	maxWidthBlock := [ :aTrick | -1 ]. "negative value means undefined"
	maxHeightBlock := [ :aTrick | -1 ]. "negative value means undefined"
	minWidthBlock := [ :aTrick | -1 ]. "negative value means undefined"
	minHeightBlock := [ :aTrick | -1 ]. "negative value means undefined"
	floating := #none.
	vAlign := #none.
	hAlign := #none
]

{ #category : #accessing }
GLMBrickLayoutProperties >> maxHeight: anObject [
	maxHeightBlock := [ anObject ]
]

{ #category : #accessing }
GLMBrickLayoutProperties >> maxHeightBlock [
	^ maxHeightBlock
]

{ #category : #accessing }
GLMBrickLayoutProperties >> maxHeightBlock: anObject [
	maxHeightBlock := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> maxWidth: anObject [
	maxWidthBlock := [ anObject ]
]

{ #category : #accessing }
GLMBrickLayoutProperties >> maxWidthBlock [
	^ maxWidthBlock
]

{ #category : #accessing }
GLMBrickLayoutProperties >> maxWidthBlock: anObject [
	maxWidthBlock := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> minHeight: anObject [
	minHeightBlock := [ anObject ]
]

{ #category : #accessing }
GLMBrickLayoutProperties >> minHeightBlock [
	^ minHeightBlock
]

{ #category : #accessing }
GLMBrickLayoutProperties >> minHeightBlock: anObject [
	minHeightBlock := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> minWidth: anObject [
	minWidthBlock := [ anObject ]
]

{ #category : #accessing }
GLMBrickLayoutProperties >> minWidthBlock [
	^ minWidthBlock
]

{ #category : #accessing }
GLMBrickLayoutProperties >> minWidthBlock: anObject [
	minWidthBlock := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> vAlign [

	^ vAlign
]

{ #category : #accessing }
GLMBrickLayoutProperties >> vAlign: aSymbol [

	vAlign := aSymbol
]

{ #category : #scripting }
GLMBrickLayoutProperties >> vPercent [

	^ self verticalPercent
]

{ #category : #scripting }
GLMBrickLayoutProperties >> vPercent: anInteger [

	self verticalPercent: anInteger
]

{ #category : #scripting }
GLMBrickLayoutProperties >> vShrinkWrap [

	self vResizing: #shrinkWrap
]

{ #category : #scripting }
GLMBrickLayoutProperties >> vSpaceFill [
	"my height will change to fill 100% of my parent"
	self vPercent: 100.
	self vResizing: #spaceFill
]

{ #category : #scripting }
GLMBrickLayoutProperties >> vSpaceFill: anInteger [
	"my height will change to fill anInteger percents of my parent"
	self vPercent: anInteger.
	self vResizing: #spaceFill
]

{ #category : #accessing }
GLMBrickLayoutProperties >> verticalPercent [
	^ verticalPercent
]

{ #category : #accessing }
GLMBrickLayoutProperties >> verticalPercent: anObject [
	verticalPercent := anObject
]

{ #category : #private }
GLMBrickLayoutProperties >> widthDependencies [

	^ widthDependencies ifNil: [ widthDependencies := OrderedCollection new ]	
]

{ #category : #layout }
GLMBrickLayoutProperties >> widthDependency: anObject [

	self widthDependencies add: anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> zIndex [
	^ zIndex
]

{ #category : #accessing }
GLMBrickLayoutProperties >> zIndex: anObject [
	zIndex := anObject
]

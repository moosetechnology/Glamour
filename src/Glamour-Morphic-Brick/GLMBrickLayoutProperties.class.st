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
		'marginTop',
		'marginRight',
		'marginBottom',
		'marginLeft',
		'paddingTop',
		'paddingRight',
		'paddingBottom',
		'paddingLeft',
		'horizontalPercent',
		'verticalPercent',
		'maxWidthBlock',
		'maxHeightBlock',
		'minHeightBlock',
		'minWidthBlock',
		'floating'
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
GLMBrickLayoutProperties >> horizontalMargin [

	^ self marginLeft + self marginRight
]

{ #category : #accessing }
GLMBrickLayoutProperties >> horizontalPadding [

	^ self paddingLeft + self paddingRight
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
	
	marginBottom := 0.
	marginLeft := 0.
	marginRight := 0.
	marginTop := 0.
	paddingBottom := 0.
	paddingLeft := 0.
	paddingRight := 0.
	paddingTop := 0.
	horizontalPercent := 25.
	verticalPercent := 25.
	maxWidthBlock := [ :aTrick | -1 ]. "negative value means undefined"
	maxHeightBlock := [ :aTrick | -1 ]. "negative value means undefined"
	minWidthBlock := [ :aTrick | -1 ]. "negative value means undefined"
	minHeightBlock := [ :aTrick | -1 ]. "negative value means undefined"
	floating := #none
]

{ #category : #accessing }
GLMBrickLayoutProperties >> marginBottom [
	^ marginBottom
]

{ #category : #accessing }
GLMBrickLayoutProperties >> marginBottom: anObject [
	marginBottom := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> marginLeft [
	^ marginLeft
]

{ #category : #accessing }
GLMBrickLayoutProperties >> marginLeft: anObject [
	marginLeft := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> marginRight [
	^ marginRight
]

{ #category : #accessing }
GLMBrickLayoutProperties >> marginRight: anObject [
	marginRight := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> marginTop [
	^ marginTop
]

{ #category : #accessing }
GLMBrickLayoutProperties >> marginTop: anObject [
	marginTop := anObject
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
GLMBrickLayoutProperties >> paddingBottom [
	^ paddingBottom
]

{ #category : #accessing }
GLMBrickLayoutProperties >> paddingBottom: anObject [
	paddingBottom := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> paddingLeft [
	^ paddingLeft
]

{ #category : #accessing }
GLMBrickLayoutProperties >> paddingLeft: anObject [
	paddingLeft := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> paddingRight [
	^ paddingRight
]

{ #category : #accessing }
GLMBrickLayoutProperties >> paddingRight: anObject [
	paddingRight := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> paddingTop [
	^ paddingTop
]

{ #category : #accessing }
GLMBrickLayoutProperties >> paddingTop: anObject [
	paddingTop := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> verticalMargin [

	^ self marginTop + self marginBottom
]

{ #category : #accessing }
GLMBrickLayoutProperties >> verticalPadding [

	^ self paddingTop + self paddingBottom
]

{ #category : #accessing }
GLMBrickLayoutProperties >> verticalPercent [
	^ verticalPercent
]

{ #category : #accessing }
GLMBrickLayoutProperties >> verticalPercent: anObject [
	verticalPercent := anObject
]

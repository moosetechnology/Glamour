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
		'minWidth',
		'minHeight',
		'maxWidthBlock',
		'maxHeightBlock',
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
	horizontalPercent := 10.
	verticalPercent := 10.
	minWidth := 0.
	minHeight := 0.
	maxWidthBlock := [ :aTrick | -1 ]. "negative value means undefined"
	maxHeightBlock := [ :aTrick | -1 ]. "negative value means undefined"
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
GLMBrickLayoutProperties >> maxHeightBlock [
	^ maxHeightBlock
]

{ #category : #accessing }
GLMBrickLayoutProperties >> maxHeightBlock: anObject [
	maxHeightBlock := anObject
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
GLMBrickLayoutProperties >> minHeight [
	^ minHeight
]

{ #category : #accessing }
GLMBrickLayoutProperties >> minHeight: anObject [
	minHeight := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> minWidth [
	^ minWidth
]

{ #category : #accessing }
GLMBrickLayoutProperties >> minWidth: anObject [
	minWidth := anObject
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
GLMBrickLayoutProperties >> verticalPercent [
	^ verticalPercent
]

{ #category : #accessing }
GLMBrickLayoutProperties >> verticalPercent: anObject [
	verticalPercent := anObject
]

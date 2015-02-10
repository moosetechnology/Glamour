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
		'floating',
		'hAlign',
		'heightDependencies',
		'horizontalPercent',
		'maxHeight',
		'maxWidth',
		'minHeight',
		'vAlign',
		'verticalPercent',
		'widthDependencies',
		'zIndex',
		'minWidth'
	],
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #accessing }
GLMBrickLayoutProperties >> floating [

	^ floating ifNil: [ floating := #none ]
]

{ #category : #scripting }
GLMBrickLayoutProperties >> floating: aSymbol [
	floating := aSymbol
]

{ #category : #accessing }
GLMBrickLayoutProperties >> hAlign [

	^ hAlign ifNil: [ hAlign := #none ]
]

{ #category : #scripting }
GLMBrickLayoutProperties >> hAlign: aSymbol [

	hAlign := aSymbol
]

{ #category : #scripting }
GLMBrickLayoutProperties >> hPercent [

	^ horizontalPercent ifNil: [ horizontalPercent := 0 ]
]

{ #category : #scripting }
GLMBrickLayoutProperties >> hPercent: anInteger [

	horizontalPercent := anInteger
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
GLMBrickLayoutProperties >> hasMaxHeight [

	^ (self maxHeight isNumber ifTrue: [ self maxHeight isInfinite ] ifFalse: [ false ]) not
]

{ #category : #private }
GLMBrickLayoutProperties >> hasMaxWidth [

	^ (self maxWidth isNumber ifTrue: [ self maxWidth isInfinite ] ifFalse: [ false ]) not
]

{ #category : #private }
GLMBrickLayoutProperties >> hasMinHeight [

	^ (self minHeight isNumber ifTrue: [ self minHeight <= 0 ] ifFalse: [ false ]) not
]

{ #category : #private }
GLMBrickLayoutProperties >> hasMinWidth [

	^ (self minWidth isNumber ifTrue: [ self minWidth <= 0 ] ifFalse: [ false ]) not
]

{ #category : #private }
GLMBrickLayoutProperties >> heightDependencies [

	^ heightDependencies ifNil: [ heightDependencies := OrderedCollection new ]
]

{ #category : #'scripting-advanced' }
GLMBrickLayoutProperties >> heightDependency: anObject [

	self heightDependencies add: anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> maxHeight [

	^ maxHeight ifNil: [ maxHeight := Float infinity ]
]

{ #category : #scripting }
GLMBrickLayoutProperties >> maxHeight: anObject [

	maxHeight := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> maxWidth [

	^ maxWidth ifNil: [ maxWidth := Float infinity ]
]

{ #category : #scripting }
GLMBrickLayoutProperties >> maxWidth: anObject [

	maxWidth := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> minHeight [

	^ minHeight ifNil: [ minHeight := 0 ]
]

{ #category : #scripting }
GLMBrickLayoutProperties >> minHeight: anObject [
	
	minHeight := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> minWidth [

	^ minWidth ifNil: [ minWidth := 0 ]
]

{ #category : #scripting }
GLMBrickLayoutProperties >> minWidth: anObject [
	minWidth := anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> vAlign [

	^ vAlign ifNil: [ vAlign := #none ]
]

{ #category : #scripting }
GLMBrickLayoutProperties >> vAlign: aSymbol [

	vAlign := aSymbol
]

{ #category : #scripting }
GLMBrickLayoutProperties >> vPercent [

	^ verticalPercent ifNil: [ verticalPercent := 0 ]
]

{ #category : #scripting }
GLMBrickLayoutProperties >> vPercent: anInteger [

	verticalPercent := anInteger
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

{ #category : #private }
GLMBrickLayoutProperties >> widthDependencies [

	^ widthDependencies ifNil: [ widthDependencies := OrderedCollection new ]	
]

{ #category : #'scripting-advanced' }
GLMBrickLayoutProperties >> widthDependency: anObject [

	self widthDependencies add: anObject
]

{ #category : #accessing }
GLMBrickLayoutProperties >> zIndex [

	^ zIndex ifNil: [ zIndex := 1 ]
]

{ #category : #scripting }
GLMBrickLayoutProperties >> zIndex: anObject [
	zIndex := anObject
]

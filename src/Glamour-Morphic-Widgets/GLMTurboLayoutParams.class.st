"
A GLMTurboLayoutParams is holder class layout parameters used by layout manager to gather additional information about layout

Instance Variables
	horizontalPercent:		<Object>
	marginBottom:		<Object>
	marginLeft:		<Object>
	marginRight:		<Object>
	marginTop:		<Object>
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

verticalPercent
	- xxxxx

"
Class {
	#name : #GLMTurboLayoutParams,
	#superclass : #Object,
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
		'minHeight'
	],
	#category : #'Glamour-Morphic-Widgets-Turbo-Layouts'
}

{ #category : #accessing }
GLMTurboLayoutParams >> horizontalPercent [
	^ horizontalPercent
]

{ #category : #accessing }
GLMTurboLayoutParams >> horizontalPercent: anObject [
	horizontalPercent := anObject
]

{ #category : #initialization }
GLMTurboLayoutParams >> initialize [
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
]

{ #category : #accessing }
GLMTurboLayoutParams >> marginBottom [
	^ marginBottom
]

{ #category : #accessing }
GLMTurboLayoutParams >> marginBottom: anObject [
	marginBottom := anObject
]

{ #category : #accessing }
GLMTurboLayoutParams >> marginLeft [
	^ marginLeft
]

{ #category : #accessing }
GLMTurboLayoutParams >> marginLeft: anObject [
	marginLeft := anObject
]

{ #category : #accessing }
GLMTurboLayoutParams >> marginRight [
	^ marginRight
]

{ #category : #accessing }
GLMTurboLayoutParams >> marginRight: anObject [
	marginRight := anObject
]

{ #category : #accessing }
GLMTurboLayoutParams >> marginTop [
	^ marginTop
]

{ #category : #accessing }
GLMTurboLayoutParams >> marginTop: anObject [
	marginTop := anObject
]

{ #category : #accessing }
GLMTurboLayoutParams >> minHeight [
	^ minHeight
]

{ #category : #accessing }
GLMTurboLayoutParams >> minHeight: anObject [
	minHeight := anObject
]

{ #category : #accessing }
GLMTurboLayoutParams >> minWidth [
	^ minWidth
]

{ #category : #accessing }
GLMTurboLayoutParams >> minWidth: anObject [
	minWidth := anObject
]

{ #category : #accessing }
GLMTurboLayoutParams >> paddingBottom [
	^ paddingBottom
]

{ #category : #accessing }
GLMTurboLayoutParams >> paddingBottom: anObject [
	paddingBottom := anObject
]

{ #category : #accessing }
GLMTurboLayoutParams >> paddingLeft [
	^ paddingLeft
]

{ #category : #accessing }
GLMTurboLayoutParams >> paddingLeft: anObject [
	paddingLeft := anObject
]

{ #category : #accessing }
GLMTurboLayoutParams >> paddingRight [
	^ paddingRight
]

{ #category : #accessing }
GLMTurboLayoutParams >> paddingRight: anObject [
	paddingRight := anObject
]

{ #category : #accessing }
GLMTurboLayoutParams >> paddingTop [
	^ paddingTop
]

{ #category : #accessing }
GLMTurboLayoutParams >> paddingTop: anObject [
	paddingTop := anObject
]

{ #category : #accessing }
GLMTurboLayoutParams >> verticalPercent [
	^ verticalPercent
]

{ #category : #accessing }
GLMTurboLayoutParams >> verticalPercent: anObject [
	verticalPercent := anObject
]

"
A GLMRoassalPresentation is xxxxxxxxx.

Instance Variables
	newViewBlock:		<Object>
	painting:		<Object>
	paintingBlock:		<Object>
	shouldPopulateSelection:		<Object>
	view:		<Object>

newViewBlock
	- xxxxx

painting
	- xxxxx

paintingBlock
	- xxxxx

shouldPopulateSelection
	- xxxxx

view
	- xxxxx

"
Class {
	#name : #GLMRoassal2Presentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'painting',
		'paintingBlock',
		'view',
		'shouldPopulateSelection',
		'newViewBlock'
	],
	#category : #'Glamour-Roassal2-Presentations'
}

{ #category : #'initialize-release' }
GLMRoassal2Presentation >> defaultActions [
	self act: [ :roassal |  RTZoomInMove on: roassal view ]
			icon: GLMUIThemeExtraIcons glamorousZoomIn
			entitled: 'Zoom in'.
	self act: [ :roassal |  RTZoomOutMove on: roassal view ]
			icon: GLMUIThemeExtraIcons glamorousZoomOut
			entitled: 'Zoom out'
]

{ #category : #'initialize-release' }
GLMRoassal2Presentation >> initialize [ 
	super initialize.
	newViewBlock := [ RTView new ].
	shouldPopulateSelection := true.
	self defaultActions
]

{ #category : #accessing }
GLMRoassal2Presentation >> initializeView: aZeroArgBlock [
	^ newViewBlock := aZeroArgBlock 
]

{ #category : #accessing }
GLMRoassal2Presentation >> newView [
	view := nil.
	^ self view
]

{ #category : #accessing }
GLMRoassal2Presentation >> newViewBlock [
	^ newViewBlock
]

{ #category : #scripting }
GLMRoassal2Presentation >> painting: anObject [
	paintingBlock := anObject
]

{ #category : #accessing }
GLMRoassal2Presentation >> paintingBlock [
	^ paintingBlock
]

{ #category : #rendering }
GLMRoassal2Presentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^ aRenderer renderRoassal2Presentation: self
]

{ #category : #accessing }
GLMRoassal2Presentation >> renderOn: aView [
	self paintingBlock glamourValue: (
								aView asGlamorousMultiValue, 
								self entity asGlamorousMultiValue,
								self asGlamorousMultiValue ).
"	self flag: 'This should be the responsibility of the the view'.
	aView applyLayout.	"
	self shouldPopulateSelection ifTrue: [
		aView elements do: [:each |  
			each on: TRMouseLeftClick do: [:event | self selection: each model ]] ].
	self view: aView
]

{ #category : #accessing }
GLMRoassal2Presentation >> shouldPopulateSelection [
	^ shouldPopulateSelection
]

{ #category : #accessing }
GLMRoassal2Presentation >> shouldPopulateSelection: anObject [
	shouldPopulateSelection := anObject
]

{ #category : #accessing }
GLMRoassal2Presentation >> view [
	^ view ifNil: [ view := self newViewBlock value ]
]

{ #category : #accessing }
GLMRoassal2Presentation >> view: anObject [
	view := anObject
]

Class {
	#name : #GLMRoassalPresentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'painting',
		'paintingBlock',
		'view',
		'shouldPopulateSelection'
	],
	#category : #'Glamour-Roassal-Presentations'
}

{ #category : #accessing }
GLMRoassalPresentation >> bitmap [ 
	^ self view bitmap 
]

{ #category : #scripting }
GLMRoassalPresentation >> defaultActions [
	self
		act: [ :roassal | ROExportPNGCommand new executeOn: roassal view raw ] 
			entitled: 'Export as PNG';
		act: [ :roassal | ROExportSVGCommand new executeOn: roassal view raw ] 
			entitled: 'Export as SVG';
		act: [ :roassal | ROZoomOutMove new on: roassal view raw ]
			icon: GLMUIThemeExtraIcons glamorousZoomOut
			entitled: 'Zoom out';
		act: [ :roassal | ROZoomInMove new on: roassal view raw ]
			icon: GLMUIThemeExtraIcons glamorousZoomIn
			entitled: 'Zoom in'
]

{ #category : #'initialize-release' }
GLMRoassalPresentation >> initialize [ 
	super initialize.
	shouldPopulateSelection := true.
	self defaultActions
]

{ #category : #scripting }
GLMRoassalPresentation >> painting: anObject [
	paintingBlock := anObject
]

{ #category : #accessing }
GLMRoassalPresentation >> paintingBlock [
	^ paintingBlock
]

{ #category : #rendering }
GLMRoassalPresentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^ aRenderer renderRoassalPresentation: self
]

{ #category : #accessing }
GLMRoassalPresentation >> renderOn: aView [
	self flag: 'find a smarter solution that does not depend on isKindOf:'. 
	self paintingBlock glamourValue: (
		(self entity isKindOf: GLMMultiValue) 
				ifTrue: [(GLMMultiValue with: aView) , self entity , (GLMMultiValue with: self)] 
				ifFalse: [GLMMultiValue with: aView with: self entity with: self]).
	self flag: 'This should be the responsibility of the the view'.
	aView applyLayout.	
	self shouldPopulateSelection ifTrue: [
		aView raw allElementsDo: [:each | 
			each on: ROMouseClick do: [:event | self selection: each model ]] ].
	self view: aView
]

{ #category : #accessing }
GLMRoassalPresentation >> shouldPopulateSelection [
	"this flag tells the presentation whether clicking on some element inside
	the view should populate the selection port from the pane containing the presentation"
	^ shouldPopulateSelection
]

{ #category : #accessing }
GLMRoassalPresentation >> shouldPopulateSelection: anObject [
	shouldPopulateSelection := anObject
]

{ #category : #accessing }
GLMRoassalPresentation >> view [
	^ view ifNil: [view := ROMondrianViewBuilder new]
]

{ #category : #accessing }
GLMRoassalPresentation >> view: anObject [
	view := anObject
]

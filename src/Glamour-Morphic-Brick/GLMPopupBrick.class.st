Class {
	#name : #GLMPopupBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'anchorBrick',
		'triggerBrick',
		'contentBrick'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-UI'
}

{ #category : #examples }
GLMPopupBrick class >> example [
	<example>
	
	self new asBrickedMorph openInWindow
]

{ #category : #'as yet unclassified' }
GLMPopupBrick >> anchorBrick [

	^ anchorBrick
]

{ #category : #'as yet unclassified' }
GLMPopupBrick >> anchorBrick: aBrick [

	anchorBrick := aBrick
]

{ #category : #'as yet unclassified' }
GLMPopupBrick >> contentBrick: aBrick [

	contentBrick := aBrick.
	contentBrick color: (Color r: 190 g: 236 b: 250 range: 255).
	contentBrick borderColor: (Color r: 48 g:194 b:240 range: 255).
	contentBrick borderWidth: 1.
	contentBrick layout zIndex: 2.
	self addBrickBack: contentBrick

	
]

{ #category : #initialization }
GLMPopupBrick >> initialize [
	super initialize.
	
	self useVerticalLinearLayout.
	self vShrinkWrap.
	self hShrinkWrap.
	
	self contentBrick: self newContentBrick.
	self triggerBrick: self newTriggerBrick.
	
	
]

{ #category : #'as yet unclassified' }
GLMPopupBrick >> newContentBrick [

	^ GLMLabelBrick new text: 'Press CMD+Right'; width: [ :b | b approximateWidth ]
]

{ #category : #'as yet unclassified' }
GLMPopupBrick >> newTriggerBrick [

	^ GLMActionButtonBrick new icon: GLMUIThemeExtraIcons glamorousExample; width: [ :b | b icon width ]
]

{ #category : #'as yet unclassified' }
GLMPopupBrick >> openAbove: aRectangle [
	"aRectangle must be in global coordinates"
	self asBrickedMorph
		bounds: ((aRectangle origin - (0@self height)) extent: self extent);
		openInWorld
	
]

{ #category : #'as yet unclassified' }
GLMPopupBrick >> openFor: aBrick [

	self anchorBrick: aBrick.
	self openAbove: aBrick globalBounds
]

{ #category : #'as yet unclassified' }
GLMPopupBrick >> triggerBrick: aBrick [

	triggerBrick := aBrick.
	triggerBrick color: (Color r: 190 g: 236 b: 250 range: 255).
	triggerBrick borderColor: (Color r: 48 g:194 b:240 range: 255).
	triggerBrick borderWidth: 1.
	triggerBrick marginTop: -2.
	self addBrickBack: aBrick.
]

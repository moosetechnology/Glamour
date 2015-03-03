Class {
	#name : #GLMPopupDialogBrick,
	#superclass : #GLMEmptyPopupBrick,
	#instVars : [
		'contentBricks'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-UI'
}

{ #category : #adding }
GLMPopupDialogBrick >> addCheckbox: aString action: aBlock checked: aBoolean [
	^ self addContentBrick: (
				GLMCheckboxBrick new 
					text: aString;
					check: aBoolean;
					action: aBlock;
					yourself)
]

{ #category : #adding }
GLMPopupDialogBrick >> addContentBrick: aBrick [
	^ self contentBricks addLast: aBrick
]

{ #category : #accessing }
GLMPopupDialogBrick >> addContentBricks [
	self contentBricks do: [ :eachBrick |
		self contentBrick addBrickBack: eachBrick ]
]

{ #category : #adding }
GLMPopupDialogBrick >> addText: aTextOrString [
	^ self addContentBrick: (GLMLabelBrick new text: aTextOrString; yourself)
]

{ #category : #accessing }
GLMPopupDialogBrick >> contentBricks [
	^ contentBricks ifNil: [ contentBricks := OrderedCollection new ]
]

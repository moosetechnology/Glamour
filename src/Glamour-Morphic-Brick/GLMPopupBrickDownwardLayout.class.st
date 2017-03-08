"
I am a special downward popup layout.
I make sure that content is below trigger brick
"
Class {
	#name : #GLMPopupBrickDownwardLayout,
	#superclass : #GLMPopupBrickLayout,
	#category : #'Glamour-Morphic-Brick-Widgets-UI-Popup'
}

{ #category : #building }
GLMPopupBrickDownwardLayout >> build: aPopup trigger: aTriggerBrick content: aContentBrick [

	aPopup removeAllBricks.
	aPopup triggerBrick: aTriggerBrick.
	aPopup contentBrick: aContentBrick
]

"
I am a popup closer responsible for determening when and how a popup should be hidden
"
Class {
	#name : #GLMPopupBrickCloser,
	#superclass : #GLMPopupBrickListener,
	#category : #'Glamour-Morphic-Brick-Widgets-UI-Popup'
}

{ #category : #action }
GLMPopupBrickCloser >> act [
	self popup close
]

Class {
	#name : #GLMToolbarPositionLeft,
	#superclass : #GLMToolbarPosition,
	#category : #'Glamour-Morphic-ToolbarWindow'
}

{ #category : #accessing }
GLMToolbarPositionLeft class >> kind [
	^ #left
]

{ #category : #'configuring morphs' }
GLMToolbarPositionLeft >> addToolbar: toolbarMorph to: aMorph [
	| frame |
	frame := (0 @ 0 corner: 0 @ 1) asLayoutFrame rightOffset: 28.
	aMorph addMorph: toolbarMorph fullFrame: frame.
	^ Margin left: 28 top: 0 right: 0 bottom: 0
]

{ #category : #'configuring morphs' }
GLMToolbarPositionLeft >> configureToolbar: dock [
	dock 
		listDirection: #topToBottom;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap
]

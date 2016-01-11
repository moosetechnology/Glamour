Class {
	#name : #GLMToolbarPositionTop,
	#superclass : #GLMToolbarPosition,
	#category : #'Glamour-Morphic-ToolbarWindow'
}

{ #category : #accessing }
GLMToolbarPositionTop class >> kind [
	^ #top
]

{ #category : #'configuring morphs' }
GLMToolbarPositionTop >> addToolbar: toolbarMorph to: aMorph [
	| frame |
	frame := (0@0 corner: 1@0) asLayoutFrame bottomOffset: 20.
	aMorph addMorph: toolbarMorph fullFrame: frame.
	^ Margin left: 0 top: 20 right: 0 bottom: 0
]

{ #category : #'configuring morphs' }
GLMToolbarPositionTop >> configureToolbar: dockMorph [
	 "No need to do anything since regular dock morphs are already configured to be on top"
]

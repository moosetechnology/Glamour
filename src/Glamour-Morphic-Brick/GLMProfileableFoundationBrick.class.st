Class {
	#name : #GLMProfileableFoundationBrick,
	#superclass : #GLMFoundationBrick,
	#category : #'Glamour-Morphic-Brick-Morphic'
}

{ #category : #'as yet unclassified' }
GLMProfileableFoundationBrick >> fullDrawOn: aCanvas [
	"preventing from drawing outside of me"
	[ super fullDrawOn: (aCanvas) ] timeProfile
]

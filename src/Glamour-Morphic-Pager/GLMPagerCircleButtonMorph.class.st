Class {
	#name : #GLMPagerCircleButtonMorph,
	#superclass : #GLMButton,
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMPagerCircleButtonMorph >> initialize [
	super initialize.
	
	self label: ''.
	
	self image state normal: GLMPagerIcons normalCircle.
	self image state selected: GLMPagerIcons selectedCircle.
	self image state checked: GLMPagerIcons checkedCircle.
]

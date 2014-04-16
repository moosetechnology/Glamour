Class {
	#name : #GLMPagerCircleButtonMorph,
	#superclass : #GLMButton,
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMPagerCircleButtonMorph >> initialize [
	super initialize.
	
	self label: ''.
	
	self image state normal: GLMUIThemeExtraIcons glamorousGrayCircleEmpty.
	self image state selected: GLMUIThemeExtraIcons glamorousGrayCircle.
	self image state checked: GLMUIThemeExtraIcons glamorousGrayCircle.
]

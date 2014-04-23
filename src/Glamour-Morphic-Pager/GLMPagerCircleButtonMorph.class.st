Class {
	#name : #GLMPagerCircleButtonMorph,
	#superclass : #GLMButton,
	#instVars : [
		'checkedIcon',
		'checkedFocusedIcon',
		'focused'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMPagerCircleButtonMorph >> initialize [
	super initialize.
	
	self label: ''.
	
	checkedIcon := GLMUIThemeExtraIcons glamorousGrayCircleEmpty.
	checkedFocusedIcon := GLMUIThemeExtraIcons glamorousGrayCircle.
	focused := false.
	
	self image state normal: GLMUIThemeExtraIcons glamorousGrayCircleEmpty.
	self image state selected: GLMUIThemeExtraIcons glamorousGrayCircle.
	self image state checked: checkedIcon.
]

{ #category : #'as yet unclassified' }
GLMPagerCircleButtonMorph >> isFocused [
	^ focused
]

{ #category : #'as yet unclassified' }
GLMPagerCircleButtonMorph >> onDeselected [
	super onDeselected.
]

{ #category : #'as yet unclassified' }
GLMPagerCircleButtonMorph >> onSelected [
	super onSelected.
	
]

{ #category : #'as yet unclassified' }
GLMPagerCircleButtonMorph >> setFocused [

	focused ifFalse: [
		self image state checked: checkedFocusedIcon.
		self buttonModel check.
		focused := true.
	]
]

{ #category : #'as yet unclassified' }
GLMPagerCircleButtonMorph >> setNotFocused [

	focused ifTrue: [
		self image state checked: checkedIcon.
		self buttonModel uncheck.
		focused := false.
	]
]

"
A GLMPagerCircleButtonMorph is a grey circle representing one pane in the pager.

Instance Variables
	checkedFocusedIcon:		<Form>
	checkedIcon:			<Form>
	focused:					<Form>

checkedFocusedIcon
	- which icon will be used for focused+checked state

checkedIcon
	- which icon will be used for checked state

focused
	- which icon will be used for focused state

"
Class {
	#name : #GLMPagerScrollButtonMorph,
	#superclass : #GLMButton,
	#instVars : [
		'checkedIcon',
		'checkedFocusedIcon',
		'focused'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMPagerScrollButtonMorph >> checkedFocusedIcon [
	^ checkedFocusedIcon
]

{ #category : #'as yet unclassified' }
GLMPagerScrollButtonMorph >> checkedFocusedIcon: aForm [
	checkedFocusedIcon := aForm.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollButtonMorph >> checkedIcon [
	^ checkedIcon
]

{ #category : #'as yet unclassified' }
GLMPagerScrollButtonMorph >> checkedIcon: aForm [
	checkedIcon := aForm.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollButtonMorph >> initialize [
	super initialize.

	focused := false.
]

{ #category : #'as yet unclassified' }
GLMPagerScrollButtonMorph >> isFocused [
	^ focused
]

{ #category : #'as yet unclassified' }
GLMPagerScrollButtonMorph >> setFocused [

	focused ifFalse: [
		self image state checked: checkedFocusedIcon.
		self buttonModel check.
		focused := true.
	]
]

{ #category : #'as yet unclassified' }
GLMPagerScrollButtonMorph >> setNotFocused [

	focused ifTrue: [
		self image state checked: checkedIcon.
		self buttonModel uncheck.
		focused := false.
	]
]

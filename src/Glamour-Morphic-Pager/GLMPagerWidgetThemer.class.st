Class {
	#name : #GLMPagerWidgetThemer,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMPagerWidgetThemer >> defaultScrollButtonStyleFor: aButton [

	aButton checkedIcon: GLMUIThemeExtraIcons glamorousGrayCircleEmpty.
	aButton checkedFocusedIcon: GLMUIThemeExtraIcons glamorousGrayCircle.
	
	aButton image state normal: GLMUIThemeExtraIcons glamorousGrayCircleEmpty.
	aButton image state selected: GLMUIThemeExtraIcons glamorousGrayCircle.
	aButton image state checked: aButton checkedIcon.
]

{ #category : #'as yet unclassified' }
GLMPagerWidgetThemer >> previewPaneStyleFor: aMorph [

	aMorph borderColor: (Color lightGray)
]

{ #category : #'as yet unclassified' }
GLMPagerWidgetThemer >> selectedPaneStyleFor: aMorph [

	aMorph borderColor: (Color transparent)
]

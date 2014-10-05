Class {
	#name : #GLMTurboHorizontalLinearLayout,
	#superclass : #GLMTurboLayout,
	#category : #'Glamour-Morphic-Widgets-Turbo-Layouts'
}

{ #category : #'as yet unclassified' }
GLMTurboHorizontalLinearLayout >> position: aTrick [
	
	aTrick subtricks
		inject: 0
		into: [ :width :each |
			|left top |
			top := each layoutParams marginTop.
			
			width := width + each layoutParams marginLeft.
			left := width.
			
			each bounds: ((left@top) extent: (self extentOf: each in: aTrick)).
			width + each width + each layoutParams marginRight.
		]

	
]

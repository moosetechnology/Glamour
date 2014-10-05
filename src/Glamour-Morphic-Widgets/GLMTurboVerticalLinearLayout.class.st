Class {
	#name : #GLMTurboVerticalLinearLayout,
	#superclass : #GLMTurboLayout,
	#category : #'Glamour-Morphic-Widgets-Turbo-Layouts'
}

{ #category : #'as yet unclassified' }
GLMTurboVerticalLinearLayout >> position: aTrick [
	
	aTrick subtricks
		inject: 0
		into: [ :topOffset :each |
			|left top |
			topOffset := topOffset + each layoutParams marginTop.
			
			left := each layoutParams marginLeft.
			top := topOffset.
			
			each bounds: ((left@topOffset) extent: (self extentOf: each in: aTrick)).
			topOffset + each height + each layoutParams marginBottom.
		]

	
]

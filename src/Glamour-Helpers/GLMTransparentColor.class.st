Class {
	#name : #GLMTransparentColor,
	#superclass : #GLMColor,
	#category : #'Glamour-Helpers'
}

{ #category : #accessing }
GLMTransparentColor >> cssColor [ 

	^ 'transparent'
]

{ #category : #accessing }
GLMTransparentColor >> morphicColor [ 

	^ Color transparent
]

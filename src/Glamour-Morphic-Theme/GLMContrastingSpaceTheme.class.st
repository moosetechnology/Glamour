"
PolymorphSystemSettings desktopColor: Color white.
self defaultSettings: nil.
self beCurrent.
"
Class {
	#name : #GLMContrastingSpaceTheme,
	#superclass : #GLMWhitespaceTheme,
	#category : #'Glamour-Morphic-Theme'
}

{ #category : #accessing }
GLMContrastingSpaceTheme class >> themeName [
	^ 'Glamorous Contrast'
]

{ #category : #'fill-styles' }
GLMContrastingSpaceTheme >> windowActiveFillStyleFor: aWindow [
	"We do not want the lighting effect when the window goes inactive"
	^ SolidFillStyle color: (self class lightBaseColor)
]

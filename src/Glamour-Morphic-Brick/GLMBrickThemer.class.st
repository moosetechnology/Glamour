Class {
	#name : #GLMBrickThemer,
	#superclass : #Object,
	#traits : 'GLMBrickScrollpaneStyle + GLMBrickRubricStyle + GLMBrickWindowStyle + GLMBrickButtonStyle',
	#classTraits : 'GLMBrickScrollpaneStyle classTrait + GLMBrickRubricStyle classTrait + GLMBrickWindowStyle classTrait + GLMBrickButtonStyle classTrait',
	#instVars : [
		'modules'
	],
	#category : #'Glamour-Morphic-Brick-Theme'
}

{ #category : #'brick-modules' }
GLMBrickThemer >> addModule: aThemerModule named: aSymbol [

	self modules at: aSymbol put: aThemerModule.
	aThemerModule themer: self.
	^ aThemerModule
]

{ #category : #brick }
GLMBrickThemer >> backgroundColor [

	^ Color transparent
]

{ #category : #brick }
GLMBrickThemer >> contentBackgroundColor [

	^ Color white
]

{ #category : #'brick-modules' }
GLMBrickThemer >> doesNotUnderstand: aMessage [

	^ self modules at: aMessage selector ifAbsent: [ super doesNotUnderstand: aMessage ]
	
]

{ #category : #'brick-modules' }
GLMBrickThemer >> modules [

	^ modules ifNil: [ modules := Dictionary new ]
]

{ #category : #'*Glamour-Morphic-Brick' }
GLMBrickThemer >> popupErrorThemer [

	^ self
		registerModule: GLMBrickPopupErrorThemer new
		to: self
		named: #popupThemer
]

{ #category : #'*Glamour-Morphic-Brick' }
GLMBrickThemer >> popupHelpThemer [

	^ self
		registerModule: GLMBrickPopupHelpThemer new
		to: self
		named: #popupThemer
]

{ #category : #'*Glamour-Morphic-Brick' }
GLMBrickThemer >> popupSuccessThemer [

	^ self
		registerModule: GLMBrickPopupSuccessThemer new
		to: self
		named: #popupThemer
]

{ #category : #'*Glamour-Morphic-Brick' }
GLMBrickThemer >> popupThemer [

	^ self
		registerModule: GLMBrickPopupThemer new
		to: self
]

{ #category : #'brick-modules' }
GLMBrickThemer >> registerModule: aModule to: aThemer [

	^ self
		registerModule: aModule
		to: aThemer
		named: thisContext sender selector
]

{ #category : #'brick-modules' }
GLMBrickThemer >> registerModule: aModule to: aThemer named: aString [
	"Registers aModule to aThemer. It stores modules in a dictionaty where a key is a selector of my caller method. It allows to customize bricks that are not added to the application (in this case they don't have access to custom themer normaly, because owner is nil) using the same api as added one."
	^ self modules
		at: aString
		ifAbsent: [ aThemer addModule: aModule named: aString ]
]

{ #category : #brick }
GLMBrickThemer >> textColor [

	^ Color black
]

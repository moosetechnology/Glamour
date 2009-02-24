Class {
	#name : #GLTutorialClass,
	#superclass : #Object,
	#instVars : [
		'class'
	],
	#category : #'Glamour-Examples'
}

{ #category : #'public interface' }
GLTutorialClass >> allMethodNames [
	
	^self clas organization elements
]

{ #category : #'public interface' }
GLTutorialClass >> categoryNames [
	
	^self clas organization categories
]

{ #category : #accessing }
GLTutorialClass >> clas [
	
	^class
]

{ #category : #accessing }
GLTutorialClass >> clas: aClass [
	
	class := aClass
]

{ #category : #printing }
GLTutorialClass >> displayString [
	
	^self clas displayString
]

{ #category : #'public interface' }
GLTutorialClass >> methodNamesIn: aCategorySymbol [
	
	^self clas organization listAtCategoryNamed: aCategorySymbol
]

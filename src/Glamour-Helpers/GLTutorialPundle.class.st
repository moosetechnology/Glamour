Class {
	#name : #GLTutorialPundle,
	#superclass : #Object,
	#instVars : [
		'pundle'
	],
	#category : #'Glamour-Examples'
}

{ #category : #'public interface' }
GLTutorialPundle >> childPundles [
	
	^self pundle containedItems
		collect:
			[:each | 
			(GLTutorialPundle new)
				pundle: each;
				yourself]
]

{ #category : #'public interface' }
GLTutorialPundle >> containedClasses [
	
	^self pundle item allDefinedClasses
		collect: [:each | GLTutorialClass new clas: each]
]

{ #category : #printing }
GLTutorialPundle >> displayString [
	
	^self pundle displayString
]

{ #category : #'public interface' }
GLTutorialPundle >> isBundle [
	
	^self pundle item isBundle
]

{ #category : #'public interface' }
GLTutorialPundle >> isPackage [
	
	^self pundle item isPackage
]

{ #category : #accessing }
GLTutorialPundle >> pundle [
	
	^pundle
]

{ #category : #accessing }
GLTutorialPundle >> pundle: aPundle [
	
	pundle := aPundle
]

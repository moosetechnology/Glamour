Class {
	#name : #GLMPagerButtonFontModel,
	#superclass : #Object,
	#instVars : [
		'font',
		'color',
		'familyName',
		'size',
		'announcer'
	],
	#category : #'Glamour-Morphic-Pager-Model'
}

{ #category : #accessing }
GLMPagerButtonFontModel >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GLMPagerButtonFontModel >> color [
	^ color
]

{ #category : #accessing }
GLMPagerButtonFontModel >> color: aColor [
	color := aColor.
	self updateFont.
]

{ #category : #defaults }
GLMPagerButtonFontModel >> defaultColor [
	^ Color black
]

{ #category : #defaults }
GLMPagerButtonFontModel >> defaultFamilyName [
	^ 'Source Sans'
]

{ #category : #defaults }
GLMPagerButtonFontModel >> defaultSize [
	^ 12
]

{ #category : #accessing }
GLMPagerButtonFontModel >> familyName [
	^ familyName
]

{ #category : #accessing }
GLMPagerButtonFontModel >> familyName: aString [
	familyName := aString.
	self updateFont.
]

{ #category : #initialization }
GLMPagerButtonFontModel >> initialize [
	super initialize.
	
	size := self defaultSize.
	familyName := self defaultFamilyName.
	color := self defaultColor.
	
	self updateFont.

]

{ #category : #accessing }
GLMPagerButtonFontModel >> logicalFont [
	^ font
]

{ #category : #accessing }
GLMPagerButtonFontModel >> logicalFont: aFont [
	font := aFont.
	familyName := font familyName.
	size := font pointSize.
	self notifyUpdate.
]

{ #category : #private }
GLMPagerButtonFontModel >> notifyUpdate [
	self announcer announce: GLMPagerButtonFontUpdated new.
]

{ #category : #accessing }
GLMPagerButtonFontModel >> size [
	^ size
]

{ #category : #accessing }
GLMPagerButtonFontModel >> size: aNumber [
	size := aNumber.
	self updateFont.
]

{ #category : #private }
GLMPagerButtonFontModel >> updateFont [
	font := LogicalFont familyName: self familyName pointSize: self size.
	self notifyUpdate.
]

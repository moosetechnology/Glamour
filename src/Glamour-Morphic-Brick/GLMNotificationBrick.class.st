Class {
	#name : #GLMNotificationBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'headerBrick',
		'contentBrick',
		'footerBrick',
		'titleBrick',
		'messageBrick',
		'actionbarBrick'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-UI'
}

{ #category : #accessing }
GLMNotificationBrick >> actionbarBrick [
	^ actionbarBrick
]

{ #category : #accessing }
GLMNotificationBrick >> actionbarBrick: anObject [
	actionbarBrick := anObject
]

{ #category : #accessing }
GLMNotificationBrick >> contentBrick [
	^ contentBrick
]

{ #category : #accessing }
GLMNotificationBrick >> contentBrick: anObject [
	contentBrick := anObject
]

{ #category : #accessing }
GLMNotificationBrick >> footerBrick [
	^ footerBrick
]

{ #category : #accessing }
GLMNotificationBrick >> footerBrick: anObject [
	footerBrick := anObject
]

{ #category : #accessing }
GLMNotificationBrick >> headerBrick [
	^ headerBrick
]

{ #category : #accessing }
GLMNotificationBrick >> headerBrick: anObject [
	headerBrick := anObject
]

{ #category : #accessing }
GLMNotificationBrick >> messageBrick [
	^ messageBrick
]

{ #category : #accessing }
GLMNotificationBrick >> messageBrick: anObject [
	messageBrick := anObject
]

{ #category : #accessing }
GLMNotificationBrick >> titleBrick [
	^ titleBrick
]

{ #category : #accessing }
GLMNotificationBrick >> titleBrick: anObject [
	titleBrick := anObject
]

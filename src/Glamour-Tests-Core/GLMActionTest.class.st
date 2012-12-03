Class {
	#name : #GLMActionTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #tests }
GLMActionTest >> testShortcutAsString [
	| action |
	action := GLMAction new.
	action shortcut: $i.
	self assert: action shortcutAsString = 'alt+i'.
	action shortcut: $I.
	self assert: action shortcutAsString = 'alt+shift+i'
]

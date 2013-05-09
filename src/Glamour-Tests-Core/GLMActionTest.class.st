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
	self assert: action shortcutAsString equals: 'alt+i'.
	action shortcut: $I.
	self assert: action shortcutAsString equals: 'alt+shift+i'.
	action shortcut: nil.
	self assert: action shortcutAsString isEmpty
]

Class {
	#name : #GLMActionTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #tests }
GLMActionTest >> testCondition [
	self 
		assert: (GLMAction new isAvailableOn: GLMPresentation new).
	self 
		deny: (GLMAction new 
			condition: [ false ];
			isAvailableOn: GLMPresentation new).
	self 
		deny: (GLMAction new 
			condition: [ :presentation :entity | false ];
			isAvailableOn: GLMPresentation new)
]

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

Class {
	#name : #GLMEyeSeeMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-EyeSee'
}

{ #category : #tests }
GLMEyeSeeMorphicTest >> expectedFailures [
	^ #(testUnregisterFromAnnouncementsWhenUpdating)
]

{ #category : #tests }
GLMEyeSeeMorphicTest >> testSelection [
	| browser canvas |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit
		to: #one;
		andShow: [ :a | 
					a eyesee
						diagram: [ :renderer :input | 
							renderer verticalBarDiagram
								y: #value;
								models: (1 to: input) ] ].
	window := browser openOn: 42.
	canvas := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	(browser panes first port: #selection) value: 43.
	self assert: (browser panes first port: #selection) value equals: 43
]

{ #category : #tests }
GLMEyeSeeMorphicTest >> testSpawn [
	| browser canvas |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a eyesee diagram: [:renderer :input | 
			renderer verticalBarDiagram y: #value; models: (1 to: input) ]].
	window := browser openOn: 42.
	World doOneCycle.
	World doOneCycle.
	World doOneCycle.
	canvas := window submorphs last submorphs first submorphs first submorphs last submorphs first.
	self assert: (canvas isKindOf: ESCanvas).
]

{ #category : #tests }
GLMEyeSeeMorphicTest >> testUnregisterFromAnnouncementsWhenUpdating [
	| browser announcingCollection numberOfExecutions |
	numberOfExecutions := 0.
	announcingCollection := GLMAnnouncingCollection new.
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit
		to: #one;
		andShow: [ :a | 
					a eyesee
						updateOn: GLMItemAdded from: [ announcingCollection ];
						diagram: [ :view | 
									numberOfExecutions := numberOfExecutions + 1.
									view verticalBarDiagram ] ].
	window := browser openOn: announcingCollection.
	1 to: 3 do: [ :each | announcingCollection add: each ].
	self assert: numberOfExecutions equals: 4	"it should not be 8"
]

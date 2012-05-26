"
This is a special widget renderer in that it will get to render multiple panes on the same container morph provided by a unique instance of the GLMWatcherWindow.
"
Class {
	#name : #GLMMorphicWatcherRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'process'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicWatcherRenderer >> actOnMatchingPresentationsChanged: anAnnouncement [
	"whenever a relevant pane changes its presentations,
	we override the contents from the GLMWatcherWindow"
	
	| newMorph |

	"if we are still rendering some contents for another watcher,
	we stop and replace with the current request"
	process ifNotNil: [ process terminate. ].
	process := nil.
	
	process := [
		WorldState addDeferredUIMessage:  [
			newMorph := self renderObject: anAnnouncement pane.
			GLMWatcherWindow uniqueInstance contentsMorph
				removeAllMorphs;
				addMorph: newMorph
				fullFrame: (LayoutFrame fractions: (0@0 corner: 1@1))	
		]
	] newProcess. 
	process priority: Processor userBackgroundPriority.
	process resume
]

{ #category : #rendering }
GLMMorphicWatcherRenderer >> render: aPane [
	"we just register for the announcement."
	aPane
		on: GLMMatchingPresentationsChanged
		send: #actOnMatchingPresentationsChanged:
		to: self
	
]

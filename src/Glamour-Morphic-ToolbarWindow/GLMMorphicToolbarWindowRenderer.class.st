Class {
	#name : #GLMMorphicToolbarWindowRenderer,
	#superclass : #GLMMorphicWindowRenderer,
	#category : #'Glamour-Morphic-ToolbarWindow'
}

{ #category : #private }
GLMMorphicToolbarWindowRenderer >> basicRender: aRenderable [
	| toolbarMorph contentMorph toolbarOffsets topOffset bottomOffset |

	toolbarOffsets := 0@0 corner: 0@0.
	topOffset := 4.
	bottomOffset := self handlePotentialStatusbarFor: aRenderable.

	self setLabelOf: window for: aRenderable.
	aRenderable hasToolbar ifTrue: [ 
		toolbarMorph := self renderToolbarForPresentation: aRenderable inMorph: window.
		window toolbarMorph: toolbarMorph.
		toolbarOffsets := aRenderable toolbarPosition 
			addToolbar: toolbarMorph 
			to: window ].

	contentMorph := self renderObject: aRenderable. 
	window contentMorph: contentMorph.	
	window
		addMorph: contentMorph
		fullFrame: ((0@0 corner: 1@1) asLayoutFrame 
			leftOffset: toolbarOffsets left;
			topOffset: topOffset + toolbarOffsets top;
			rightOffset: toolbarOffsets right;
			bottomOffset: bottomOffset + toolbarOffsets bottom;
			yourself).
	
	self setPotentialBackgroundColorFor: aRenderable.
	aRenderable when: GLMPresentationUpdated send: #actOnPresentationUpdated: to: self.
	aRenderable watcherPane notNil
		ifTrue: [ GLMMorphicWatcherRenderer render: aRenderable watcherPane from: self renderer ].
	
	^ window
]

{ #category : #accessing }
GLMMorphicToolbarWindowRenderer >> refresh: aRenderable [
	self removePresentationMorphs.	
	^ self basicRender: aRenderable
]

{ #category : #private }
GLMMorphicToolbarWindowRenderer >> removePresentationMorphs [
	window ifNil: [ ^ self ].
	window toolbarMorph ifNotNil: [ :morph | window removeMorph: morph ].
	window removeMorph: window contentMorph
]

{ #category : #rendering }
GLMMorphicToolbarWindowRenderer >> render: aRenderable [

	window := GLMToolbarWindow new model: aRenderable.

	self installActionsOnModel: window fromPresentation: aRenderable .
	self installKeystrokeActionsOnMorph: window fromPresentation: aRenderable.

	^ self basicRender: aRenderable
]

{ #category : #rendering }
GLMMorphicToolbarWindowRenderer >> renderToolbarForPresentation: aPresentation inMorph: aMorph [
	| dock buttons |
	
	dock := aMorph theme newToolDockingBarIn: aMorph.
	aPresentation toolbarPosition configureToolbar: dock.
	buttons := self toolbarButtonsForPresentation: aPresentation.
	dock addAllMorphs: buttons.
	
	^ dock
]

{ #category : #private }
GLMMorphicToolbarWindowRenderer >> toolbarButtonsForPresentation: aPresentation [
	^ aPresentation allActions 
		select: [:each | each isButton and: [ each isAvailableOn: aPresentation ]]
		thenCollect: [:each | |actionMorph|
			actionMorph := ((each renderGlamorouslyOn: self renderer)
				"enabled: (each isEnabledOn: aPresentation);"
				yourself).
			actionMorph arguments 
				ifNil: [ actionMorph arguments: { aPresentation } ]
				ifNotNil: [ actionMorph arguments: ({ aPresentation }, actionMorph arguments) ].
			actionMorph ].
	
]

{ #category : #accessing }
GLMMorphicToolbarWindowRenderer >> window: aWindow [
	window := aWindow
]

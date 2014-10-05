Class {
	#name : #GLMMorphicPaneRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'container',
		'contentMorph'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicPaneRenderer >> actOnMatchingPresentationChanged: anAnnouncement [
	container removeAllMorphs.
	self renderContainerFor: anAnnouncement pane.
	self renderer window
		ifNotNil: [ 
			self flag: 'this check is fishy'.
			self renderer window fullBounds ]
]

{ #category : #rendering }
GLMMorphicPaneRenderer >> actOnPresentationToolbarUpdated: anAnnouncement [
	"If this method is called contentMorph should be an tab widget"
	
	(contentMorph pages at: 1)
			toolbar: (self 
				renderToolbarForPresentation: anAnnouncement presentation 
				inMorph: contentMorph ).
	contentMorph updatePageIndex: 1
	
	
]

{ #category : #rendering }
GLMMorphicPaneRenderer >> render: aPane [
	container := GLMMorphic containerMorph.
	self renderContainerFor: aPane.
	aPane on: GLMMatchingPresentationsChanged send: #actOnMatchingPresentationChanged: to: self.
	(aPane presentations hasTitle or: [aPane presentations hasTitleIcon]) ifTrue: [
		aPane on: GLMPresentationToolbarUpdated send: #actOnPresentationToolbarUpdated: to: self. ].
	^ container
]

{ #category : #rendering }
GLMMorphicPaneRenderer >> renderContainerFor: aPane [

	contentMorph := self 
		morph: (self renderObject: aPane presentations) 
		withTitleOrNilOf: aPane presentations.
		
	container
		addMorph: contentMorph fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		adoptPaneColor: Color transparent
]

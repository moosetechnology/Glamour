Class {
	#name : #GLMMorphicAccumulatorRenderer,
	#superclass : #GLMMorphicBrowserRenderer,
	#instVars : [
		'tabs'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicAccumulatorRenderer >> actOnPaneAdded: ann [ 
	tabs 
		addLazyPage: (GLMMorphicPaneWithoutTitleRenderer new render: ann pane) 
		label: (self titleOrIconOf: ann pane presentations in: tabs)
		toolbar: nil
		collapsable: true.
	tabs selectedPageIndex: tabs pages size
]

{ #category : #rendering }
GLMMorphicAccumulatorRenderer >> actOnPaneSelected: anAnnouncement [
	tabs selectedPageIndex: anAnnouncement position
]

{ #category : #rendering }
GLMMorphicAccumulatorRenderer >> render: aBrowser [
	aBrowser panes isEmpty ifTrue: [ ^ GLMMorphic emptyMorph ].
	tabs := LazyTabGroupMorph new.
	tabs
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		cornerStyle: (self theme tabGroupCornerStyleIn: nil);
		font: self theme labelFont.
	tabs announcer on: LazyTabPageChanged do: [:ann |  
		aBrowser activeEntity: ((aBrowser panes at: ann pageIndex) port: #entity) value ].
	tabs announcer on: LazyTabPageRemoved do: [:ann |  
		aBrowser removePaneIndex: ann pageIndex ].
	aBrowser panes do: [ :each | 
		tabs 
			addLazyPage: [ GLMMorphicPaneWithoutTitleRenderer new render: each ]
			label: (self titleOrIconOf: each presentations in: tabs)
			toolbar: (self renderToolbarForPresentation: each presentations inMorph: tabs )
			collapsable: true ].
	aBrowser on: GLMPaneSelected send: #actOnPaneSelected: to: self.
	aBrowser on: GLMPaneAdded send: #actOnPaneAdded: to: self.
	tabs selectedPageIndex: tabs pages size.
	^ tabs
]

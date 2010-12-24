Class {
	#name : #SGLPanePresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'pane'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #initialization }
SGLPanePresenter >> initializeFor: aPane [
	pane := aPane
]

{ #category : #rendering }
SGLPanePresenter >> renderContentOn: html [
	pane whenMatchingPresentationsChanged: [ :ann |
		self renderer
			scriptFor: pane
			put: ((html jQuery id: (self renderer uuidFor: pane))
				glamourHtml: [ :aRenderer |
					self renderPaneOn: aRenderer]) ].
	self renderPaneOn: html
	

]

{ #category : #rendering }
SGLPanePresenter >> renderPaneOn: html [
	self renderWithTitleOrNil: pane presentations on: html
]

Class {
	#name : #SGLPanePresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'pane'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #rendering }
SGLPanePresenter >> actOnMatchingPresentationChanged: anAnnouncement [ 
	self renderer
		scriptFor: pane
		put: ((self renderer html jQuery id: (self renderer uuidFor: pane))
			glamourHtml: [ :aRenderer |
				self renderPaneOn: aRenderer])
]

{ #category : #initialization }
SGLPanePresenter >> initializeFor: aPane [
	pane := aPane
]

{ #category : #rendering }
SGLPanePresenter >> renderContentOn: html [
	pane 
		when: GLMMatchingPresentationsChanged 
		send: #actOnMatchingPresentationChanged: 
		to: self.
	self renderPaneOn: html
	

]

{ #category : #rendering }
SGLPanePresenter >> renderPaneOn: html [
	self renderWithTitleOrNil: pane presentations on: html
]

Class {
	#name : #SGLWizardPresenter,
	#superclass : #SGLBrowserPresenter,
	#instVars : [
		'rendered',
		'html',
		'mainId'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #callback }
SGLWizardPresenter >> actOnPaneAdded: ann [

	rendered := rendered + 1.
	self renderer 
		scriptFor: self browser 
		add: "((self  html javascript refresh))"

			((html jQuery id: self mainId) load
         			html: [ :r | 
            		 r render: self ])
]

{ #category : #callback }
SGLWizardPresenter >> actOnPaneRemoved: ann [
	self renderer
		scriptFor: self browser
		add:
			((self renderer html jQuery ajax)
						script: [:s | 
							self renderer updateScript: s
							])
]

{ #category : #callback }
SGLWizardPresenter >> actOnPaneReplaced: ann [
	"self renderer
		scriptFor: self browser
		add:"
			((self renderer html jQuery ajax)
						script: [:s | 
							self renderer updateScript: s
							])
]

{ #category : #accessing }
SGLWizardPresenter >> html [

	^ html
]

{ #category : #accessing }
SGLWizardPresenter >> html: anObject [

	html := anObject
]

{ #category : #accessing }
SGLWizardPresenter >> mainId [

	^ mainId
]

{ #category : #accessing }
SGLWizardPresenter >> mainId: anId [

	mainId := anId
]

{ #category : #accessing }
SGLWizardPresenter >> registerAnnouncementsFor: aBrowser [
	
	aBrowser 
		on: GLMPaneRemoved send: #actOnPaneRemoved: to: self.
	aBrowser 
		on: GLMPaneAdded send: #actOnPaneAdded: to: self.
	aBrowser 
		on: GLMPaneReplaced send: #actOnPaneReplaced: to: self.
	aBrowser 
		on: GLMBrowserClosed send: #actOnBrowserClosed: to: self.
]

{ #category : #rendering }
SGLWizardPresenter >> renderContentOn:  tmpHtml [

	rendered ifNil: [rendered := 0].
	self html:  tmpHtml.
	self registerAnnouncementsFor: self browser.
	"self halt."
	self mainId: html nextId.
	tmpHtml div
		id: self mainId;
		script: html jQuery new glamourStack;
		with: [
			self render: (self browser stepsAndPanes at: self browser currentStep) last on: tmpHtml
			]
	
]

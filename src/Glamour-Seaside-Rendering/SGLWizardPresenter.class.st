Class {
	#name : #SGLWizardPresenter,
	#superclass : #SGLBrowserPresenter,
	#instVars : [
		'mainId'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #callback }
SGLWizardPresenter >> actOnBrowserClosed: ann [

	self renderer component answer
]

{ #category : #callback }
SGLWizardPresenter >> actOnPaneAdded: ann [

	self renderer 
		scriptFor: self browser 
		add:
			(
			(self renderer html jQuery id: self mainId) parent "load"
         			html: [ :r | 
						r div
							id: self mainId;
							script: (r jQuery new glamourWizard);
							with: [
								self render: (self browser stepsAndPanes at: self browser currentStep) last on: r 
								]
							
					]
			).
			
	"self renderer 
		scriptFor: self browser 
		add:
			((self renderer html jQuery id: self mainId) call: 'resize')"
]

{ #category : #callback }
SGLWizardPresenter >> actOnPaneRemoved: ann [

	self renderer 
		scriptFor: self browser 
		add:
			(
			(self renderer html jQuery id: self mainId) parent "load"
         			html: [ :r | 
						r div
							id: self mainId;
							script: (r jQuery new glamourWizard);
							with: [
								self render: (self browser stepsAndPanes at: self browser currentStep) last on: r 
								]
							
					]
			).
]

{ #category : #callback }
SGLWizardPresenter >> actOnPaneReplaced: ann [

	self renderer 
		scriptFor: self browser 
		add:
			(
			(self renderer html jQuery id: self mainId) parent "load"
         			html: [ :r | 
						r div
							id: self mainId;
							script: (r jQuery new glamourWizard);
							with: [
								self render: (self browser stepsAndPanes at: self browser currentStep) last on: r 
								]
							
					]
			).
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
SGLWizardPresenter >> renderContentOn:  html [

	self registerAnnouncementsFor: self browser.
	self mainId: html nextId.
	html div
		id: self mainId;
		script: html jQuery new glamourWizard;
		with: [
			self render: (self browser stepsAndPanes at: self browser currentStep) last on: html
			]
	
]

Class {
	#name : #SGLValidatorPresenter,
	#superclass : #SGLBrowserPresenter,
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #rendering }
SGLValidatorPresenter >> renderContentOn: html [

	html div 
		script: (html jQuery new glamourResize splitHorizontal
				paneASpan: 6;
				remainingSpan: 1 );
		with: [
		self render: self browser panes first on: html.
		html div with: [
			self browser buttonActions do: [:aGLMAction |
				html button 
				script: (html jQuery this css: (
					Dictionary new
						at: 'width' put: '100';
						at: 'float' put: 'right';
						yourself
						)
					);
				onClick:((html jQuery ajax)
					script: [:s | 
						(GLMButtonModel new 
						glamourPresentation: self browser;
						glamourAction: aGLMAction;
						yourself) execute.
						self renderer updateScript: s
						]);
				value: aGLMAction title
				"callback: [
					(GLMButtonModel new 
						glamourPresentation: self browser;
						glamourAction: aGLMAction;
						yourself) execute
					]"
				]
			]
		]
]

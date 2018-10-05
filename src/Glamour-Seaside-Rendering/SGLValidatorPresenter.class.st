Class {
	#name : #SGLValidatorPresenter,
	#superclass : #SGLBrowserPresenter,
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #rendering }
SGLValidatorPresenter >> renderContentOn: html [

	html div 
		script: (html jQuery new glamourValidator buttonsHeight: 50);
		with: [
			html div
				script: (html jQuery new glamourValidatorBrowser);
				with: [
					self render: self browser panes first on: html.
					].
			html div 
				with: [
				self browser buttonActions do: [:aGLMAction |
				
					html button 
						script: (html jQuery new css: (
							Dictionary new 
								at: 'float' put: 'right';
								at: 'margin-top' put: '10px';
								at: 'margin-left' put: '5px';
								at: 'margin-right' put: '5px';
								at: 'padding-top' put: '3px';
								at: 'padding-left' put: '3px';
								at: 'padding-right' put: '3px';
								at: 'padding-bottom' put: '3px';
								yourself
								));
						onClick:((html jQuery ajax)
							script: [:s | 
								(GLMButtonModel new 
									glamourPresentation: self browser;
									glamourAction: aGLMAction;
									yourself) execute.
								self renderer updateScript: s
								]);
							value: aGLMAction title]
				
			].
			
			
		] 
]

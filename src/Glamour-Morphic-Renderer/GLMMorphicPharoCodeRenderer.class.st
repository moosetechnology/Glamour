Class {
	#name : #GLMMorphicPharoCodeRenderer,
	#superclass : #GLMMorphicRubricTextRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #callbacks }
GLMMorphicPharoCodeRenderer >> actOnCompileText: ann [ 
	
	"The current compiler wants to notify a text morph object in case of errors. 
	The compilation is delagated to the renderer, as the renderer has access
	to the text morph object."
	(ann session 
		recompileMethodTo: ann presentation text 
		inContext: ann context 
		notifying: textMorph) ifTrue: [ ann action ifNotNil: [ :action | action value ] ]
]

{ #category : #callbacks }
GLMMorphicPharoCodeRenderer >> actOnEvaluateSelection: ann [ 

	"We get here as a result of an announcement.
	If we do not defer the execution and an exception is triggered by the execution of the code
	then resuming the execution in the debugger will trigger an error when unwinding the stack."
	UIManager default defer: [ 
		textMorph textArea editor evaluateSelectionAndDo: ann action ]
	
]

{ #category : #callbacks }
GLMMorphicPharoCodeRenderer >> debugSelection [

	UIManager default defer: [ 
		textMorph textArea editor debugIt ]
	
]

{ #category : #callbacks }
GLMMorphicPharoCodeRenderer >> evaluateAndPopPrintSelection [

	| popper |
	UIManager default defer: [ 
		popper := RubEditingArea new.
		popper
					on: Character escape do: [ popper delete. textMorph takeKeyboardFocus];
					beWrapped;
					width: World width / 3;
					top: textMorph textArea cursor top + textMorph positionInWorld y;
					left: textMorph textArea cursor right + textMorph positionInWorld x;
					updateTextWith: (textMorph textArea editor evaluateSelectionAndDo: [ :result | result printString ]);
					takeKeyboardFocus;
					backgroundColor: Color paleYellow;
					onAnnouncement: MorphLostFocus do: [ :ann | ann morph delete ];
					openInWorld.
	 ]
	
]

{ #category : #callbacks }
GLMMorphicPharoCodeRenderer >> evaluateAndPrintSelection [

	UIManager default defer: [ 
		textMorph textArea editor printIt ]
	
]

{ #category : #rendering }
GLMMorphicPharoCodeRenderer >> modelFor: aPresentation [

	^ GLMRubricSmalltalkTextModel new
		glamourPresentation: aPresentation;
		highlightSmalltalk: true;
		yourself
]

{ #category : #callbacks }
GLMMorphicPharoCodeRenderer >> profileSelection [

	textMorph textArea editor tallyIt
]

{ #category : #private }
GLMMorphicPharoCodeRenderer >> registerEventsForPresentation: aPresentation [

	super registerEventsForPresentation: aPresentation.
	aPresentation on: GLMSelectCurrentLine send: #selectLine to: self.
	aPresentation on: GLMEvaluateSelection send: #actOnEvaluateSelection: to: self.
	aPresentation on: GLMCompileText send: #actOnCompileText: to: self.
	aPresentation on: GLMDebugSelection send: #debugSelection to: self.
	aPresentation on: GLMProfileSelection send: #profileSelection to: self.
	aPresentation on: GLMPrintSelection send: #evaluateAndPrintSelection to: self
	
]

{ #category : #callbacks }
GLMMorphicPharoCodeRenderer >> selectLine [
	
	textMorph textArea editor lineSelectAndEmptyCheck: [^ nil]
]

Class {
	#name : #GLMExamples,
	#superclass : #Object,
	#category : #'Glamour-Examples'
}

{ #category : #accessing }
GLMExamples class >> browser [
	| browser |
	browser := GLMTabulator new.
	browser title: self title.
	browser column: #titles; column: #example span: 4.
	browser transmit to: #titles; andShow: [:a |
		a list
			title: 'Examples';
			display: [:list | list asSortedCollection: [:x :y | 
				(x argumentAt: 1) < (y argumentAt: 1)] ];
			format: [:each | each argumentAt: 1]].
	browser transmit to: #example; from: #titles; andShow: [:a |
		a dynamic
			title: 'Browser';
			presentation: [ :some :each | 
				some custom: ((self new perform: each selector) startOn: (Compiler evaluate: (each argumentAt: 2) logged: false))].
		a text 
			title: 'Source code';
			act: [:text :pragma | StandardToolSet browse: self selector: pragma selector ] 
				icon: GLMUIThemeExtraIcons glamorousBrowse
				entitled: 'Browse';
			forSmalltalk: self;
			display: [:pragma | self sourceCodeAt: pragma selector]].	
	^ browser
]

{ #category : #accessing }
GLMExamples class >> model [
	^ Pragma allNamed: #glmBrowser:input: in: self.
]

{ #category : #rendering }
GLMExamples class >> open [
	^ self browser openOn: self model
]

{ #category : #accessing }
GLMExamples class >> title [
	^ 'Examples'
]

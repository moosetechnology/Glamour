"
I am a Spec ComposableModel for all Glamour presentations (GLMPresentation subclasses.) By default I open a Playground because its creation contract is special.

For examples see my class side

"
Class {
	#name : #GlamourPresentationModel,
	#superclass : #ComposableModel,
	#instVars : [
		'presentation',
		'glmPres'
	],
	#category : #'Glamour-SpecIntegration'
}

{ #category : #specs }
GlamourPresentationModel class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed add: #presentation
]

{ #category : #example }
GlamourPresentationModel class >> example [
	|ui lay|
	
	ui := DynamicComposableModel new.
	ui title: 'Too Much Glamour!'.
	ui instantiateModels: #(
		play GlamourPresentationModel
		insp GlamourPresentationModel).
	
	ui insp presentationClass: GTInspector startOn: 42.
	
	lay := SpecLayout composed
		newColumn: [ :c |
			c newRow: [ :r | r add: #play];
			newRow: [ :r | r add: #insp ]];
		yourself.
		
	ui openWithSpecLayout: lay.
]

{ #category : #example }
GlamourPresentationModel class >> exampleGLMExamples [
	"open the Glamour Examples Browser"
	|ui|
	ui := GlamourPresentationModel new.
	ui presentationClass: GLMExamplesBrowser startOn: GLMBasicExamples.
	ui openWithSpec
]

{ #category : #example }
GlamourPresentationModel class >> exampleInspectorOn42 [
	"open an inspector on 42"
	|ui|
	ui := GlamourPresentationModel new.
	ui presentationClass: GTInspector startOn: 42.
	ui openWithSpec
]

{ #category : #example }
GlamourPresentationModel class >> exampleMethodsBrowser [
	"open a Methods Browser on Object"
	|ui|
	ui := GlamourPresentationModel new.
 ui presentationClass: GTSimpleMethodsBrowser startOn: Object.
	ui openWithSpec
]

{ #category : #example }
GlamourPresentationModel class >> examplePlayground [
	GlamourPresentationModel new openWithSpec.
]

{ #category : #example }
GlamourPresentationModel class >> examplePlaygroundOn42 [
	"open a playground on 42"
	|ui|
	ui := GlamourPresentationModel new.
	ui presentationClass: GTPlayground startOn: (GTPlayPage new saveContent: '42').
	ui openWithSpec
]

{ #category : #accessing }
GlamourPresentationModel >> glmPres [
	glmPres isNil ifTrue:[glmPres := GTPlayground new startOn:  GTPlayPage new].
	^glmPres 
]

{ #category : #initialization }
GlamourPresentationModel >> initializeWidgets [
	"Should actually do nothing at all.
	This is because we cannot create the morph and later set the presentation.
	So we will do all of this in the presentation: accessor.
	"

]

{ #category : #accessing }
GlamourPresentationModel >> presentation [
	presentation isNil ifTrue:[
		| morph |
		morph := GLMMorphicRenderer new render: self glmPres.
		morph hResizing: #spaceFill.
		morph vResizing: #spaceFill.
		presentation := MorphicGenericAdapter morph: morph].

	^ presentation
]

{ #category : #accessing }
GlamourPresentationModel >> presentation: anObject [
	presentation := anObject
]

{ #category : #api }
GlamourPresentationModel >> presentationClass: aGLMCompositePresentation startOn: anObject [ 
	glmPres := aGLMCompositePresentation new startOn: anObject
]

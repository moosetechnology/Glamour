Class {
	#name : #GLMMorphicMorphRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'scrollPane',
		'containerMorphClass',
		'container'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicMorphRenderer >> actOnKeyStroke: aPresentation event: anEvent from: aMorph [ 
	| action |

	anEvent commandKeyPressed ifFalse: [ ^self ].
	action := (self allKeyboardActionsFor: aPresentation) 
		detect: [ :each | each shortcut = anEvent keyCharacter  ] 
		ifNone: [ nil ].
		
	action 
		ifNotNil: [ action actOn: aPresentation].
]

{ #category : #rendering }
GLMMorphicMorphRenderer >> actOnPresentationUpdated: ann [
	container removeAllMorphs.
	container addMorphBack: (self morphFrom: ann presentation)
]

{ #category : #private }
GLMMorphicMorphRenderer >> allKeyboardActionsFor: aPresentation [ 
	^(aPresentation allActions, 
		aPresentation allSelectionActions) 
		select: [ :action | action hasShortcut ]
]

{ #category : #rendering }
GLMMorphicMorphRenderer >> morphFrom: aMorphPresentation [
	| morph  |
	
	morph := aMorphPresentation morph 
		vResizing: #spaceFill; 
		hResizing: #spaceFill;
		yourself.
	
	(self allKeyboardActionsFor: aMorphPresentation) ifNotEmpty: [
		morph 
			on: #keyStroke 
			send: #actOnKeyStroke:event:from: 
			to: self 
			withValue: aMorphPresentation ].
		
	^morph
]

{ #category : #rendering }
GLMMorphicMorphRenderer >> render: aMorphPresentation [
	| morph zoomableMorph |
	aMorphPresentation when: GLMPresentationUpdated send: #actOnPresentationUpdated: to: self.
	morph := self morphFrom: aMorphPresentation.
	zoomableMorph := morph newTransformationMorph asFlexOf: morph.
	zoomableMorph
		hResizing: #rigid;
		vResizing: #rigid.
	^ self scrollMorphFor: zoomableMorph
]

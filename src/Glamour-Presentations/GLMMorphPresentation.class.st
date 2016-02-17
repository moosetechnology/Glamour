"
This presentation offers a means to embed a Morph. It makes sense only for the Morph Renderer.
"
Class {
	#name : #GLMMorphPresentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'morphBuilder',
		'scrollMorph'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #actions }
GLMMorphPresentation >> fit [
	 self isMorphTaller
			ifTrue:  [ self fitHeight ]
			ifFalse: [ self fitWidth ]
]

{ #category : #actions }
GLMMorphPresentation >> fitHeight [
	 scrollMorph scrollTarget extent: ((scrollMorph scrollTarget width * (scrollMorph height / scrollMorph scrollTarget height))) @ scrollMorph height
]

{ #category : #actions }
GLMMorphPresentation >> fitWidth [
	 scrollMorph scrollTarget extent: (scrollMorph width @ (scrollMorph scrollTarget height * (scrollMorph width / scrollMorph scrollTarget width)))
]

{ #category : #initialization }
GLMMorphPresentation >> initialize [
	super initialize.
	"self initialize: [ :a | self fitWidth ]."
	morphBuilder := [ :thisPresentation :theDisplayValue | theDisplayValue asMorph ].
	actions := {
		GLMGenericAction new
				"icon: GLMUIThemeExtraIcons glamorousClose;"
				shortcut: $=;
				title: '+'.
		GLMGenericAction new
				"icon: GLMUIThemeExtraIcons glamorousClose;"
				shortcut: $-;
				title: '-'.
		GLMGenericAction new
				"icon: GLMUIThemeExtraIcons glamorousClose;"
				shortcut: $d;
				title: 'Fit Width'.
		GLMGenericAction new
				"icon: GLMUIThemeExtraIcons glamorousClose;"
				shortcut: $f;
				title: 'Fit' } asOrderedCollection.
]

{ #category : #actions }
GLMMorphPresentation >> isMorphTaller [
	^ (scrollMorph width / scrollMorph height) > (scrollMorph scrollTarget width / scrollMorph scrollTarget height)
]

{ #category : #rendering }
GLMMorphPresentation >> morph [
	^ morphBuilder glamourValue: 
			(self asGlamorousMultiValue, 
			self displayValue asGlamorousMultiValue)
]

{ #category : #rendering }
GLMMorphPresentation >> morph: aBlock [
	morphBuilder := aBlock
]

{ #category : #rendering }
GLMMorphPresentation >> renderGlamorouslyOn: aRenderer [ 

	self registerAnnouncements.
	scrollMorph := aRenderer renderMorphPresentation: self.
	actions first action: [ self zoomIn ].
	actions second action: [ self zoomOut ].
	actions third action: [ self fitWidth ].
	actions fourth action: [ self fit ].
	^ scrollMorph
]

{ #category : #private }
GLMMorphPresentation >> zoomFactor [
	^ 1.2
]

{ #category : #actions }
GLMMorphPresentation >> zoomIn [
	scrollMorph scrollTarget extent: self zoomFactor * scrollMorph scrollTarget extent
]

{ #category : #actions }
GLMMorphPresentation >> zoomOut [
	scrollMorph scrollTarget extent: 1 / self zoomFactor * scrollMorph scrollTarget extent
]

"
This presentation offers a means to embed a Morph. It makes sense only for the Morph Renderer.
"
Class {
	#name : #GLMMorphPresentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'morphBuilder'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #initialization }
GLMMorphPresentation >> initialize [
	super initialize.
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
	| morph |
	self registerAnnouncements.
	morph := aRenderer renderMorphPresentation: self.
	actions first action: [ morph scrollTarget extent: 1.2 * morph scrollTarget extent ].
	actions second action: [ morph scrollTarget extent: 0.8 * morph scrollTarget extent ].
	actions third action: [ morph scrollTarget extent: (morph width @ (morph scrollTarget height * (morph width / morph scrollTarget width))) ].
	actions fourth action: [ (morph width / morph height) > (morph scrollTarget width / morph scrollTarget height)
			ifTrue:  [ morph scrollTarget extent: ((morph scrollTarget width * (morph height / morph scrollTarget height))) @ morph height ]
			ifFalse: actions third action ].
	^ morph
]

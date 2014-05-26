Class {
	#name : #GLMPagerPanePreviewMorph,
	#superclass : #ImageMorph,
	#instVars : [
		'thumbnail',
		'position'
	],
	#classVars : [
		'preview'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMPagerPanePreviewMorph class >> delete [

	self morph delete.	
	preview := nil.
]

{ #category : #'as yet unclassified' }
GLMPagerPanePreviewMorph class >> for: aMorph [

	self morph for: aMorph.
]

{ #category : #'as yet unclassified' }
GLMPagerPanePreviewMorph class >> hide [
	preview ifNotNil: [ preview delete ].
]

{ #category : #'as yet unclassified' }
GLMPagerPanePreviewMorph class >> morph [
 ^ 	preview ifNil: [ preview := GLMPagerPanePreviewMorph new ].
]

{ #category : #'as yet unclassified' }
GLMPagerPanePreviewMorph class >> showAt: aPoint [
	self morph openInWorld.
	self morph align: aPoint.
	^ self morph.
]

{ #category : #'as yet unclassified' }
GLMPagerPanePreviewMorph >> align: aPoint [
	
	position := aPoint.
]

{ #category : #'as yet unclassified' }
GLMPagerPanePreviewMorph >> defaultBorderWidth [
	^ 5
]

{ #category : #'as yet unclassified' }
GLMPagerPanePreviewMorph >> defaultBottomMargin [
	^ 11
]

{ #category : #'as yet unclassified' }
GLMPagerPanePreviewMorph >> for: aMorph [
	thumbnail := aMorph taskThumbnailOfSize: self maxExtent.
	self image: thumbnail form.
	
	self position: position - ((thumbnail width / 2)@(thumbnail height + self defaultBottomMargin + self defaultBorderWidth)).
]

{ #category : #'as yet unclassified' }
GLMPagerPanePreviewMorph >> initialize [
	super initialize.

	self color: Color transparent.
	
	self theme pagerWidgetThemer previewPaneStyleFor: self.
	self borderWidth: self defaultBorderWidth.
	
	preview := self.
]

{ #category : #'as yet unclassified' }
GLMPagerPanePreviewMorph >> maxExtent [
	^ 300@300.
]

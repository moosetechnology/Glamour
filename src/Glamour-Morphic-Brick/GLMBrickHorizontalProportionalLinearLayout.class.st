"
A GLMBrickHorizontalProportionalLinearLayout is an improvement of standard LinearLayout such that element are positioned proportionaly in the parent based on Brick>>layoutProperties horizontalPercent.

"
Class {
	#name : #GLMBrickHorizontalProportionalLinearLayout,
	#superclass : #GLMBrickHorizontalLinearLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #'as yet unclassified' }
GLMBrickHorizontalProportionalLinearLayout class >> example2 [

	|foundationBrick rootBrick brick1 brick2|
	
	rootBrick := GLMBrick new.
	rootBrick layoutPolicy: self new.
	
	rootBrick layoutProperties paddingLeft: 10.	
	rootBrick layoutProperties paddingTop: 10.
	rootBrick layoutProperties paddingRight: 10.	
	rootBrick layoutProperties paddingBottom: 10.
	rootBrick color: Color blue.
	
	brick1 := GLMBrick new.
	brick1 layoutProperties horizontalPercent: 100.
	brick1 extent: 50@70.
	brick1 color: Color red.
	
	brick2 := GLMBrick new.
	brick2 layoutProperties horizontalPercent: 0.
	brick2 layoutProperties minWidthBlock: [ 50 ].
	brick2 color: Color green.
	brick2 extent: 70@60.
	
	rootBrick
		addBrickBack: brick1;
		addBrickBack: brick2.
		
	foundationBrick := GLMFoundationBrick new.
	foundationBrick brickRoot: rootBrick.
	foundationBrick openInWindow.
	foundationBrick color: Color pink.
		
	

]

{ #category : #layouting }
GLMBrickHorizontalProportionalLinearLayout >> extentOf: aBrick in: owner withArguments: aHashTable [
	| width requestedWidth allowedWidth minWidth maxWidth distributableWidth distributablePercents|
	
	minWidth := self minWidthOf: aBrick.
	maxWidth := self maxWidthOf: aBrick.
	distributableWidth := aHashTable at: #distributableWidth ifAbsent: [ owner brickInnerBounds width ].
	distributablePercents := aHashTable at: #distributablePercents ifAbsent: [ 100 ].
	
	allowedWidth := self widthOf: aBrick allowed: distributableWidth percents: distributablePercents.
	requestedWidth := self widthOf: aBrick allowed: owner brickInnerBounds width percents: 100.
	
	width := (requestedWidth < minWidth ifTrue: [ minWidth ] ifFalse: [ allowedWidth min: maxWidth ]) - aBrick layoutProperties horizontalMargin.
	
	^ width@(self originalHeightOf: aBrick)
]

{ #category : #'set up' }
GLMBrickHorizontalProportionalLinearLayout >> prepareArgumentsFor: aBrick [
	|allowedWidth maxPercent ownerWidth|
	
	ownerWidth := aBrick brickGlobalInnerBounds width.
	allowedWidth := ownerWidth.
	maxPercent := 100.
	
	aBrick subbricks do: [ :each |	|minWidth requestedWidth|
		minWidth := self minWidthOf: each.
		requestedWidth := self widthOf: each allowed: allowedWidth percents: maxPercent.
			
		requestedWidth < minWidth ifTrue: [ 
			allowedWidth := allowedWidth - minWidth.
			maxPercent := maxPercent - each layoutProperties horizontalPercent ] ].

	^ Dictionary new
		add: (#distributableWidth -> allowedWidth);
		add: (#distributablePercents -> maxPercent);
		yourself
]

{ #category : #'extent functions' }
GLMBrickHorizontalProportionalLinearLayout >> widthOf: aBrick allowed: width percents: percents [

	percents <= 0 ifTrue: [ ^ 0 ].
	^ (width * aBrick layoutProperties horizontalPercent / percents) ceiling
]

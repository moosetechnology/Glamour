Class {
	#name : #GLMBrickLayoutTraverser,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Brick-Utils'
}

{ #category : #private }
GLMBrickLayoutTraverser >> customDependencies: aBrick [

	^ self subclassResponsibility
]

{ #category : #private }
GLMBrickLayoutTraverser >> dimensionPolicy: aBrick [

	^ ((self isDependsOnParent: aBrick)
		ifTrue: [
			aBrick owner
				ifNil: [ aBrick ]
				ifNotNil: [ :owner |
					owner isBrick
						ifTrue: [ owner ]
						ifFalse: [ aBrick ] ] ]
		ifFalse: [ aBrick ])
		layoutPolicy
]

{ #category : #private }
GLMBrickLayoutTraverser >> hasCustomDependencies: aBrick [

	^ (self customDependencies: aBrick) isEmpty not
]

{ #category : #private }
GLMBrickLayoutTraverser >> hasDimensionRestrictions: aBrick [

	^ (self hasMinDimensionRestriction: aBrick) | (self hasMaxDimensionRestriction: aBrick)
]

{ #category : #private }
GLMBrickLayoutTraverser >> hasMaxDimensionRestriction: aBrick [

	^ self subclassResponsibility
]

{ #category : #private }
GLMBrickLayoutTraverser >> hasMinDimensionRestriction: aBrick [

	^ self subclassResponsibility
]

{ #category : #private }
GLMBrickLayoutTraverser >> isClean: aBrick [

	^ self subclassResponsibility
]

{ #category : #private }
GLMBrickLayoutTraverser >> isDependsOnChildren: aBrick [

	^ self subclassResponsibility
]

{ #category : #private }
GLMBrickLayoutTraverser >> isDependsOnMyself: aBrick [

	^ self subclassResponsibility
]

{ #category : #private }
GLMBrickLayoutTraverser >> isDependsOnOpposite: aBrick [

	^ self subclassResponsibility
]

{ #category : #private }
GLMBrickLayoutTraverser >> isDependsOnParent: aBrick [

	^ self subclassResponsibility
]

{ #category : #private }
GLMBrickLayoutTraverser >> isLayoutClean: aBrick [

	^ aBrick
		ifNotNil: [ :b | b layout isClean ]
		ifNil: [ true ]
]

{ #category : #private }
GLMBrickLayoutTraverser >> isLayoutDirty: aBrick [

	^ aBrick
		ifNotNil: [ :b | b layout isDirty ]
		ifNil: [ true ]
]

{ #category : #private }
GLMBrickLayoutTraverser >> isOppositeClean: aBrick [

	^ self subclassResponsibility
]

{ #category : #private }
GLMBrickLayoutTraverser >> isOppositeDependsOn: aBrick [

	^ self subclassResponsibility
]

{ #category : #traversing }
GLMBrickLayoutTraverser >> layoutAround: aBrick inContext: aContextBrick [
	"want to layout non-Brick object? nice try, bro."
	aBrick isBrick ifFalse: [ ^ self ].
	"if my dimension is clean why do you want to layout me?"
	(self isClean: aBrick) ifTrue: [ ^ self ].
	aBrick changed.
	"custom dependencies are very dangerous, as it's complicated
	to detect cycles fast"
	(self customDependencies: aBrick)
		do: [ :each | |b|
			[ b :=  each brickValue: aBrick ] on: Exception do: [ b := nil ] .
			b ifNotNil: [ self layoutAround: b inContext: aBrick ] ].
		
	"children and parent dependencies must be before myself,
	because custom dimension can theoretically depend on children or parent"
	(self isDependsOnChildren: aBrick) ifTrue: [
		self layoutChildrenDependency: aBrick ].
	
	(self isDependsOnParent: aBrick) ifTrue: [
		self layoutParentDependency: aBrick ].
	
	(self isDependsOnMyself: aBrick) ifTrue: [
		self layoutMyselftDependency: aBrick ].
	
	(self isDependsOnOpposite: aBrick) ifTrue: [
		self layoutOppositeDependency: aBrick ].
	
	(self isOppositeDependsOn: aBrick) ifTrue: [
		self opposite layoutAround: aBrick inContext: nil ].
	
	"and finally we position them"
	self layoutSubbricks: aBrick.
	self layoutSubbricks: aBrick owner.
	
	aBrick changed.

]

{ #category : #traversing }
GLMBrickLayoutTraverser >> layoutChildrenDependency: aBrick [
	
	"we need to calculate sizes of all subbricks"
	self layoutChildrenOf: aBrick.
	"first we calculate corresponding dimension"
	self updateDimension: aBrick.
	"after everything is done we can mark dimension as clean"
	self markClean: aBrick.
	"because my dimension changed, maybe my owner would like to adapt"
	self layoutOwnerOf: aBrick
]

{ #category : #traversing }
GLMBrickLayoutTraverser >> layoutChildrenOf: aBrick [

	(self prioritySortedSubbricks: aBrick) do: [ :each | self layoutAround: each inContext: aBrick ]
]

{ #category : #traversing }
GLMBrickLayoutTraverser >> layoutMyselftDependency: aBrick [
	
	"immidiately set my dimension"
	self updateDimension: aBrick.
	self markClean: aBrick.
	self layoutChildrenOf: aBrick.
	self layoutOwnerOf: aBrick
]

{ #category : #traversing }
GLMBrickLayoutTraverser >> layoutOppositeDependency: aBrick [

	self opposite layoutAround: aBrick inContext: nil.
	self flag: 'set my size depending from opposite dimension'.
	self markClean: aBrick.
	self layoutChildrenOf: aBrick.
	self layoutOwnerOf: aBrick
]

{ #category : #traversing }
GLMBrickLayoutTraverser >> layoutOwnerOf: aBrick [

	aBrick owner ifNotNil: [ self layoutAround: aBrick owner inContext: aBrick ]
]

{ #category : #traversing }
GLMBrickLayoutTraverser >> layoutParentDependency: aBrick [

	aBrick owner ifNil: [ ^ self markClean: aBrick. "Exception signal: 'Dimension depends on parent, but owner is nil'" ].
	(self isDependsOnChildren: aBrick owner) ifTrue: [ Error signal: 'Circle dependency detected!' ].
	
	"because I depend on my parent, it should be layouted first"
	self layoutOwnerOf: aBrick.
	"then I can update my dimension"
	self updateDimension: aBrick.
	"everething is done I can mark dimension as clean"
	self markClean: aBrick.
	"and I can say my children to layout themselves, because I'm already clean"
	self layoutChildrenOf: aBrick
]

{ #category : #private }
GLMBrickLayoutTraverser >> layoutSubbricks: aBrick [
	aBrick ifNil: [ ^ self ].
	aBrick isBrick ifFalse: [ ^ self ].
	((self isClean: aBrick) & (self isOppositeClean: aBrick))
		ifFalse: [ ^ self ].
	(self isLayoutClean: aBrick) ifTrue: [ ^ self ].
	(aBrick subbricks allSatisfy: [ :each | each isBrick ifTrue: [ (self isClean: each) & (self isOppositeClean: each) ] ifFalse: [ false ] ])
		ifFalse: [ ^ self ].
	
	aBrick invalidateLayout.
	self markLayoutClean: aBrick.
	aBrick onChildrenLayouted
]

{ #category : #private }
GLMBrickLayoutTraverser >> markClean: aBrick [

	^ self subclassResponsibility
]

{ #category : #private }
GLMBrickLayoutTraverser >> markDirty: aBrick [

	^ self subclassResponsibility
]

{ #category : #traversing }
GLMBrickLayoutTraverser >> markDirtyAround: aBrick inContext: aContextBrick [
	aBrick isBrick ifFalse: [ ^ self ].
	aBrick = aContextBrick ifTrue: [ ^ self ].
	
	aBrick owner ifNotNil: [
		(aBrick owner = aContextBrick) not & aBrick owner isBrick ifTrue: [
			(self isClean: aBrick owner) ifTrue: [
				(self isDependsOnChildren: aBrick owner) ifTrue: [
					self markDirty: aBrick owner.
					self markDirtyAround: aBrick owner inContext: aBrick ].
			
				((self isDependsOnMyself: aBrick) | (self isDependsOnChildren: aBrick) | (self isDependsOnOpposite: aBrick))
					ifTrue: [ (aBrick owner subbricks anySatisfy: [ :each | self isDependsOnParent: each]) ifTrue: [
						self markDirty: aBrick owner.
						self markDirtyChildrenAround: aBrick owner inContext: aBrick ] ].
				
				(self isClean: aBrick owner) ifTrue:[ 
					(aBrick floating = #none) not | (aBrick vAlign = #none) not | (aBrick hAlign = #none) not ifTrue: [ 
						self markLayoutDirty: aBrick owner ] ] ] ] ].
	
	aBrick subbricks do: [ :each |
		each = aContextBrick ifFalse: [
			each isBrick ifTrue: [
			((self isDependsOnParent: each) & (self isClean: each))
					| (each floating = #none) not | (each vAlign = #none) not | (each hAlign = #none) not ifTrue: [
				self markDirty: each.
				self markDirtyAround: each inContext: aBrick ] ] ] ].
	
	(self isOppositeDependsOn: aBrick) & (self isOppositeClean: aBrick) ifTrue: [
		self markOppositeDirty: aBrick.
		self opposite markDirtyAround: aBrick inContext: nil ].
	
	self markDirtyCustomDependency: aBrick inContext: aContextBrick.
	aBrick subbricks do: [ :each | self markDirtyCustomDependency: each inContext: aBrick ]
	

]

{ #category : #traversing }
GLMBrickLayoutTraverser >> markDirtyChildrenAround: aBrick inContext: aContextBrick [

	aBrick subbricks do: [ :each |
		each = aContextBrick ifFalse: [
			each isBrick ifTrue: [
			(self isClean: each) ifTrue: [
				self markDirty: each.
				self markDirtyAround: each inContext: aBrick ] ] ] ].
]

{ #category : #traversing }
GLMBrickLayoutTraverser >> markDirtyCustomDependency: aBrick inContext: aContextBrick [
	(aBrick isBrick) not | (aBrick = aContextBrick) ifTrue: [ ^ self ].
	
	(self hasCustomDependencies: aBrick) ifTrue: [
				self markDirty: aBrick.
				aBrick subbricks do: [ :each | each isBrick ifTrue: [
						self markDirty: each.
						self markDirtyAround: each inContext: aBrick ] ].
				
				(self customDependencies: aBrick) do: [ :each | |brick|
					[ brick := each brickValue: aBrick ] on: Exception do: [ brick := nil ].
					brick ifNotNil: [
						(brick = aContextBrick) not & (brick = aBrick) not & brick isBrick ifTrue: [
							(self isClean: brick) ifTrue: [
								self markDirty: brick.
								self markDirtyAround: brick inContext: aBrick ] ] ] ] ]
]

{ #category : #private }
GLMBrickLayoutTraverser >> markLayoutClean: aBrick [

	aBrick ifNotNil: [ :b | b layout markClean ]
]

{ #category : #private }
GLMBrickLayoutTraverser >> markLayoutDirty: aBrick [

	aBrick ifNotNil: [ :b | b isBrick ifTrue: [ b layout markDirty ] ]
]

{ #category : #private }
GLMBrickLayoutTraverser >> markOppositeDirty: aBrick [

	^ self subclassResponsibility
]

{ #category : #accessing }
GLMBrickLayoutTraverser >> opposite [

	^ self subclassResponsibility
]

{ #category : #private }
GLMBrickLayoutTraverser >> prioritySortedSubbricks: aBrick [
	|sorted|
	sorted := OrderedCollection newFrom: aBrick subbricks.
	sorted sort: [ :first :second | (self isDependsOnParent: first) ifFalse: [ true ]
		 ifTrue: [ (self isDependsOnParent: second) ifFalse: [ false ]
			ifTrue: [ (self hasDimensionRestrictions: first) ifFalse: [ false ]
				ifTrue: [ (self hasDimensionRestrictions: second) ifFalse: [ true ]
					ifTrue: [ (self hasMinDimensionRestriction: first) ifFalse: [ false ]
						ifTrue: [ true ] ] ] ] ] ].
	^ sorted
]

{ #category : #private }
GLMBrickLayoutTraverser >> updateDimension: aBrick [

	^ self subclassResponsibility
]

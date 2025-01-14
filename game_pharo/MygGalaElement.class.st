Class {
	#name : #MygGalaElement,
	#superclass : #MygAbstractBox,
	#instVars : [
		'aSkMovable',
		'previousPosition'
	],
	#category : #'game_pharo'
}

{ #category : #initialization }
MygGalaElement class >> configured [ 

	^ self new configured
]

{ #category : #'default encoding' }
MygGalaElement class >> textualMapCharacter [

	^ $Z
]

{ #category : #accessing }
MygGalaElement >> basicPosition: aPosition [
	"A position is a x,y kind of object."
	
	position := aPosition
]

{ #category : #accessing }
MygGalaElement >> bringIn: aSkMovable going: aDirection [
	"By default when a movable wants to move in, we move it in. By default do not use the direction, it is only usd for case where we need to check the next element in that direction, e.g., Player push a Box and the box should check if there is a ground or a wall before moving in that direction."

	| previousPosition |
	previousPosition := aSkMovable position.
	aSkMovable basicPosition: self position.
	self board gameManager ifNotNil: [
		self board gameManager currentMoveCount:
			self board gameManager currentMoveCount + 1 ].
	self board updatePositionOf: aSkMovable from: previousPosition.
	^ true
]

{ #category : #accessing }
MygGalaElement >> configureBoard: aBoard [

	self board: aBoard.
	self board updatePositionOf: aSkMovable from: previousPosition.
	^ true
]

{ #category : #initialization }
MygGalaElement >> configured [ 

	^self
]

{ #category : #testing }
MygGalaElement >> isPlayer [
	^ false
]

{ #category : #testing }
MygGalaElement >> isTarget [
	^ false
]

{ #category : #testing }
MygGalaElement >> moveIn: aNeighbor going: aDirection [
	"To move in a position, we ask the entity where we want to get in to decide.
	This is not a double dispatch per se because we do not have to discrimnate on the receiver."
	
	^ aNeighbor bringIn: self going: aDirection
]

{ #category : #accessing }
MygGalaElement >> printOn: aStream [ 

	super printOn: aStream.
	aStream nextPut: $-.
	position printOn: aStream
]

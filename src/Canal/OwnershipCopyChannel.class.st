Class {
	#name : #OwnershipCopyChannel,
	#superclass : #Channel,
	#category : #Canal
}

{ #category : #sending }
OwnershipCopyChannel >> send: anObject [
	
	| copiedObject |
	copiedObject := anObject deepCopy.
	super send: copiedObject
]

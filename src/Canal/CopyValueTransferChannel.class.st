Class {
	#name : #CopyValueTransferChannel,
	#superclass : #Channel,
	#category : #Canal
}

{ #category : #receiving }
CopyValueTransferChannel >> receive [

	| receivedObject |
	receivedObject := super receive.
	^ receivedObject veryDeepCopy
]

{ #category : #sending }
CopyValueTransferChannel >> send: anObject [
	
	"Hack to delegate the copy in the receive to not have problem with ownership, conceptually I think we should never do this"
	super send: anObject
]

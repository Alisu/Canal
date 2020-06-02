Class {
	#name : #OwnershipTransferPartialReadBarrierChannel,
	#superclass : #Channel,
	#category : #Canal
}

{ #category : #sending }
OwnershipTransferPartialReadBarrierChannel >> send: anObject [ 
	
	| objectToSend |
	objectToSend := Object new.
	anObject become: objectToSend.
	queue nextPut: objectToSend
]

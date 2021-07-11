Class {
	#name : #OwnershipGraphTransferPartialReadBarrierChannel,
	#superclass : #Channel,
	#category : #Canal
}

{ #category : #sending }
OwnershipGraphTransferPartialReadBarrierChannel >> send: anObject [ 
	
	| objectToSend |
	objectToSend := Object new.
	anObject graphBecome: objectToSend.
	queue nextPut: objectToSend
]

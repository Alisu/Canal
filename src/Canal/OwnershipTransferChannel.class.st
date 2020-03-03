Class {
	#name : #OwnershipTransferChannel,
	#superclass : #Channel,
	#category : #Canal
}

{ #category : #sending }
OwnershipTransferChannel >> send: anObject [ 
	
	| objectToSend |
	objectToSend := Object new.
	anObject become: objectToSend.
	queue nextPut: objectToSend
]

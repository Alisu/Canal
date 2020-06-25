Class {
	#name : #OwnershipTransferWriteBarrierChannel,
	#superclass : #Channel,
	#category : #Canal
}

{ #category : #receiving }
OwnershipTransferWriteBarrierChannel >> receive [
	| receivedObject |
	receivedObject := super receive.
	receivedObject ifNotNil:[
	receivedObject beWritableObject.
	receivedObject owner: Processor activeProcess.
	receivedObject beReadOnlyObject].
	^receivedObject 
	
]

{ #category : #sending }
OwnershipTransferWriteBarrierChannel >> send: anObject [ 

	anObject owner: nil.
	queue nextPut: anObject
]

Class {
	#name : #OwnershipTransferWriteBarrierChannel,
	#superclass : #Channel,
	#category : #Canal
}

{ #category : #receiving }
OwnershipTransferWriteBarrierChannel >> receive [
	| receivedObject |
	receivedObject := super receive.
	receivedObject beWritableObject.
	receivedObject owner: Processor activeProcess.
	receivedObject beReadOnlyObject.
	^receivedObject 
	
]

{ #category : #sending }
OwnershipTransferWriteBarrierChannel >> send: anObject [
	Processor activeProcess = anObject owner
		ifTrue: [ anObject owner: nil.
			queue nextPut: anObject ]
		ifFalse: [ self error ]
]

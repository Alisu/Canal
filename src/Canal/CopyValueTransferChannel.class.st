Class {
	#name : #CopyValueTransferChannel,
	#superclass : #Channel,
	#category : #Canal
}

{ #category : #receiving }
CopyValueTransferChannel >> receive [
	| receivedObject |
	receivedObject := super receive.
	receivedObject owner: Processor activeProcess.
	^receivedObject 
]

{ #category : #sending }
CopyValueTransferChannel >> send: anObject [
	
	| copiedObject |
	copiedObject := anObject deepCopy.
	copiedObject owner: nil.
	super send: copiedObject
]

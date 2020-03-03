Class {
	#name : #OwnershipTransferChannelTest,
	#superclass : #ChannelTest,
	#category : #'Canal-Tests'
}

{ #category : #tests }
OwnershipTransferChannelTest >> testOwnership [

| i status |
i:= OwnershipTransferChannel new.
status := Channel new.
[ | object |
	object := Array new: 10.
	i send: object.
	[  object at: 1.
		status send: 'success' ]
			on: Error
			do: [ :e | status send: e freeze ]
] fork.

self assert:  (status receive isKindOf: Error).
]

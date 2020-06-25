Class {
	#name : #ScenarioPartialRead,
	#superclass : #Object,
	#category : #'Canal-Example'
}

{ #category : #'as yet unclassified' }
ScenarioPartialRead >> parserAndVisitorInSameProcess [

| channelForFiles files channelForResult refactorResult |
channelForFiles := OwnershipTransferPartialReadBarrierChannel new.
channelForResult := OwnershipTransferPartialReadBarrierChannel new.

5 timesRepeat: [
	[ |visitor| 
		visitor := PTCVisitor2CCallAdapter new.
		visitor selectorsToAdapt: PTCVisitor2CCallAdapter defaultSelectors.
		[true] whileTrue:[|file| file:= channelForFiles receive.
			file ifNil:[Processor activeProcess terminate].
			file fullName
				=
					'/Users/theo/openSMVM/opensmalltalk-vm-1/extracted/plugins/LocalePlugin/src/unix/sqUnixLocale.c'
				ifFalse: [ 
					visitor aStream: String new writeStream.					
					visitor visit: (TheoCParser2 parse: file contents).
					channelForResult send: visitor aStream contents  ]
			]
		] fork].

files := '/Users/theo/openSMVM/opensmalltalk-vm-1/extracted/plugins/'
		asFileReference allFiles select: [ :f | f fullName last = $c ].

files do: [:f | channelForFiles send: f ].

refactorResult := OrderedCollection new.
[refactorResult size equals: files size - 1] whileFalse: [ |toAdd|
	toAdd:= channelForResult receive.
	toAdd 
		ifNotNil:[refactorResult addLast: toAdd.]
		ifNil:[self error: 'Théo du future, corrige moi.']
	 ].

^refactorResult
]

{ #category : #'as yet unclassified' }
ScenarioPartialRead >> parserAndVisitorInSameProcess2: aNumberOfThreads [
	| channelForFiles files channelForResult refactorResult |
	channelForFiles := OwnershipTransferPartialReadBarrierChannel new.
	channelForResult := OwnershipTransferPartialReadBarrierChannel new.
	aNumberOfThreads
		timesRepeat: [ [ self
				parserAndVisitorThreadIn2: channelForFiles
				Out: channelForResult ] fork ].
	files := '/Users/theo/openSMVM/opensmalltalk-vm-1/extracted/plugins/'
		asFileReference allFiles select: [ :f | f fullName last = $c ].
	files
		do: [ :f | 
			f fullName
				=
					'/Users/theo/openSMVM/opensmalltalk-vm-1/extracted/plugins/LocalePlugin/src/unix/sqUnixLocale.c'
				ifFalse: [ channelForFiles send: f contents ] ].
	refactorResult := OrderedCollection new.
	[ refactorResult size = (files size - 1) ]
		whileFalse: [ | toAdd |
			toAdd := channelForResult receive.
			toAdd
				ifNotNil: [ refactorResult addLast: toAdd ]
				ifNil: [ self error: 'Théo du future, corrige moi.' ] ].
	^ refactorResult
]

{ #category : #'as yet unclassified' }
ScenarioPartialRead >> parserAndVisitorInSameProcess: aNumberOfThreads [
	| channelForFiles files channelForResult refactorResult |
	channelForFiles := OwnershipTransferPartialReadBarrierChannel new.
	channelForResult := OwnershipTransferPartialReadBarrierChannel new.
	aNumberOfThreads
		timesRepeat: [ [ self
				parserAndVisitorThreadIn: channelForFiles
				Out: channelForResult ] fork ].
	files := '/Users/theo/openSMVM/opensmalltalk-vm-1/extracted/plugins/'
		asFileReference allFiles select: [ :f | f fullName last = $c ].
	files do: [ :f | channelForFiles send: f ].
	refactorResult := OrderedCollection new.
	[ refactorResult size = (files size - 1) ]
		whileFalse: [ | toAdd |
			toAdd := channelForResult receive.
			toAdd
				ifNotNil: [ refactorResult addLast: toAdd ]
				ifNil: [ self error: 'Théo du future, corrige moi.' ] ].
	^ refactorResult
]

{ #category : #'as yet unclassified' }
ScenarioPartialRead >> parserAndVisitorInTwoProcess [
	| channelForFiles files channelForResult channelForAST refactorResult |
	channelForFiles := OwnershipTransferPartialReadBarrierChannel new.
	channelForAST := OwnershipTransferPartialReadBarrierChannel new.
	channelForResult := OwnershipTransferPartialReadBarrierChannel new.
	
	5 timesRepeat: [ [ [ true ]
				whileTrue: [ | file |
					file := channelForFiles receive.
					file ifNil: [ Processor activeProcess terminate ].
					file fullName
						=
							'/Users/theo/openSMVM/opensmalltalk-vm-1/extracted/plugins/LocalePlugin/src/unix/sqUnixLocale.c'
						ifFalse:
							[ channelForAST send: (TheoCParser2 parse: file contents) ] ] ]
				fork ].
	
	5 timesRepeat: [ [ | visitor |
			visitor := PTCVisitor2CCallAdapter new.
			visitor selectorsToAdapt: PTCVisitor2CCallAdapter defaultSelectors.
			[ true ]
				whileTrue: [ | ast |
					ast := channelForAST receive.
					ast ifNil: [ Processor activeProcess terminate ].
					visitor aStream: String new writeStream.
					visitor visit: ast.
					channelForResult send: visitor aStream contents ] ] fork ].
	
	files := '/Users/theo/openSMVM/opensmalltalk-vm-1/extracted/plugins/'
		asFileReference allFiles select: [ :f | f fullName last = $c ].
	
	files do: [ :f | channelForFiles send: f ].
	
	refactorResult := OrderedCollection new.
	[refactorResult size equals: files size - 1] whileFalse: [ |toAdd|
		toAdd:= channelForResult receive.
		toAdd 
			ifNotNil:[refactorResult addLast: toAdd.]
			ifNil:[self error: 'Théo du future, corrige moi.']
	 ].

	^refactorResult
]

{ #category : #'as yet unclassified' }
ScenarioPartialRead >> parserAndVisitorInTwoProcess: aNumberOfThreads [
	| channelForFiles files channelForResult channelForAST refactorResult |
	channelForFiles := OwnershipTransferPartialReadBarrierChannel new.
	channelForAST := OwnershipTransferPartialReadBarrierChannel new.
	channelForResult := OwnershipTransferPartialReadBarrierChannel new.
	
	aNumberOfThreads timesRepeat: [ [self parserThreadIn: channelForFiles  Out: channelForAST]
				fork ].
	
	aNumberOfThreads timesRepeat: [ [ self visitorThreadIn: channelForAST  Out:channelForResult  ] fork ].
	
	files := '/Users/theo/openSMVM/opensmalltalk-vm-1/extracted/plugins/'
		asFileReference allFiles select: [ :f | f fullName last = $c ].
	
	files do: [ :f | channelForFiles send: f ].
	
	refactorResult := OrderedCollection new.
	[refactorResult size = (files size - 1)] whileFalse: [ |toAdd|
		toAdd:= channelForResult receive.
		toAdd 
			ifNotNil:[refactorResult addLast: toAdd.]
			ifNil:[self error: 'Théo du future, corrige moi.']
	 ].

	^refactorResult
]

{ #category : #'as yet unclassified' }
ScenarioPartialRead >> parserAndVisitorThreadIn2: aChannelForFiles Out: aChannelForResult [
	| visitor |
	visitor := PTCVisitor2CCallAdapter new.
	visitor selectorsToAdapt: PTCVisitor2CCallAdapter defaultSelectors.
	[ true ]
		whileTrue: [ | fileContent |
			fileContent := aChannelForFiles receive.
			fileContent ifNil: [ Processor activeProcess terminate ].
			visitor visit: (TheoCParser2 parse: fileContent).
			aChannelForResult send: visitor aStream contents ]
]

{ #category : #'as yet unclassified' }
ScenarioPartialRead >> parserAndVisitorThreadIn: aChannelForFiles Out: aChannelForResult [
	| visitor |
	visitor := PTCVisitor2CCallAdapter new.
	visitor selectorsToAdapt: PTCVisitor2CCallAdapter defaultSelectors.
	[ true ]
		whileTrue: [ | file |
			file := aChannelForFiles receive.
			file ifNil: [ Processor activeProcess terminate ].
			file fullName
				=
					'/Users/theo/openSMVM/opensmalltalk-vm-1/extracted/plugins/LocalePlugin/src/unix/sqUnixLocale.c'
				ifFalse: [ visitor aStream: String new writeStream.
					visitor visit: (TheoCParser2 parse: file contents).
					aChannelForResult send: visitor aStream contents ] ]
]

{ #category : #'as yet unclassified' }
ScenarioPartialRead >> parserThreadIn: aChannelForFiles Out: aChannelForAST [
	[ true ]
		whileTrue: [ | file |
			file := aChannelForFiles receive.
			file ifNil: [ Processor activeProcess terminate ].
			file fullName
				=
					'/Users/theo/openSMVM/opensmalltalk-vm-1/extracted/plugins/LocalePlugin/src/unix/sqUnixLocale.c'
				ifFalse: [ aChannelForAST send: (TheoCParser2 parse: file contents) ] ]
]

{ #category : #'as yet unclassified' }
ScenarioPartialRead >> visitorThreadIn: aChannelForAST Out: aChannelForResult [
	| visitor |
	visitor := PTCVisitor2CCallAdapter new.
	visitor selectorsToAdapt: PTCVisitor2CCallAdapter defaultSelectors.
	[ true ]
		whileTrue: [ | ast |
			ast := aChannelForAST receive.
			ast ifNil: [ Processor activeProcess terminate ].
			visitor aStream: String new writeStream.
			visitor visit: ast.
			aChannelForResult send: visitor aStream contents ]
]

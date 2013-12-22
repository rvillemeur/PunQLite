testing
testTransactionsDisableAutoCommit
	"self debug: #testTransactionsDisableAutoCommit"
	| dbName db ok fetched |
	dbName := 'pq-testTransDisableAutoCommit.db'.
	db := PqDatabase open: dbName.
	self assert: db isOpen.
	self assert: db disableAutoCommit.
	
	db beginTransaction.
	ok := db storeAt: 'Smalltalk' value: '???'.
	self assert: ok.
	db commitTransaction.
	
	db beginTransaction.
	ok := db storeAt: 'Smalltalk' value: 'COOL'.
	self assert: ok.
	db close.
	
	db := PqDatabase open: dbName.
	fetched := db fetchStringAt: 'Smalltalk'.
	self assert: (fetched = '???').
	
	db beginTransaction.
	ok := db storeAt: 'Smalltalk' value: 'COOL'.
	self assert: ok.
	db commitTransaction.
	db close.
	
	db := PqDatabase open: dbName.
	fetched := db fetchStringAt: 'Smalltalk'.
	self assert: (fetched = 'COOL').
	
	db close.
	self assert: db isOpen not.
	(FileSystem workingDirectory / dbName) delete.
	
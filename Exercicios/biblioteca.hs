type Person = String
type Book = String
type Database = [(Person, Book)]

books :: Database -> Person -> [Book]
books [] _ = []
books ((p, b) : pbs) per
    -- Se a pessoa for a que procuramos, adicionamos o livro à lista e continuamos procurando por outros livros que essa pessoa possa ter
    | per == p = b : (books pbs per)
    | otherwise = books pbs per

borrowers :: Database -> Book -> Person
borrowers [] _ = []
borrowers ((p, b) : pbs) book
    | book == b = p : (borrowers pbs book)
    | otherwise = borrowers pbs book
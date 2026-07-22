# SwiftyJakoWinkler
It's a similarity measure for strings (between 0 and 1) specifically designed for personal names and short misspellings. It takes into account the number of characters in common, the order of the characters and a significant bonus if the beginnings of the words are identical (this is Winkler's contribution).


## Usage
let jw = JaroWinkler(prefixLength: 4)

print(jw.similarity("DUPONT", "DUPOND"))           // ~0.97
print(jw.similarity("Jean Martin", "Jean Martine")) // ~0.95
print(jw.similarity("café", "cafe"))                // très élevé

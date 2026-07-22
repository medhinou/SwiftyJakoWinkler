# SwiftyJakoWinkler
This is a similarity measure (between 0 and 1) specifically designed for personal names and short misspellings. It takes into account: 
- The number of shared characters
- The order of characters (transpositions)
- A significant bonus if the beginnings of words are identical (this is Winkler's contribution)

Main use: 
- Ideal when comparing short strings where prefixes are important.

## Usage
let jw = JaroWinkler(prefixLength: 4)

print(jw.similarity("DUPONT", "DUPOND"))           // ~0.97

print(jw.similarity("Jean Martin", "Jean Martine")) // ~0.95

print(jw.similarity("café", "cafe"))                // ~0.88

# Swift-String-Similarity, a Swift String Extension

## SwiftyJakoWinkler
This is a similarity measure (between 0 and 1) specifically designed for personal names and short misspellings. It takes into account: 
- The number of shared characters
- The order of characters (transpositions)
- A significant bonus if the beginnings of words are identical (this is Winkler's contribution)

Main use: 
- Ideal when comparing short strings where prefixes are important.


## SwiftyLevenshtein
This is an edit distance. It calculates the minimum number of operations required to transform one string into another: 
- Inserting a character
- Deleting a character
- Substituting (replacing) a character

Main use: 
- To measure how different two strings are.
- Very intuitive: a distance of 0 = identical strings.
- Very versatile.

## SwiftJaccard
It's a similarity measure that combines two ideas: 
- Trigrams: splitting words into groups of 3 consecutive characters.
- Jaccard coefficient: calculating the ratio between common elements and all unique elements.

Example: 
- "dupont" → trigrams: {"dup", "upo", "pon", "ont"}
- "dupond" → trigrams: {"dup", "upo", "pon", "ond"}

Then we calculate:
- Similarity = (common trigrams) / (all unique trigrams) Main use: Measuring the similarity between two strings based on their 3-character sequences.

It's a statistical method, not an edit distance.

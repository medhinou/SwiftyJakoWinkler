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
# Usage
let a = "Jean Dupont"

let b = "Jean Dupond"

print(a.levenshteinSimilarity(to: b))

print(a.jaroWinklerSimilarity(to: b))

print(a.trigramJaccardSimilarity(to: b))

# Use cases
Here are actual use cases where this kind of extension is commonly used:
## Duplicate Detection & Data Cleaning
- Finding duplicate customer records (e.g., "John Smith" vs "Jon Smith")
- Merging databases with inconsistent spelling
- Cleaning imported Excel/CSV data

## Fuzzy Search / "Did You Mean?" Feature
- Search bars that tolerate typos (very common in e-commerce apps)
- Product search, user directory, address lookup

## Record Linkage / Entity Resolution
- Matching the same person across different systems (CRM + ERP + Billing)
- Reconciling supplier names, company names, or product SKUs

## User Experience Improvements
- Autocomplete with typo tolerance
- Smart suggestions when user input doesn't match exactly
- Contact book search with fuzzy matching

## Fraud Detection & Identity Verification
- Detecting similar identities that might indicate fraud
- Comparing names in KYC (Know Your Customer) processes

## Content & Text Processing
- Detecting similar article titles or product descriptions
- Plagiarism checking (light version)
- Grouping similar feedback or reviews

## Business & Enterprise Tools
- CRM systems
- Inventory management software
- HR & payroll systems (matching employee records)
- Pharmacy / medical software (matching drug names)

## Data Migration Projects
- When moving data from legacy systems and needing to match old vs new records


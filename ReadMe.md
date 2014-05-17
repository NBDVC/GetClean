READ ME
=====
You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

Script:
1. Looks for all .txt files
2. Sorts out some none table txt
3. Reads all remaining into a list of data.frames
4. Constructs a combined Training data.frame
5. Constructs a combined Test data.frame
6. Merges the Test and Training data.frames
7. Subsets that dataframe to only mean and std columns
8. Calculates all the columns means by subject and activity
9. writes the summary information to a file Tidy.csv
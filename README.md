# hw1

### Name: 
### Student ID:

## cmd

```R
Rscript hw1_yourID.R -input input1.csv -out output1.csv

Rscript hw1_yourID.R -out output1.csv -input input1.csv
```

Your R code should output and round the set name with maximum value for each column.

## Read in an input file

examples = input1.csv

## Output a summary file

(please follow the same format of the result.csv, i.e., round number into two digitals)

example =  output1.csv

## Score

10 testing data

```R
Rscripthw1/code/hw1_000.R -input hw1/data/test.1.csv -out hw1/eval/test1/hw1_000
Rscripthw1/code/hw1_000.R -out hw1/eval/test2/hw1_000 -input hw1/data/test.2.csv
```
Correct answer gets 9 points of each testing data.

## Bonus

- Output format without “: 3 points
- Set format without file path: 3 points
- Set format without .csv: 4 points

## Penalty: -2 points of each problem

- Arguments order cannot change
- File path cannot change
- Wrong set name
- Wrong column name
- Not round number to 2 digitals
- …

## Note

- Please do not set working directory(setwd) in a fixed folder.
- Please do not set input/output in your local path or URL.
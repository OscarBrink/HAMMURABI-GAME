SRC = CALCULATE-HARVEST.cbl CALCULATE-PLAGUE.cbl CALCULATE-RATS.cbl GENERATE-RANDOM-SEED.cbl LAND-TRANSACTION.cbl

all:
	cobc -x -o out/prog MAIN.cbl $(SRC)


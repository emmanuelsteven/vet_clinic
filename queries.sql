/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
 SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT *  FROM animals WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';                          

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg = 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon.
 SELECT * FROM animals WHERE name = 'Gabumon';

--  Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;                          

-- Inside a transaction update the animals table by setting the species column to unspecified. 
-- Verify that change was made. Then roll back the change and verify that the species columns 
-- went back to the state before the transaction.
vet_clinic=# BEGIN;
BEGIN
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
vet_clinic=*# ROLLBACK;
ROLLBACK
SELECT * FROM animals ORDER BY id ASC;

-- In a new transaction 
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
BEGIN;
BEGIN
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE 6
vet_clinic=*# UPDATE animals SET species = 'pokomon' WHERE species IS Null;
UPDATE 5
SELECT * FROM animals ORDER BY id ASC;
COMMIT;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
-- After the rollback verify if all records in the animals table still exists.
BEGIN;
BEGIN
DELETE FROM  animals;
DELETE 11
SELECT * FROM animals ORDER BY id ASC;
ROLLBACK;
ROLLBACK
SELECT * FROM animals ORDER BY id ASC;

-- Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction
BEGIN;
BEGIN
DELETE  FROM animals WHERE date_of_birth >  date '2022-01-02'; 
DELETE 1
SAVEPOINT vet_savepoint;
SAVEPOINT
UPDATE animals SET weight_kg  = weight_kg * '-1';
UPDATE 10
SELECT * FROM animals ORDER BY id ASC;
ROLLBACK TO  vet_savepoint;
ROLLBACK
SELECT * FROM animals ORDER BY id ASC;
UPDATE animals SET weight_kg  = weight_kg * '-1' WHERE weight_kg < 0;
UPDATE 4
SELECT * FROM animals ORDER BY id ASC;
COMMIT;
COMMIT

-- Write queries to answer the following questions:

-- How many animals are there?
SELECT COUNT(*) AS  no_of_animals FROM animals;
 no_of_animals 

-- How many animals have never tried to escape?
SELECT COUNT(*)  FROM animals WHERE escape_attempts = 0;
count 

-- What is the average weight of animals?
SELECT AVG(weight_kg)  FROM animals;
avg  

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) AS total_escape_attempts FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those 
-- born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;


SELECT animals.*, full_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.*, species.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';


SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;


SELECT species.name, COUNT(*) AS animal_count
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

SELECT animals.*,owners.full_name, species.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.*, owners.full_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.*) AS animal_count
FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC;
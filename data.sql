/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)  
VALUES ('Agumon', date '2020-02-03', '0', true, '10.23');

 INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)  
VALUES ('Gabumon', date '2018-11-15', '2', true, '8');

 INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)  
VALUES ('Pikachu', date '2021-01-07', '1', false, '15.04');

 INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)  
VALUES ('Devimon', date '2017-05-12', '5', true, '11');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Charmander', '2022-02-08', 0, false, -11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Plantmon', '2021-11-15', 2, true, -5.7);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Squirtle', '1993-04-02', 3, false, -12.13);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Angemon', '2005-06-12', 1, true, -45);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Boarmon', '2005-06-07', 7, true, 20.4);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Blossom', '1998-10-13', 3, true, 17);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Ditto', '2022-05-14', 4, true, 22);

INSERT INTO owners (full_name, age)  
VALUES ('Sam Smith', '34');

INSERT INTO owners (full_name, age)  
VALUES ('Jennifer Orwell', '19');

INSERT INTO owners (full_name, age)  
VALUES ('Bob', '45');

INSERT INTO owners (full_name, age)  
VALUES ('Melody Pond', '77');

INSERT INTO owners (full_name, age)  
VALUES ('Dean Winchester', '14');

INSERT INTO owners (full_name, age)  
VALUES ('Jodie Whittaker', '38');

INSERT INTO species (name)  
VALUES ('Pokemon');

INSERT INTO species (name)  
VALUES ('Digimon');

UPDATE animals SET species_id = 1  WHERE name LIKE '%mon' AND species_id is NULL;

UPDATE animals SET species_id = 2  WHERE name NOT LIKE '%mon' AND species_id is NULL;

UPDATE animals
SET owner_id = owners.id
FROM owners WHERE animals.name = 'Agumon' AND owners.full_name = 'Sam Smith';

UPDATE animals
SET owner_id = owners.id
FROM owners WHERE (animals.name = 'Gabumon' OR animals.name = 'Pikachu')  AND owners.full_name = 'Jennifer Orwell';

UPDATE animals
SET owner_id = owners.id
FROM owners WHERE (animals.name = 'Devimon' OR animals.name = 'Plantmon')  AND owners.full_name = 'Bob';

UPDATE animals
SET owner_id = owners.id
FROM owners WHERE (animals.name = 'Charmander' OR animals.name = 'Squirtle' OR animals.name = 'Blossom')  AND owners.full_name = 'Melody Pond';

UPDATE animals
SET owner_id = owners.id
FROM owners WHERE (animals.name = 'Angemon' OR animals.name = 'Boarmon')  AND owners.full_name = 'Dean Winchester';


INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
       ('Maisy Smith', 26, '2019-01-17'),
       ('Stephanie Mendez', 64, '1981-05-04'),
       ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id)
VALUES (1, 2),
       (3, 1),
       (3, 2),
       (4, 1);

INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES
  -- Agumon
  (1, 1, '2020-05-24'),
  (3, 1, '2020-07-22'),
  -- Gabumon
  (4, 2, '2021-02-02'),
  -- Pikachu
  (2, 3, '2020-01-05'),
  (2, 3, '2020-03-08'),
  (2, 3, '2020-05-14'),
  -- Devimon
  (3, 4, '2021-05-04'),
  -- Charmander
  (4, 5, '2021-02-24'),
  -- Plantmon
  (1, 6, '2019-12-21'),
  (1, 6, '2020-08-10'),
  (2, 6, '2021-04-07'),
  -- Squirtle
  (3, 7, '2019-09-29'),
  -- Angemon
  (4, 8, '2020-10-03'),
  (4, 8, '2020-11-04'),
  -- Boarmon
  (2, 9, '2019-01-24'),
  (2, 9, '2019-05-15'),
  (2, 9, '2020-02-27'),
  (2, 9, '2020-08-03'),
  -- Blossom
  (1, 10, '2020-05-24'),
  (1, 10, '2021-01-11');


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
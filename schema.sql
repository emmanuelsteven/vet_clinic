/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id BIGSERIAL NOT NULL PRIMARY KEY ,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT  NOT NULL,
    neutered BOOL ,
    weight_kg DECIMAL(10, 2) NOT NULL 
  );
  
  -- Adding new table header
ALTER TABLE animals
ADD COLUMN species VARCHAR(100);

--  Create a table named owners
CREATE TABLE owners(
id BIGSERIAL NOT NULL PRIMARY KEY ,
full_name VARCHAR (100) NOT NULL,
age INT NOT NULL
);



--  Create a table named species
CREATE TABLE species (
id BIGSERIAL NOT NULL PRIMARY KEY ,
name VARCHAR (100) NOT NULL
 );

 ALTER TABLE animals DROP COLUMN species;


-- Create a table named vets with the following columns:
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
ADD COLUMN species_id INT, ADD CONSTRAINT sp_animals_species FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE

-- Add column owners_id which is a foreign key referencing species table
ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners(id);
ALTER TABLE

CREATE TABLE specializations (
    vet_id INT,
    species_id INT, 
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (species_id) REFERENCES species(id)
);

-- Create visits table

CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    visit_date DATE,
    PRIMARY KEY (animal_id, vet_id, visit_date),
    FOREIGN KEY (animal_id) REFERENCES animals (id),
    FOREIGN KEY (vet_id) REFERENCES vets (id)
);
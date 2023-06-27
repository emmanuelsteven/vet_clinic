/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id BIGSERIAL NOT NULL PRIMARY KEY ,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT  NOT NULL,
    neutered BOOL ,
    weight_kg DECIMAL(10, 2) NOT NULL 
  );
  
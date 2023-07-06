CREATE TABLE patients(
    id SERIAL PRIMARY KEY,
    name VARCHAR (255),
    date_of_birth DATE,
);

CREATE TABLE treatments(
    id SERIAL PRIMARY KEY,
    type VARCHAR (255),
    name VARCHAR (255),
);

CREATE TABLE medical_histories(
    id SERIAL PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR (255),
    CONSTRAINT fk_patient_id FOREIGN KEY(patient_id) REFERENCES patients(id)
);

CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    total_amount DECIMAL(10,2),
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT,
    CONSTRAINT fk_medical_id FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id),
);

CREATE TABLE invoice_items (
    id SERIAL PRIMARY KEY,
    unit_price DECIMAL(10,2),
    quantity INT,
    total_price DECIMAL(10,2),
    invoice_id INT,
    treatment_id INT,
    CONSTRAINT fk_invoice_id FOREIGN KEY(invoice_id) REFERENCES invoices(id),
    CONSTRAINT fk_treatment_id FOREIGN KEY(treatment_id) REFERENCES treatments(id),
);

CREATE TABLE medical_histories_treatments (
    medical_histories_id INT,
    treatments_id INT,
    PRIMARY KEY(medical_histories, treatment_id),
    CONSTRAINT fk_medical_histories_id FOREIGN KEY(medical_histories_id) REFERENCES medical_histories(id),
    CONSTRAINT fk_treatment_id FOREIGN KEY(treatments_id) REFERENCES treatments(id),
);

-- create index on medical_history table
CREATE INDEX idx_patient_id ON medical_histories(patient_id);

-- create index on invoice table
CREATE INDEX idx_medical_history ON invoices(medical_history_id);

-- create index on invoice_items table
    -- create index on invoice column
    CREATE INDEX idx_invoice_id ON invoice_items(invoice_id);

    -- create index on treatment column
    CREATE INDEX idx_treatment_id ON invoice_items(treatment_id);

-- create index on medical_histories_treatments
    -- create index on medical_histories_id
    CREATE INDEX idx_medical_histories_treatments ON medical_histories_treatments(medical_histories_id);

    -- create index on treatments_id
    CREATE INDEX idx_treatments_id ON medical_histories_treatments(treatments_id);
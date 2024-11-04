
-- Table for storing movie information
CREATE TABLE IF NOT EXISTS Film (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT,
    category VARCHAR(100),
    director_name VARCHAR(255)
);

-- Table for storing customer information
CREATE TABLE IF NOT EXISTS Client (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email_address VARCHAR(255) UNIQUE NOT NULL,
    contact_number TEXT
);

-- Table for tracking rentals
CREATE TABLE IF NOT EXISTS RentalLog (
    id SERIAL PRIMARY KEY,
    client_id INT REFERENCES Client(id),
    film_id INT REFERENCES Film(id),
    date_rented DATE NOT NULL,
    date_due DATE
);

-- Insert movie entries
INSERT INTO Film (title, release_year, category, director_name) VALUES
('Interstellar', 2014, 'Science Fiction', 'Christopher Nolan'),
('Pulp Fiction', 1994, 'Crime', 'Quentin Tarantino'),
('The Shawshank Redemption', 1994, 'Drama', 'Frank Darabont'),
('The Dark Knight', 2008, 'Action', 'Christopher Nolan'),
('Forrest Gump', 1994, 'Drama', 'Robert Zemeckis');

-- Insert customer entries
INSERT INTO Client (first_name, last_name, email_address, contact_number) VALUES
('Michael', 'Scott', 'm.scott@example.com', '111-222-3333'),
('Pam', 'Beesly', 'pam@example.com', '222-333-4444'),
('Jim', 'Halpert', 'jim@example.com', '333-444-5555'),
('Dwight', 'Schrute', 'dwight@example.com', '444-555-6666'),
('Ryan', 'Howard', 'ryan@example.com', '555-666-7777');

-- Insert rental entries
INSERT INTO RentalLog (client_id, film_id, date_rented, date_due) VALUES
(1, 1, '2024-02-01', '2024-02-08'),
(2, 2, '2024-02-02', NULL), -- currently rented
(3, 3, '2024-02-03', '2024-02-10'),
(4, 4, '2024-02-04', NULL), -- currently rented
(5, 5, '2024-02-05', '2024-02-12');

-- Insert customer entries
INSERT INTO Client (first_name, last_name, email_address, contact_number) VALUES
('John', 'Doe', 'johndoe@example.com', '1234567890'),
('Jane', 'Smith', 'janesmith@example.com', '0987654321'),
('Alice', 'Johnson', 'alicejohnson@example.com', '5551234567'),
('Bob', 'Williams', 'bobwilliams@example.com', '4449876543'),
('Emily', 'Brown', 'emilybrown@example.com', '3331112222');

-- Insert rental entries
INSERT INTO RentalLog (client_id, film_id, date_rented, date_due) VALUES
(1, 1, '2024-01-05', '2024-01-12'),
(1, 2, '2024-01-10', '2024-01-17'),
(2, 3, '2024-02-05', '2024-02-12'),
(3, 1, '2024-02-10', '2024-02-17'),
(4, 4, '2024-03-05', '2024-03-12'),
(5, 2, '2024-03-10', '2024-03-17'),
(3, 5, '2024-04-05', '2024-04-12'),
(2, 4, '2024-04-10', '2024-04-17'),
(1, 5, '2024-05-05', '2024-05-12'),
(4, 3, '2024-05-10', '2024-05-17');

-- Query 1: Find all movies rented by a specific customer (given their email)
SELECT F.title 
FROM RentalLog R 
JOIN Client C ON R.client_id = C.id 
JOIN Film F ON R.film_id = F.id 
WHERE C.email_address = 'johndoe@example.com';

-- Query 2: Given a movie title, list all customers who have rented the movie
SELECT C.first_name, C.last_name, C.email_address 
FROM RentalLog R 
JOIN Client C ON R.client_id = C.id 
JOIN Film F ON R.film_id = F.id 
WHERE F.title = 'Interstellar';

-- Query 3: Get the rental history for a specific movie title
SELECT C.first_name, C.last_name, R.date_rented, R.date_due 
FROM RentalLog R 
JOIN Client C ON R.client_id = C.id 
JOIN Film F ON R.film_id = F.id 
WHERE F.title = 'Interstellar';

-- Query 4: For a specific director, find customer name, rental date, and movie title each time a movie by that director was rented
SELECT C.first_name, C.last_name, R.date_rented, F.title 
FROM RentalLog R 
JOIN Client C ON R.client_id = C.id 
JOIN Film F ON R.film_id = F.id 
WHERE F.director_name = 'Christopher Nolan';

-- Query 5: List all currently rented movies (movies whose return dates haven't been met)
SELECT F.title, C.first_name, C.last_name, R.date_rented 
FROM RentalLog R 
JOIN Client C ON R.client_id = C.id 
JOIN Film F ON R.film_id = F.id 
WHERE R.date_due > CURRENT_DATE;

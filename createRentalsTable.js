
const { Pool } = require("pg");
const connectionPool = new Pool();

// Function to create the Rentals table
async function createRentalsTable() {
  const rentalsTableQuery = `
    CREATE TABLE IF NOT EXISTS RentalRecords (
      rental_id SERIAL PRIMARY KEY,
      customer_id INTEGER REFERENCES CustomersDirectory(customer_id) ON DELETE CASCADE,
      movie_id INTEGER REFERENCES MoviesCollection(movie_id) ON DELETE CASCADE,
      date_rented DATE NOT NULL DEFAULT CURRENT_DATE,
      due_back DATE CHECK (due_back > date_rented)
    );
  `;
  await connectionPool.query(rentalsTableQuery);
  console.log("RentalRecords table created or verified.");
}

module.exports = { createRentalsTable };

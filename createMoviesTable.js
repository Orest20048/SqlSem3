
const { Pool } = require("pg");
const connectionPool = new Pool();

// Function to create the Movies table
async function createMoviesTable() {
  const movieTableQuery = `
    CREATE TABLE IF NOT EXISTS MoviesCollection (
      movie_id SERIAL PRIMARY KEY,
      movie_title VARCHAR(255) NOT NULL,
      genre VARCHAR(100) DEFAULT 'Unknown',
      release_year INTEGER CHECK (release_year > 1800),
      director VARCHAR(255) NOT NULL
    );
  `;
  await connectionPool.query(movieTableQuery);
  console.log("MoviesCollection table created or verified.");
}

module.exports = { createMoviesTable };

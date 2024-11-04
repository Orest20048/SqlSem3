
const { createMoviesTable } = require('./createMoviesTable');
const { createCustomersTable } = require('./createCustomersTable');
const { createRentalsTable } = require('./createRentalsTable');

// Function to initialize all tables by calling each table creation function
async function setupDatabase() {
  await createMoviesTable();
  await createCustomersTable();
  await createRentalsTable();
  console.log("Database setup complete. All tables initialized.");
}

module.exports = { setupDatabase };

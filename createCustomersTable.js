
const { Pool } = require("pg");
const connectionPool = new Pool();

// Function to create the Customers table
async function createCustomersTable() {
  const customerTableQuery = `
    CREATE TABLE IF NOT EXISTS CustomersDirectory (
      customer_id SERIAL PRIMARY KEY,
      first_name VARCHAR(100) NOT NULL,
      last_name VARCHAR(100) NOT NULL,
      email VARCHAR(255) UNIQUE NOT NULL CHECK (email LIKE '%@%.%'),
      phone TEXT DEFAULT 'Not Provided'
    );
  `;
  await connectionPool.query(customerTableQuery);
  console.log("CustomersDirectory table created or verified.");
}

module.exports = { createCustomersTable };

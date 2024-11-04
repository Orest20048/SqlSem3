
const { Pool } = require("pg");
const connectionPool = new Pool();

// Function to close the database connection
function closeDatabaseConnection() {
  connectionPool.end();
  console.log("Database connection closed.");
}

module.exports = { closeDatabaseConnection };


const { Pool } = require("pg");
const pool = new Pool();
const { setupDatabase } = require("./setupDatabase");

async function printAllMovies() {
    const res = await pool.query("SELECT * FROM MoviesCollection;");
    console.log("Movies in system:", res.rows);
}

async function updateCustomerEmail(id, newEmail) {
    await pool.query("UPDATE CustomersDirectory SET email = $1 WHERE customer_id = $2", [newEmail, id]);
    console.log(`Updated customer ${id}'s email to ${newEmail}.`);
}

async function addNewMovie(title, genre, releaseYear, director) {
    const query = "INSERT INTO MoviesCollection (movie_title, genre, release_year, director) VALUES ($1, $2, $3, $4) RETURNING *";
    const values = [title, genre, releaseYear, director];
    const res = await pool.query(query, values);
    console.log("Added new movie:", res.rows[0]);
}

async function removeCustomer(id) {
    await pool.query("DELETE FROM CustomersDirectory WHERE customer_id = $1", [id]);
    console.log(`Removed customer ${id} and their rental history.`);
}

const args = process.argv.slice(2);
(async () => {
    if (args[0] === "setup") {
        await setupDatabase();
    } else if (args[0] === "show-movies") {
        await printAllMovies();
    } else if (args[0] === "update-email") {
        const id = parseInt(args[1], 10);
        const newEmail = args[2];
        await updateCustomerEmail(id, newEmail);
    } else if (args[0] === "add-movie") {
        const [title, genre, releaseYear, director] = args.slice(1);
        await addNewMovie(title, genre, parseInt(releaseYear, 10), director);
    } else if (args[0] === "remove-customer") {
        const id = parseInt(args[1], 10);
        await removeCustomer(id);
    } else {
        console.log("Unknown command. Use one of: setup, show-movies, update-email, add-movie, remove-customer.");
    }
    pool.end();
})();

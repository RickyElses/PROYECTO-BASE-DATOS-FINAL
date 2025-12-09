// db.js
const sql = require("mssql");
require("dotenv").config();

const config = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    server: process.env.DB_SERVER,
    database: process.env.DB_NAME,
    port: Number(process.env.DB_PORT),
    options: {
        encrypt: false,
        trustServerCertificate: true
    }
};

let pool;

async function getPool() {
    try {
        if (!pool) {
            console.log("Conectando a SQL Server...");
            pool = await sql.connect(config);
            console.log("🔥 Conexión exitosa a SQL Server");
        }
        return pool;
    } catch (error) {
        console.error("❌ Error conectando a SQL Server:", error);
        throw error;
    }
}

module.exports = { getPool };

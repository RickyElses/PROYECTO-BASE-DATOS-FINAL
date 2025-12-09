require("dotenv").config();
const sql = require("mssql");

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

async function getConnection() {
    try {
        const pool = await sql.connect(config);
        console.log("✅ Conectado a SQL Server correctamente.");
        return pool;
    } catch (error) {
        console.error("❌ ERROR DE CONEXIÓN:", error);
        throw error;
    }
}

module.exports = { sql, getConnection };

const express = require("express");
const cors = require("cors");
const { getPool } = require("./db");

const app = express();
const PORT = 4000;

app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.json({ message: "API GameHouse funcionando" });
});

// EMPLEADOS
app.get("/api/empleados", async (req, res) => {
  try {
    const pool = await getPool();
    const result = await pool.query("SELECT * FROM Empleado");
    res.json(result.recordset);
  } catch (error) {
    console.error("Error en /api/empleados:", error);
    res.status(500).json({ error: "Error obteniendo empleados" });
  }
});

// CLIENTES
app.get("/api/clientes", async (req, res) => {
  try {
    const pool = await getPool();
    const result = await pool.query("SELECT * FROM Clientes");
    res.json(result.recordset);
  } catch (error) {
    console.error("Error en /api/clientes:", error);
    res.status(500).json({ error: "Error obteniendo clientes" });
  }
});

// PRODUCTOS
app.get("/api/productos", async (req, res) => {
  try {
    const pool = await getPool();
    const result = await pool.query("SELECT * FROM Productos");
    res.json(result.recordset);
  } catch (error) {
    console.error("Error en /api/productos:", error);
    res.status(500).json({ error: "Error obteniendo productos" });
  }
});

// COMPRAS
app.get("/api/compras", async (req, res) => {
  try {
    const pool = await getPool();
    const result = await pool.query("SELECT * FROM Compras");
    res.json(result.recordset);
  } catch (error) {
    console.error("Error en /api/compras:", error);
    res.status(500).json({ error: "Error obteniendo compras" });
  }
});

// VENTAS
app.get("/api/ventas", async (req, res) => {
  try {
    const pool = await getPool();
    const result = await pool.query("SELECT * FROM Ventas");
    res.json(result.recordset);
  } catch (error) {
    console.error("Error en /api/ventas:", error);
    res.status(500).json({ error: "Error obteniendo ventas" });
  }
});

app.listen(PORT, () => {
  console.log(`🚀 API GameHouse escuchando en http://localhost:${PORT}`);
});

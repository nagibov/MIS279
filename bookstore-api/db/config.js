import sql from "mssql";
import dotenv from "dotenv";

// Load environment variables
dotenv.config();

const dbConfig = {
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  server: process.env.DB_SERVER,
  database: "ClassDemo", // Bookstore database
  options: {
    encrypt: true,
    trustServerCertificate: true
  },
  pool: {
    max: 10,
    min: 0,
    idleTimeoutMillis: 30000
  }
};

let pool;

export const connectDB = async () => {
  try {
    pool = await sql.connect(dbConfig);
    console.log("✅ Connected to ClassDemo database successfully");
    return pool;
  } catch (error) {
    console.error("❌ Database connection failed:", error.message);
    throw error;
  }
};

export const getPool = () => {
  if (!pool) {
    throw new Error("Database not connected. Call connectDB() first.");
  }
  return pool;
};

export { sql };
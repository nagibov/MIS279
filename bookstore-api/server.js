import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import { connectDB } from "./db/config.js";

// Import routes
import booksRoutes from "./routes/books.js";
import customersRoutes from "./routes/customers.js";
import ordersRoutes from "./routes/orders.js";
import authorsRoutes from "./routes/authors.js";

// Load environment variables
dotenv.config();

const app = express();
const PORT = process.env.PORT || 4000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Request logging middleware
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.url}`);
  next();
});

// Health check endpoint
app.get("/", (req, res) => {
  res.json({
    message: "📚 Bookstore API is running!",
    version: "1.0.0",
    endpoints: {
      books: "/books",
      customers: "/customers",
      orders: "/orders",
      authors: "/authors",
    },
    timestamp: new Date().toISOString(),
  });
});

// API Routes
app.use("/books", booksRoutes);
app.use("/customers", customersRoutes);
app.use("/orders", ordersRoutes);
app.use("/authors", authorsRoutes);

// 404 handler
app.use("*", (req, res) => {
  res.status(404).json({
    error: "Endpoint not found",
    message: `The endpoint ${req.method} ${req.originalUrl} does not exist`,
    availableEndpoints: [
      "GET /",
      "GET /books",
      "POST /books",
      "GET /books/:id",
      "PUT /books/:id",
      "DELETE /books/:id",
      "GET /customers",
      "GET /customers/:id",
      "GET /customers/:id/orders",
      "GET /orders",
      "GET /orders/stats",
      "GET /orders/:id",
      "GET /authors",
      "GET /authors/:id",
    ],
  });
});

// Global error handler
app.use((error, req, res, next) => {
  console.error("Global error handler:", error);
  res.status(500).json({
    error: "Internal server error",
    message: process.env.NODE_ENV === "development" ? error.message : "Something went wrong",
  });
});

// Start server
const startServer = async () => {
  try {
    // Connect to database first
    await connectDB();
    
    // Start the server
    app.listen(PORT, () => {
      console.log(`🚀 Bookstore API server running on http://localhost:${PORT}`);
      console.log(`📖 API Documentation available at http://localhost:${PORT}`);
      console.log(`🔍 Test endpoints:`);
      console.log(`   GET  http://localhost:${PORT}/books`);
      console.log(`   GET  http://localhost:${PORT}/customers`);
      console.log(`   GET  http://localhost:${PORT}/orders`);
      console.log(`   GET  http://localhost:${PORT}/authors`);
    });
  } catch (error) {
    console.error("❌ Failed to start server:", error.message);
    process.exit(1);
  }
};

// Handle graceful shutdown
process.on("SIGINT", () => {
  console.log("\n🛑 Received SIGINT. Shutting down gracefully...");
  process.exit(0);
});

process.on("SIGTERM", () => {
  console.log("\n🛑 Received SIGTERM. Shutting down gracefully...");
  process.exit(0);
});

// Start the server
startServer();
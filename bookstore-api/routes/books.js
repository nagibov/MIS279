import express from "express";
import {
  listBooks,
  getBook,
  createBook,
  updateBook,
  deleteBook,
} from "../controllers/books.js";

const router = express.Router();

// GET /books - List all books with pagination
router.get("/", listBooks);

// GET /books/:id - Get a specific book
router.get("/:id", getBook);

// POST /books - Create a new book
router.post("/", createBook);

// PUT /books/:id - Update a book
router.put("/:id", updateBook);

// DELETE /books/:id - Delete a book
router.delete("/:id", deleteBook);

export default router;
import express from "express";
import {
  listAuthors,
  getAuthor,
} from "../controllers/authors.js";

const router = express.Router();

// GET /authors - List all authors with pagination
router.get("/", listAuthors);

// GET /authors/:id - Get a specific author with their books
router.get("/:id", getAuthor);

export default router;
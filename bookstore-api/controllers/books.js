import { getPool, sql } from "../db/config.js";
import Joi from "joi";

// Validation schema for creating a book
const createBookSchema = Joi.object({
  title: Joi.string().min(2).max(255).required(),
  isbn: Joi.string().min(10).max(20).required(),
  genre: Joi.string().max(100).optional(),
  price: Joi.number().min(0).required(),
  stock: Joi.number().integer().min(0).optional().default(0),
  description: Joi.string().max(1000).optional(),
  publishDate: Joi.date().optional()
});

// GET /books - List all books with their authors
export const listBooks = async (req, res) => {
  try {
    const pool = getPool();
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;

    const result = await pool.request()
      .input("limit", sql.Int, limit)
      .input("offset", sql.Int, offset)
      .query(`
        SELECT 
          b.BookID, 
          b.Title, 
          b.ISBN,
          b.Genre,
          b.Price, 
          b.Stock,
          b.PublishDate,
          b.Description,
          a.FirstName + ' ' + a.LastName AS Author,
          ab.isMain
        FROM Books b
        LEFT JOIN Author_Book ab ON b.BookID = ab.BookId
        LEFT JOIN Authors a ON ab.AuthorId = a.AuthorID
        ORDER BY b.BookID DESC
        OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY
      `);

    // Group books by BookID to handle multiple authors
    const booksMap = new Map();
    
    result.recordset.forEach(row => {
      if (!booksMap.has(row.BookID)) {
        booksMap.set(row.BookID, {
          BookID: row.BookID,
          Title: row.Title,
          ISBN: row.ISBN,
          Genre: row.Genre,
          Price: row.Price,
          Stock: row.Stock,
          PublishDate: row.PublishDate,
          Description: row.Description,
          Authors: []
        });
      }
      
      if (row.Author) {
        booksMap.get(row.BookID).Authors.push({
          Name: row.Author,
          IsMain: row.isMain
        });
      }
    });

    const books = Array.from(booksMap.values());

    res.status(200).json({
      page,
      limit,
      total: books.length,
      books
    });
  } catch (error) {
    console.error("Error fetching books:", error);
    res.status(500).json({ error: "Failed to fetch books" });
  }
};

// GET /books/:id - Get a specific book
export const getBook = async (req, res) => {
  try {
    const pool = getPool();
    const bookId = parseInt(req.params.id);

    const result = await pool.request()
      .input("bookId", sql.Int, bookId)
      .query(`
        SELECT 
          b.BookID, 
          b.Title, 
          b.ISBN,
          b.Genre,
          b.Price, 
          b.Stock,
          b.PublishDate,
          b.Description,
          a.FirstName + ' ' + a.LastName AS Author,
          ab.isMain
        FROM Books b
        LEFT JOIN Author_Book ab ON b.BookID = ab.BookId
        LEFT JOIN Authors a ON ab.AuthorId = a.AuthorID
        WHERE b.BookID = @bookId
      `);

    if (result.recordset.length === 0) {
      return res.status(404).json({ error: "Book not found" });
    }

    // Build book object with authors
    const firstRow = result.recordset[0];
    const book = {
      BookID: firstRow.BookID,
      Title: firstRow.Title,
      ISBN: firstRow.ISBN,
      Genre: firstRow.Genre,
      Price: firstRow.Price,
      Stock: firstRow.Stock,
      PublishDate: firstRow.PublishDate,
      Description: firstRow.Description,
      Authors: result.recordset.filter(row => row.Author).map(row => ({
        Name: row.Author,
        IsMain: row.isMain
      }))
    };

    res.status(200).json(book);
  } catch (error) {
    console.error("Error fetching book:", error);
    res.status(500).json({ error: "Failed to fetch book" });
  }
};

// POST /books - Create a new book
export const createBook = async (req, res) => {
  try {
    // Validate request body
    const { error, value } = createBookSchema.validate(req.body);
    if (error) {
      return res.status(400).json({ error: error.details[0].message });
    }

    const pool = getPool();
    const { title, isbn, genre, price, stock, description, publishDate } = value;

    // Check if ISBN already exists
    const existingBook = await pool.request()
      .input("isbn", sql.NVarChar, isbn)
      .query("SELECT BookID FROM Books WHERE ISBN = @isbn");

    if (existingBook.recordset.length > 0) {
      return res.status(409).json({ error: "Book with this ISBN already exists" });
    }

    const result = await pool.request()
      .input("title", sql.NVarChar, title)
      .input("isbn", sql.NVarChar, isbn)
      .input("genre", sql.NVarChar, genre)
      .input("price", sql.Decimal(10, 2), price)
      .input("stock", sql.Int, stock)
      .input("description", sql.NVarChar, description)
      .input("publishDate", sql.Date, publishDate)
      .query(`
        INSERT INTO Books (Title, ISBN, Genre, Price, Stock, Description, PublishDate)
        OUTPUT INSERTED.BookID
        VALUES (@title, @isbn, @genre, @price, @stock, @description, @publishDate)
      `);

    const newBookId = result.recordset[0].BookID;

    res.status(201).json({
      message: "Book created successfully",
      BookID: newBookId
    });
  } catch (error) {
    console.error("Error creating book:", error);
    res.status(500).json({ error: "Failed to create book" });
  }
};

// PUT /books/:id - Update a book
export const updateBook = async (req, res) => {
  try {
    const bookId = parseInt(req.params.id);
    const { title, price, stock, genre, description } = req.body;

    const pool = getPool();

    const result = await pool.request()
      .input("bookId", sql.Int, bookId)
      .input("title", sql.NVarChar, title)
      .input("price", sql.Decimal(10, 2), price)
      .input("stock", sql.Int, stock)
      .input("genre", sql.NVarChar, genre)
      .input("description", sql.NVarChar, description)
      .query(`
        UPDATE Books 
        SET Title = @title, Price = @price, Stock = @stock, 
            Genre = @genre, Description = @description
        WHERE BookID = @bookId
      `);

    if (result.rowsAffected[0] === 0) {
      return res.status(404).json({ error: "Book not found" });
    }

    res.status(200).json({ message: "Book updated successfully" });
  } catch (error) {
    console.error("Error updating book:", error);
    res.status(500).json({ error: "Failed to update book" });
  }
};

// DELETE /books/:id - Delete a book
export const deleteBook = async (req, res) => {
  try {
    const bookId = parseInt(req.params.id);
    const pool = getPool();

    const result = await pool.request()
      .input("bookId", sql.Int, bookId)
      .query("DELETE FROM Books WHERE BookID = @bookId");

    if (result.rowsAffected[0] === 0) {
      return res.status(404).json({ error: "Book not found" });
    }

    res.status(200).json({ message: "Book deleted successfully" });
  } catch (error) {
    console.error("Error deleting book:", error);
    res.status(500).json({ error: "Failed to delete book" });
  }
};
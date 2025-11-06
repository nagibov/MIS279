import { getPool, sql } from "../db/config.js";

// GET /authors - List all authors
export const listAuthors = async (req, res) => {
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
          a.AuthorID,
          a.FirstName,
          a.LastName,
          a.Bio,
          a.BirthDate,
          a.Nationality,
          COUNT(ab.BookId) as BookCount
        FROM Authors a
        LEFT JOIN Author_Book ab ON a.AuthorID = ab.AuthorId
        GROUP BY a.AuthorID, a.FirstName, a.LastName, a.Bio, a.BirthDate, a.Nationality
        ORDER BY a.LastName, a.FirstName
        OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY
      `);

    res.status(200).json({
      page,
      limit,
      authors: result.recordset
    });
  } catch (error) {
    console.error("Error fetching authors:", error);
    res.status(500).json({ error: "Failed to fetch authors" });
  }
};

// GET /authors/:id - Get a specific author with their books
export const getAuthor = async (req, res) => {
  try {
    const pool = getPool();
    const authorId = parseInt(req.params.id);

    // Get author details
    const authorResult = await pool.request()
      .input("authorId", sql.Int, authorId)
      .query(`
        SELECT 
          AuthorID,
          FirstName,
          LastName,
          Bio,
          BirthDate,
          Nationality,
          CreatedAt
        FROM Authors
        WHERE AuthorID = @authorId
      `);

    if (authorResult.recordset.length === 0) {
      return res.status(404).json({ error: "Author not found" });
    }

    // Get author's books
    const booksResult = await pool.request()
      .input("authorId", sql.Int, authorId)
      .query(`
        SELECT 
          b.BookID,
          b.Title,
          b.ISBN,
          b.Genre,
          b.Price,
          b.PublishDate,
          ab.isMain
        FROM Books b
        JOIN Author_Book ab ON b.BookID = ab.BookId
        WHERE ab.AuthorId = @authorId
        ORDER BY b.PublishDate DESC
      `);

    const author = {
      ...authorResult.recordset[0],
      Books: booksResult.recordset
    };

    res.status(200).json(author);
  } catch (error) {
    console.error("Error fetching author:", error);
    res.status(500).json({ error: "Failed to fetch author" });
  }
};
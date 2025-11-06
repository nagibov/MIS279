import { getPool, sql } from "../db/config.js";

// GET /orders - List all orders
export const listOrders = async (req, res) => {
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
          o.OrderID,
          o.OrderDate,
          o.TotalAmount,
          o.Status,
          c.FirstName + ' ' + c.LastName AS CustomerName,
          c.Email,
          COUNT(ob.BookID) as BookCount
        FROM Orders o
        JOIN Customers c ON o.CustomerID = c.CustomerID
        LEFT JOIN OrderBooks ob ON o.OrderID = ob.OrderID
        GROUP BY o.OrderID, o.OrderDate, o.TotalAmount, o.Status, 
                 c.FirstName, c.LastName, c.Email
        ORDER BY o.OrderDate DESC
        OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY
      `);

    res.status(200).json({
      page,
      limit,
      orders: result.recordset
    });
  } catch (error) {
    console.error("Error fetching orders:", error);
    res.status(500).json({ error: "Failed to fetch orders" });
  }
};

// GET /orders/:id - Get a specific order with details
export const getOrder = async (req, res) => {
  try {
    const pool = getPool();
    const orderId = parseInt(req.params.id);

    // Get order header
    const orderResult = await pool.request()
      .input("orderId", sql.Int, orderId)
      .query(`
        SELECT 
          o.OrderID,
          o.OrderDate,
          o.TotalAmount,
          o.Status,
          c.FirstName + ' ' + c.LastName AS CustomerName,
          c.Email,
          c.Phone,
          c.Address,
          c.City,
          c.Country
        FROM Orders o
        JOIN Customers c ON o.CustomerID = c.CustomerID
        WHERE o.OrderID = @orderId
      `);

    if (orderResult.recordset.length === 0) {
      return res.status(404).json({ error: "Order not found" });
    }

    // Get order items
    const itemsResult = await pool.request()
      .input("orderId", sql.Int, orderId)
      .query(`
        SELECT 
          ob.Quantity,
          ob.UnitPrice,
          b.Title,
          b.ISBN,
          b.Genre,
          a.FirstName + ' ' + a.LastName AS Author
        FROM OrderBooks ob
        JOIN Books b ON ob.BookID = b.BookID
        LEFT JOIN Author_Book ab ON b.BookID = ab.BookId AND ab.isMain = 1
        LEFT JOIN Authors a ON ab.AuthorId = a.AuthorID
        WHERE ob.OrderID = @orderId
      `);

    const order = {
      ...orderResult.recordset[0],
      Items: itemsResult.recordset
    };

    res.status(200).json(order);
  } catch (error) {
    console.error("Error fetching order:", error);
    res.status(500).json({ error: "Failed to fetch order" });
  }
};

// GET /orders/stats - Get order statistics
export const getOrderStats = async (req, res) => {
  try {
    const pool = getPool();

    const result = await pool.request().query(`
      SELECT 
        COUNT(*) as TotalOrders,
        SUM(TotalAmount) as TotalRevenue,
        AVG(TotalAmount) as AverageOrderValue,
        COUNT(CASE WHEN Status = 'Pending' THEN 1 END) as PendingOrders,
        COUNT(CASE WHEN Status = 'Completed' THEN 1 END) as CompletedOrders
      FROM Orders
    `);

    res.status(200).json(result.recordset[0]);
  } catch (error) {
    console.error("Error fetching order stats:", error);
    res.status(500).json({ error: "Failed to fetch order statistics" });
  }
};
import { getPool, sql } from "../db/config.js";

// GET /customers - List all customers
export const listCustomers = async (req, res) => {
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
          CustomerID,
          FirstName,
          LastName,
          Email,
          Phone,
          Address,
          City,
          Country,
          CreatedAt
        FROM Customers
        ORDER BY CustomerID DESC
        OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY
      `);

    res.status(200).json({
      page,
      limit,
      customers: result.recordset
    });
  } catch (error) {
    console.error("Error fetching customers:", error);
    res.status(500).json({ error: "Failed to fetch customers" });
  }
};

// GET /customers/:id - Get a specific customer
export const getCustomer = async (req, res) => {
  try {
    const pool = getPool();
    const customerId = parseInt(req.params.id);

    const result = await pool.request()
      .input("customerId", sql.Int, customerId)
      .query(`
        SELECT 
          CustomerID,
          FirstName,
          LastName,
          Email,
          Phone,
          Address,
          City,
          Country,
          CreatedAt
        FROM Customers
        WHERE CustomerID = @customerId
      `);

    if (result.recordset.length === 0) {
      return res.status(404).json({ error: "Customer not found" });
    }

    res.status(200).json(result.recordset[0]);
  } catch (error) {
    console.error("Error fetching customer:", error);
    res.status(500).json({ error: "Failed to fetch customer" });
  }
};

// GET /customers/:id/orders - Get customer's orders
export const getCustomerOrders = async (req, res) => {
  try {
    const pool = getPool();
    const customerId = parseInt(req.params.id);

    const result = await pool.request()
      .input("customerId", sql.Int, customerId)
      .query(`
        SELECT 
          o.OrderID,
          o.OrderDate,
          o.TotalAmount,
          o.Status,
          COUNT(ob.BookID) as BookCount
        FROM Orders o
        LEFT JOIN OrderBooks ob ON o.OrderID = ob.OrderID
        WHERE o.CustomerID = @customerId
        GROUP BY o.OrderID, o.OrderDate, o.TotalAmount, o.Status
        ORDER BY o.OrderDate DESC
      `);

    res.status(200).json({
      customerId,
      orders: result.recordset
    });
  } catch (error) {
    console.error("Error fetching customer orders:", error);
    res.status(500).json({ error: "Failed to fetch customer orders" });
  }
};
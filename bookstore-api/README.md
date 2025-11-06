# Bookstore API - MIS 276 Hands-On Exercises

A complete Node.js Express API server for the MIS 276 course, designed to work with the ClassDemo database schema.

## 🚀 Quick Start

### 1. Install Dependencies
```bash
cd bookstore-api
npm install
```

### 2. Setup Environment Variables
Copy the example environment file and update with your database credentials:
```bash
copy .env.example .env
```

Edit `.env` file with your actual database credentials:
```
DB_SERVER=localhost
DB_USER=your_username
DB_PASS=your_password
DB_NAME=ClassDemo
PORT=4000
```

### 3. Start the Server
```bash
# Development mode (with auto-reload)
npm run dev

# Production mode
npm start
```

The server will start at `http://localhost:4000`

## 📚 API Endpoints

### Books
- `GET /books` - List all books with authors (paginated)
- `GET /books/:id` - Get a specific book with authors
- `POST /books` - Create a new book
- `PUT /books/:id` - Update a book
- `DELETE /books/:id` - Delete a book

### Customers
- `GET /customers` - List all customers (paginated)
- `GET /customers/:id` - Get a specific customer
- `GET /customers/:id/orders` - Get customer's orders

### Orders
- `GET /orders` - List all orders with customer info (paginated)
- `GET /orders/:id` - Get order details with items
- `GET /orders/stats` - Get order statistics

### Authors
- `GET /authors` - List all authors with book count (paginated)
- `GET /authors/:id` - Get author details with their books

## 🧪 Testing with Postman

### Sample Requests:

1. **List Books:**
   ```
   GET http://localhost:4000/books
   ```

2. **Create a Book:**
   ```
   POST http://localhost:4000/books
   Content-Type: application/json
   
   {
     "title": "The Great Gatsby",
     "isbn": "9780743273565",
     "genre": "Classic Fiction",
     "price": 13.99,
     "stock": 25,
     "description": "A classic American novel",
     "publishDate": "1925-04-10"
   }
   ```

3. **Get Customer Orders:**
   ```
   GET http://localhost:4000/customers/1/orders
   ```

4. **Order Statistics:**
   ```
   GET http://localhost:4000/orders/stats
   ```

## 🗄️ Database Schema

This API works with the ClassDemo database containing:
- **Books** - Book catalog with titles, ISBNs, prices, stock
- **Authors** - Author information and biographies  
- **Author_Book** - Many-to-many relationship between books and authors
- **Customers** - Customer profiles and contact information
- **Orders** - Customer orders with dates and totals
- **OrderBooks** - Order line items linking orders to books
- **Payments** - Payment records for orders

## 🛠️ Features

- ✅ **Full CRUD operations** for books
- ✅ **Complex JOIN queries** showing relationships
- ✅ **Pagination support** for large datasets
- ✅ **Input validation** with Joi
- ✅ **Error handling** with proper HTTP status codes
- ✅ **CORS enabled** for frontend integration
- ✅ **Request logging** for debugging
- ✅ **Health check endpoint** at root URL
- ✅ **Graceful shutdown** handling

## 🔧 Development Tips

1. **Check Database Connection:**
   The server will connect to ClassDemo database on startup and show connection status.

2. **View Logs:**
   All requests are logged to console with timestamps.

3. **API Documentation:**
   Visit `http://localhost:4000` for available endpoints.

4. **Error Handling:**
   The API returns proper HTTP status codes and error messages.

## 📝 Hands-On Exercise Ideas

1. **Basic API Testing:**
   - Test all GET endpoints with Postman
   - Create a new book and verify it appears in the list
   - Export your Postman collection

2. **Advanced Queries:**
   - Find books by a specific author
   - Get the most expensive books
   - Find customers with the most orders

3. **Frontend Integration:**
   - Create a simple HTML page that fetches and displays books
   - Add a form to create new books

4. **Data Analysis:**
   - Use the order stats endpoint to analyze sales
   - Find the best-selling books
   - Identify top customers

## 🆘 Troubleshooting

- **Database Connection Issues:** Check your .env file credentials
- **Port Already in Use:** Change PORT in .env file
- **Missing Dependencies:** Run `npm install`
- **CORS Errors:** The API has CORS enabled by default
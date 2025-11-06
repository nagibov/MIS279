import express from "express";
import {
  listCustomers,
  getCustomer,
  getCustomerOrders,
} from "../controllers/customers.js";

const router = express.Router();

// GET /customers - List all customers with pagination
router.get("/", listCustomers);

// GET /customers/:id - Get a specific customer
router.get("/:id", getCustomer);

// GET /customers/:id/orders - Get customer's orders
router.get("/:id/orders", getCustomerOrders);

export default router;
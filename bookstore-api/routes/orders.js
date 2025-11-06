import express from "express";
import {
  listOrders,
  getOrder,
  getOrderStats,
} from "../controllers/orders.js";

const router = express.Router();

// GET /orders - List all orders with pagination
router.get("/", listOrders);

// GET /orders/stats - Get order statistics
router.get("/stats", getOrderStats);

// GET /orders/:id - Get a specific order with details
router.get("/:id", getOrder);

export default router;
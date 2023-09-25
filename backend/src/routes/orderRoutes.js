const express = require('express');
const orderRoutes = express.Router();
const orderController = require("../controllers/orderController");


orderRoutes.post("/",orderController.createOrder);
orderRoutes.put("/updateStatus",orderController.updateOrderStatus);
orderRoutes.get("/:userId",orderController.fetchOrdersForUser);

module.exports = orderRoutes;
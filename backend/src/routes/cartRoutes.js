const express = require('express');
const cartRoutes = express.Router();
const cartController = require("../controllers/cartController");

cartRoutes.get("/:user",cartController.getCartForUser);
cartRoutes.post("/",cartController.addToCart);
cartRoutes.delete("/",cartController.removeFromCart);
module.exports = cartRoutes;
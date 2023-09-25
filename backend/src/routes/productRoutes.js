const express = require('express');
const productRoutes = express.Router();
const ProductController = require("../controllers/productController")

productRoutes.post("/",ProductController.createProduct);
productRoutes.get("/",ProductController.fetchAllProduct);
productRoutes.get("/category/:id",ProductController.fetchProductByCategoryId);

module.exports = productRoutes;
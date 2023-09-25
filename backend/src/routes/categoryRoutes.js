const express = require('express');
const categoryRouter = express.Router();
const categoryController = require("../controllers/cateegoryController")

categoryRouter.post("/",categoryController.createCategory);
categoryRouter.get("/",categoryController.fetchAllCategory);
categoryRouter.get("/:id",categoryController.fetchCategoryById);

module.exports = categoryRouter;
const express = require('express');
const userRouter = express.Router();
const userController = require("../controllers/userController")

userRouter.post("/createAccount",userController.createAccount);
userRouter.post("/signInAccount",userController.signInAccount);
userRouter.put("/:id",userController.updateUser);

module.exports = userRouter;
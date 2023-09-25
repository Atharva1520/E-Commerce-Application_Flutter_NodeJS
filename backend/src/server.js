const express = require("express");
const bodyparser = require("body-parser");
const helmet = require("helmet");
const morgan = require("morgan");
const cors = require("cors");
const mongoose = require("mongoose");
const app = express();
app.use(bodyparser.json());
app.use(bodyparser.urlencoded({ extended: false }));
app.use(helmet());
app.use(morgan('dev'));
app.use(cors());

mongoose.connect("", {
  useNewUrlParser: true,
  useUnifiedTopology: true
}, (error) => {
  if (error) {
    console.error("Database connection failed:", error);
  } else {
    console.log("Database connected successfully");
    startServer();
  }
});

function startServer() {
  const UserRoutes = require("./routes/userRouter");
  app.use("/api/user", UserRoutes);
  const CategoryRoutes = require('./routes/categoryRoutes');
  app.use("/api/category", CategoryRoutes);
  const productRoutes = require('./routes/productRoutes');
  app.use("/api/product", productRoutes);
  const cartRoutes = require('./routes/cartRoutes');
  app.use("/api/cart", cartRoutes);
  const orderRoutes = require('./routes/orderRoutes');
  app.use("/api/order", orderRoutes);
  app.listen(5000, () => console.log("Server is running"));
}

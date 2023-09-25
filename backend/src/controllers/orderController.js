const orderModel = require("../models/orderModel");
const cartModel = require("../models/cartModel");
const razorpay = require("../services/razorpay");

const orderController = {

    createOrder: async function(req, res) {
        try {
            const { user, items, status, totalAmount } = req.body;

            // Create Order in RazorPay
            const razorPayOrder = await razorpay.orders.create({
                amount: totalAmount * 100,
                currency: "INR",
            });

            const newOrder = new orderModel({
                user: user,
                items: items,
                status: status,
                totalAmount: totalAmount,
                razorPayOrderId: razorPayOrder.id
            });
            await newOrder.save();

            // Update the cart
            await cartModel.findOneAndUpdate(
                { user: user._id },
                { items: [] }
            );

            return res.json({ success: true, data: newOrder, message: "Order created!" });
        }
        catch(ex) {
            return res.json({ success: false, message: ex });
        }
    },
    fetchOrdersForUser: async function(req, res) {
        try {
            const userId = req.params.userId;
            const foundOrders = await orderModel.find({
                "user._id": userId
            }).sort({ createdOn: -1 });
            return res.json({ success: true, data: foundOrders });
        }
        catch(ex) {
            return res.json({ success: false, message: ex });
        }
    },
    updateOrderStatus: async function(req, res) {
        try {
            const { orderId, status, razorPayPaymentId, razorPaySignature } = req.body;
            const updatedOrder = await orderModel.findOneAndUpdate(
                { _id: orderId },
                {
                    status: status,
                    razorPayPaymentId: razorPayPaymentId,
                    razorPaySignature: razorPaySignature
                },
                { new: true }
            );
            return res.json({ success: true, data: updatedOrder });
        }
        catch(ex) {
            return res.json({ success: false, message: ex });
        }
    }

}

module.exports =orderController;
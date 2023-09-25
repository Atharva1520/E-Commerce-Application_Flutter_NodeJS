const cartModel = require("../models/cartModel");

const cartController = {

    getCartForUser: async function(req, res) {
        try {
            const user = req.params.user;
            const foundCart = await cartModel.findOne({ user: user }).populate("items.product");

            if(!foundCart) {
                return res.json({ success: true, data: [] });
            }

            return res.json({ success: true, data: foundCart.items });
        }
        catch(ex) {
            return res.json({ success: false, message: ex });
        }
    },

    addToCart: async function(req, res) {
        try {
            const { product, user, quantity } = req.body;
            const foundCart = await cartModel.findOne({ user: user });

            // If cart does not exist
            if(!foundCart) {
                const newCart = new cartModel({ user: user });
                newCart.items.push({
                    product: product,
                    quantity: quantity
                });

                await newCart.save();
                return res.json({ success: true, data: newCart, message: "Product added to cart" });
            }

            // Deleting the item if it already exists
            const deletedItem = await cartModel.findOneAndUpdate(
                { user: user, "items.product": product },
                { $pull: { items: { product: product } } },
                { new: true }
            );

            // If cart already exists
            const updatedCart = await cartModel.findOneAndUpdate(
                { user: user },
                { $push: { items: { product: product, quantity: quantity } } },
                { new: true }
            ).populate("items.product");
            return res.json({ success: true, data: updatedCart.items, message: "Product added to cart" });
        }
        catch(ex) {
            return res.json({ success: false, message: ex });
        }
    },

    removeFromCart: async function(req, res) {
        try {
            const { user, product } = req.body;
            const updatedCart = await cartModel.findOneAndUpdate(
                { user: user },
                { $pull: { items: { product: product } } },
                { new: true }
            ).populate("items.product");

            return res.json({ success: true, data: updatedCart.items, message: "Product removed from cart" });
        }
        catch(ex) {
            return res.json({ success: false, message: ex });
        }
    }

}

module.exports =cartController;
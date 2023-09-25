const categoryModel = require("../models/categoryModel");
const productModel = require("../models/productModel");

const ProductController =  {

    createProduct : async function(req,res) {
        try {
            const productData = req.body;
            const newProduct = new productModel(productData);
            await newProduct.save();

            return res.json({success: true,data:newProduct,msg: "Product Created!"});
        } catch (error) {
            return res.json({success:false , msg:error});
        }
    },

    fetchAllProduct: async function(req,res){
        try {
            const products = await productModel.find();
            return res.json({success: true,data: products});
        } catch (error) {
            return res.json({success:false,msg:error});
        }
    },


    fetchProductByCategoryId: async function(req,res){
        try {
            const id = req.params.id;
            const foundProduct = await productModel.find({category : id});
           
            return res.json({success: true,data: foundProduct});
        } catch (error) {
            return res.json({success:false,msg:error});
        }
    }
}

module.exports = ProductController;
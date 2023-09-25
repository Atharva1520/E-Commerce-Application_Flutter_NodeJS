const categoryModel = require("../models/categoryModel");

const categoryController = {

    createCategory: async function(req,res){
        try {
            const categoryData = req.body;
            const newCategory = new categoryModel(categoryData);
            await newCategory.save();

            return res.json({success: true,data: newCategory , msg:"Category Created!"});
        } catch (error) {
            return res.json({success:false,msg:error});
        }
    },

    fetchAllCategory: async function(req,res){
        try {
            const categories = await categoryModel.find();
            return res.json({success: true,data: categories});
        } catch (error) {
            return res.json({success:false,msg:error});
        }
    },

    fetchCategoryById: async function(req,res){
        try {
            const id = req.params.id;
            const foundCategory = await categoryModel.findById(id);
            if(!foundCategory){
                return res.json({success:false,msg:"Category not Found!"})
            }
            return res.json({success: true,data: foundCategory});
        } catch (error) {
            return res.json({success:false,msg:error});
        }
    }
}

module.exports = categoryController;
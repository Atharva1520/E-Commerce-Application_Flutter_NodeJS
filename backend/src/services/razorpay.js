const razorpay = require("razorpay");

const instance = new razorpay({
    key_id : "rzp_test_GLmlLgXl6MDJuO",
    key_secret : "KQCj7ONMNLMwtE3dqTacwfUl"
    
});

module.exports = instance;
const express = require("express");
const app = express();
const mysql = require("mysql2");
const cors = require("cors");
const bcrypt = require('bcrypt');

app.use(cors());
app.use(express.json());


// connecting Database
const connectiondb = mysql.createPool({
    host: "localhost",
    user: "root",
    password: "",
    database: "ecom",
});

// users
app.get('/users', (req, res) => {
    connectiondb.query("SELECT * FROM users", (err, result) => {
        if (err) {
            console.log(err);
        } else {
            res.send(result);
        }
    });
});

// cart con
app.get('/cart_item', (req, res) => {
    connectiondb.query("SELECT COUNT(*) AS cart_item FROM cart", (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).send("Error occurred");
        } else {
            res.send(result);
        }
    });
});

app.get('/order_item', (req, res) => {
    connectiondb.query("SELECT COUNT(*) AS order_item FROM `order`", (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).send("Error occurred");
        } else {
            res.send(result);
        }
    });
});



// users:id
app.get('/users/:id', function (req, res, next) {
    const id = req.params.id;
    connectiondb.query(
        'SELECT * FROM `users` WHERE `user_id` = ?',
        [id],
        function (err, results) {
            res.json(results);
        }
    );
});

// register user
app.post('/register', function (req, res, next) {
    console.log(req.body); // พิมพ์ข้อมูลที่ส่งไปยังเซิร์ฟเวอร์ MySQL
    bcrypt.hash(req.body.password, 10, (err, hashedPassword) => {
        if (err) {
            console.log(err);
            res.status(500).send('Internal Server Error');
            return;
        }
        connectiondb.query(
            'INSERT INTO users(firstname, lastname, username, email, phone, password) VALUES (?, ?, ?, ?, ?, ?)',
            [req.body.firstname, req.body.lastname, req.body.username, req.body.email, req.body.phone, hashedPassword],
            (err) => {
                if (err) {
                    console.log(err);
                    res.status(400).send('Bad Request');
                } else {
                    res.status(200).send('User registration successful');
                }
            });
    });
});


// Route to handle login
app.post('/login', (req, res) => {
    const { username, password } = req.body;

    if (username && password) {
        connectiondb.query(`SELECT * FROM users WHERE username='${username}'`, (err, result) => {
            if (err) {
                console.log(err);
                res.status(500).send('Internal Server Error');
                return;
            }

            if (result.length > 0) {
                const user = result[0];
                bcrypt.compare(password, user.password, (err, match) => {
                    if (err) {
                        console.log(err);
                        res.status(500).send('Internal Server Error');
                        return;
                    }

                    if (match) {
                        res.json({
                            loginStatus: true,
                            message: 'Login successfully',
                            userInfo: user
                        });
                    } else {
                        res.json({
                            loginStatus: false,
                            message: 'Invalid Password'
                        });
                    }
                });
            } else {
                res.json({
                    loginStatus: false,
                    message: 'User not found'
                });
            }
        });
    } else {
        res.status(400).json({
            message: 'Username and password are required'
        });
    }
});



// products
app.get('/products', (req, res) => {
    connectiondb.query("SELECT * FROM products", (err, result) => {
        if (err) {
            console.log(err);
        } else {
            res.send(result);
        }
    });
});

// type
app.get('/type', (req, res) => {
    connectiondb.query("SELECT * FROM type", (err, result) => {
        if (err) {
            console.log(err);
        } else {
            res.send(result);
        }
    });
});

// banners
app.get('/banners', (req, res) => {
    connectiondb.query("SELECT * FROM banners", (err, result) => {
        if (err) {
            console.log(err);
        } else {
            res.send(result);
        }
    });
});

// cart
app.get('/cart', (req, res) => {
    connectiondb.query("SELECT cart.*, products.*, users.* " +
        "FROM cart " +
        "JOIN products ON cart.product_id = products.product_id " +
        "JOIN users ON cart.user_id = users.user_id",
        (err, result) => {
            if (err) {
                console.log(err);
                res.status(500).send("Internal Server Error");
            } else {
                res.send(result);
            }
        });
});

// cart/id
app.get('/cart/:cart_id', (req, res) => {
    const cart_id = req.params.cart_id;
    connectiondb.query("SELECT cart.*, products.*, users.* " +
        "FROM cart " +
        "JOIN products ON cart.product_id = products.product_id " +
        "JOIN users ON cart.user_id = users.user_id " +
        "WHERE cart.cart_id = ?",
        [cart_id],
        (err, result) => {
            if (err) {
                console.log(err);
                res.status(500).send("Internal Server Error");
            } else {
                res.send(result);
            }
        });
});

// cart/delete
app.delete('/cart/:cart_id', (req, res) => {
    const cart_id = req.params.cart_id;
    connectiondb.query("DELETE FROM cart WHERE cart_id = ?", [cart_id], (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).send("Internal Server Error");
        } else {
            res.send("Cart item deleted successfully");
        }
    });
});

app.delete('/cart', (req, res) => {
    connectiondb.query("DELETE FROM cart", (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).send("Internal Server Error");
        } else {
            res.send("All items in cart deleted successfully");
        }
    });
});






// เส้นทาง POST สำหรับการเพิ่มสินค้าลงในตะกร้า
app.post('/addtocart', (req, res) => {
    console.log(req.body);
    // ทำการเพิ่มสินค้าลงในตะกร้า โดยที่นี่คุณสามารถทำการเชื่อมต่อกับฐานข้อมูลของคุณหรือทำการเพิ่มข้อมูลลงในอาร์เรย์หรืออื่น ๆ ตามที่คุณต้องการ
    connectiondb.query("INSERT INTO cart (product_id, user_id, quantity ) VALUES (?, ?, ?)", [req.body.product_id, req.body.user_id, req.body.quantity ], (err) => {
        if (err) {
            console.log(err);
            res.status(500).send('Error adding product to cart');
            return;
        } else {
            console.log('Product added to cart successfully!');
            // ส่งข้อมูลสินค้าที่ถูกเพิ่มลงในตะกร้ากลับไปหาลูกค้า
            res.status(200).send('Product added to cart successfully!');
        }
    });
});

app.post('/addorder', (req, res) => {
    console.log(req.body);
    // ทำการเพิ่มสินค้าลงในตะกร้า โดยที่นี่คุณสามารถทำการเชื่อมต่อกับฐานข้อมูลของคุณหรือทำการเพิ่มข้อมูลลงในอาร์เรย์หรืออื่น ๆ ตามที่คุณต้องการ
    connectiondb.query("INSERT INTO `order` (product_id, user_id, quantity) VALUES (?, ?, ?)", [req.body.product_id, req.body.user_id, req.body.quantity], (err) => {
        if (err) {
            console.log(err);
            res.status(500).send('Error adding product to order');
            return;
        } else {
            console.log('Product added to cart successfully!');
            // ส่งข้อมูลสินค้าที่ถูกเพิ่มลงในตะกร้ากลับไปหาลูกค้า
            res.status(200).send('Product added to cart successfully!');
        }
    });
});


// เส้นทาง POST สำหรับการเพิ่ม order
// app.post('/addorder', (req, res) => {
//     console.log(req.body);
//     // ทำการเพิ่มสินค้าลงในตะกร้า โดยที่นี่คุณสามารถทำการเชื่อมต่อกับฐานข้อมูลของคุณหรือทำการเพิ่มข้อมูลลงในอาร์เรย์หรืออื่น ๆ ตามที่คุณต้องการ
//     connectiondb.query("INSERT INTO orderdetail (order_id, product_id, order_price ) VALUES (?, ?, ?)", [req.body.order_id, req.body.product_id, req.body.order_price ], (err) => {
//         if (err) {
//             console.log(err);
//             res.status(500).send('Error adding product to cart');
//             return;
//         } else {
//             console.log('Product added to cart successfully!');
//             // ส่งข้อมูลสินค้าที่ถูกเพิ่มลงในตะกร้ากลับไปหาลูกค้า
//             res.status(200).send('Product added to cart successfully!');
//         }
//     });
// });

app.listen(5000, () => {
    console.log("Server listening in http://localhost:5000")
})
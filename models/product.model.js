const db = require("./db.js");

// Constructor
const Product = function (product) {
  this.name = product.name;
  this.price = product.price;
  this.quantity = product.quantity
  this.description = product.description;
};

// Insert
Product.create = (newProduct, result) => {
  let sql = `INSERT INTO products SET ?`
  db.query(sql, newProduct, (err, res) => {
    if (err) {
      result(err, null);
      return;
    }
    result(null, { result: res });
  });
};

Product.findById = (productId, result) => {
  db.query(`SELECT * FROM products WHERE product_id = ${productId}`, (err, res) => {
    if (err) {
      console.log("error:  ", err);
      result(err, null);
      return;
}
    if (res.length) {
      console.log("Found Product: ", res[0]);
      result(null, res[0]);
    }
    result({ kind: "not_found" }, null);
  });
};

Product.getAll = (result) => {
  let sql = `SELECT * FROM products`
  db.query(sql, (err, res) => {
    if (err) {
      result(err, null);
      return;
    }
    result(null, res);
  });
};

Product.updateById = (productId, product, result) => {
  let sql = `UPDATE products SET name=?, amount=?, quantity=?, WHERE _id =? `
  db.query(sql, [product.name, product.price, product.quantity, productId],
    (err, res) => {
      if (err) {
        console.log("error:  ", err);
        result(err, null);
        return;
      }

      if (res.affectedRows == 0) {
        result({ kind: "not_found" }, null);
        return;
      }
      console.log("Updated Product: ");
      result(null, { _id: productId, ...product });
    }
  );
};

Product.remove = (productId, result) => {
  let sql = `DELETE FROM products WHERE product_id =   ${productId}`
  db.query(sql, (err, res) => {
    if (err) {
      console.log("error:  ", err);
      result(err, null);
      return;
    }

    if (res.affectedRows == 0) {
      result({ kind: "not_found" }, null);
      return;
    }
    console.log("Deleted Product: ");
    result(null, res);
  });
};


module.exports = Product
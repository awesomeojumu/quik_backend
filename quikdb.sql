DROP database IF EXISTS quik;
CREATE DATABASE quik;
USE quik;

CREATE TABLE users(
user_id INT(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
first_name VARCHAR(22) NOT NULL,
last_name VARCHAR(22) NOT NULL,
middle_name VARCHAR(22),
date_of_birth DATE,
created_date DATETIME DEFAULT NOW(),
email VARCHAR(32) UNIQUE NOT NULL,
password VARCHAR(256),
contact_address VARCHAR(256),
shipping_address_1 VARCHAR(120) NOT NULL,
shipping_address_2 VARCHAR(120),
state_of_residence VARCHAR(15),
gender VARCHAR(15),
phone_number_1 INT(15),
phone_nuumber_2 INT(15)
);

CREATE TABLE category(
category_id INT(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
category_name VARCHAR(22),
category_img_url VARCHAR(50)
);

CREATE TABLE sellers(
seller_id INT(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
company_name VARCHAR(15),
address VARCHAR(30),
seller_website VARCHAR(30),
seller_name VARCHAR(22),
seller_phone_number VARCHAR(15)
);

CREATE TABLE payment(
payment_id INT(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
payment_type VARCHAR(15),
amount VARCHAR(15)
);

CREATE TABLE shipping(
shipping_id INT(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
name VARCHAR(15),
phone_number VARCHAR(15)
);

CREATE TABLE section(
section_id INT(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
section_name VARCHAR(15),
category_id INT(11),
FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE products(
product_id INT(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
product_name VARCHAR(15),
price VARCHAR(11),
discounted_price VARCHAR(11),
brand VARCHAR(15),
size VARCHAR(15),
decription CHAR,
product_image_url VARCHAR(120),
section_id INT(11),
seller_id INT(11),
FOREIGN KEY (section_id) REFERENCES section(section_id),
FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

CREATE TABLE purchase_history(
purchase_id INT(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
product_count VARCHAR(10),
purchase_date DATETIME DEFAULT NOW(),
user_id INT(11),
product_id INT(11),
FOREIGN KEY (user_id) REFERENCES users(user_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE product_comments(
coment_id INT(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
comment VARCHAR(225),
star VARCHAR(1),
comment_date DATETIME DEFAULT NOW(),
user_id INT(11),
product_id INT(11),
purchase_id INT(11),
FOREIGN KEY (user_id) REFERENCES users(user_id),
FOREIGN KEY (purchase_id) REFERENCES purchase_history(purchase_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE orders(
order_id INT(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
order_date DATETIME DEFAULT NOW(),
status VARCHAR(10),
product_id INT(11),
payment_id INT(11),
shipping_id INT(11),
FOREIGN KEY (product_id) REFERENCES products(product_id),
FOREIGN KEY (payment_id) REFERENCES payment(payment_id),
FOREIGN KEY (shipping_id) REFERENCES shipping(shipping_id)
);

CREATE TABLE cart(
cart_id INT(11) AUTO_INCREMENT PRIMARY KEY NOT NULL,
total VARCHAR(30),
product_count VARCHAR(20),
user_id INT(11),
product_id INT(11),
FOREIGN KEY (product_id) REFERENCES products(product_id),
FOREIGN KEY (user_id) REFERENCES users(user_id)
);
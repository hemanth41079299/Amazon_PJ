CREATE DATABASE amazon_analytics;
USE amazon_analytics;

# product table 
CREATE TABLE  products (
  product_id VARCHAR(50) PRIMARY KEY,
  product_name VARCHAR(255),
  category VARCHAR(100),
  subcategory VARCHAR(100),
  brand VARCHAR(100),
  product_weight_kg DECIMAL(10,3),
  product_rating DECIMAL(3,2),
  is_prime_eligible BOOLEAN
);

# Customer table 
CREATE TABLE  customers (
  customer_id VARCHAR(50) PRIMARY KEY,
  customer_city VARCHAR(100),
  customer_state VARCHAR(100),
  customer_tier VARCHAR(50),
  customer_spending_tier VARCHAR(50),
  customer_age_group VARCHAR(50),
  is_prime_member BOOLEAN
);

# Time dimension table
CREATE TABLE time_dimension (
  date_key DATE PRIMARY KEY,
  order_year SMALLINT,
  month_num TINYINT,
  month_name VARCHAR(15),
  order_quarter TINYINT,
  month_year VARCHAR(7),
  month_year_label VARCHAR(10)
);

#Transactions table
CREATE TABLE  transactions (
  transaction_id VARCHAR(50) PRIMARY KEY,
  order_date DATE,
  customer_id VARCHAR(50),
  product_id VARCHAR(50),

  original_price_inr DECIMAL(12,2),
  discounted_price_inr DECIMAL(12,2),
  discount_percent DECIMAL(6,2),
  quantity INT,
  subtotal_inr DECIMAL(14,2),
  final_amount_inr DECIMAL(14,2),

  delivery_days INT,
  delivery_type VARCHAR(50),

  is_prime_member BOOLEAN,
  is_festival_sale BOOLEAN,
  festival_name VARCHAR(100),

  payment_method VARCHAR(50),
  customer_rating DECIMAL(3,2),
  return_status VARCHAR(50),

  is_prime_eligible BOOLEAN,
  product_rating DECIMAL(3,2),

  is_duplicate BOOLEAN,
  bulk_order BOOLEAN
);

CREATE INDEX idx_tx_order_date ON transactions(order_date);
CREATE INDEX idx_tx_customer_id ON transactions(customer_id);
CREATE INDEX idx_tx_product_id ON transactions(product_id);
CREATE INDEX idx_tx_category_payment ON transactions(payment_method);
CREATE INDEX idx_tx_festival ON transactions(is_festival_sale);

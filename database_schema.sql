-- Creating the Society table
CREATE TABLE society (
    society_id VARCHAR(36) PRIMARY KEY,
    society_name VARCHAR(100) NOT NULL,
    society_address VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Creating the Chef table with the new constraints
CREATE TABLE chef (
    chef_id VARCHAR(36) PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number BIGINT NOT NULL UNIQUE,
    specialities VARCHAR(255),
    payment_upi_no BIGINT,
    payment_upi_id VARCHAR(100),
    society_id VARCHAR(36) NOT NULL,
    is_open BOOLEAN NOT NULL DEFAULT FALSE,
    auto_close_time TIME,
    allows_pickup BOOLEAN DEFAULT TRUE,
    has_delivery BOOLEAN DEFAULT FALSE,
    estimated_delivery_time_minutes INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (society_id) REFERENCES society(society_id)
);

-- Creating the Customer table with the new constraints
CREATE TABLE customer (
    customer_id VARCHAR(36) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone_number BIGINT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE customer_address (
    address_id VARCHAR(36) PRIMARY KEY,
    customer_id VARCHAR(36) NOT NULL,
    address VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Creating the Items table with the new constraint on chef_id
CREATE TABLE items (
    item_id VARCHAR(36) PRIMARY KEY,
    chef_id VARCHAR(36) NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    item_description VARCHAR(255),
    item_price INT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    auto_close_order_limit INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (chef_id) REFERENCES chef(chef_id)
);

-- Creating the Cart table with new constraints
CREATE TABLE cart (
    cart_id VARCHAR(36) PRIMARY KEY,
    customer_id VARCHAR(36) NOT NULL,
    item_id VARCHAR(36) NOT NULL,
    quantity INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- Creating the Orders table with new constraints
CREATE TABLE orders (
    order_id VARCHAR(36) PRIMARY KEY,
    customer_id VARCHAR(36) NOT NULL,
    chef_id VARCHAR(36) NOT NULL,
    customer_address_id VARCHAR(36) NOT NULL,
    order_time DATETIME NOT NULL,
    order_status VARCHAR(30) NOT NULL,
    is_pickup BOOLEAN NOT NULL DEFAULT FALSE,
    is_delivery BOOLEAN NOT NULL DEFAULT FALSE,
    payment_status VARCHAR(30) NOT NULL,
    total_amount INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (chef_id) REFERENCES chef(chef_id),
    FOREIGN KEY (customer_address_id) REFERENCES customer_address(address_id)
);

-- Creating the Order_Items table with a composite primary key
CREATE TABLE order_items (
    order_id VARCHAR(36) NOT NULL,
    item_id VARCHAR(36) NOT NULL,
    quantity INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

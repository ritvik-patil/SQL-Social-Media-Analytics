-- Create Instagram clone database
CREATE DATABASE igclone;
USE igclone;

-- Create Users Table
CREATE TABLE users (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

DESC users;

# Insert some values
INSERT INTO users(username) VALUES 
('BlueTheCat'),
('CharlieBrown'),
('RitvikPatil');

SELECT * FROM users;

-- Create photos schema/table
CREATE TABLE photos (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

DESC photos;
SHOW TABLES;

-- Insert values inti photos
INSERT INTO photos(image_url, user_id) VALUES
('/ahdgf85',1),
('/ahdgf51',2),
('/ahdgf32',2);

# Adding captions column to the photos table
ALTER TABLE photos ADD COLUMN captions VARCHAR(50) DEFAULT NULL;
ALTER TABLE photos MODIFY captions TEXT DEFAULT NULL;

# Inserting values into captions column
UPDATE photos
SET captions = 
CASE 
    WHEN id = 1 THEN 'My cats'
    WHEN id = 2 THEN 'My meal'
    WHEN id = 3 THEN 'A selfie'
    -- Add more cases as needed
    ELSE NULL -- Default value for unspecified cases
END;

SELECT * FROM photos;

-- # Let us find out using joins usernames linked with image_url 
-- SELECT p.image_url, u.username 
-- FROM photos p
-- JOIN users u
-- 	ON p.user_id = u.id;

# Create Comments table
CREATE TABLE comments (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    photo_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

DESC comments;

# Insert data into comments table
INSERT INTO comments(comment_text, photo_id, user_id) VALUES
('Awesome!', 1, 2),
('Amazing Shot!', 3, 2),
('I <3 This', 2, 1);

# Check Inserted values
SELECT * FROM comments;

# Create Likes table
CREATE TABLE likes (
    user_id INTEGER NOT NULL,
    photo_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    PRIMARY KEY(user_id, photo_id)   -- This combination makes sure that one user can like only one picture
);

DESC likes;

# Insert values into likes table
INSERT INTO likes(user_id, photo_id) VALUES
(1,1),
(2,1),
(1,2),
(1,3),
(3,3);

-- Won't work because of primary key constraint
-- INSERT INTO likes(user_id, photo_id) VALUES (1,1);

SELECT * FROM likes;

# Create table follows
CREATE TABLE follows (
    follower_id INTEGER NOT NULL,
    followee_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id)
);

DESCRIBE follows;

#Insert values into follows
INSERT INTO follows(follower_id,followee_id) VALUES
(1,2),
(1,3),
(3,1),
(2,3);

SELECT * FROM follows;

-- Won't work because of primary key constraint
-- INSERT INTO follows(follower_id,followee_id) VALUES (1,3);

-- will work because of unique combination
INSERT INTO follows(follower_id,followee_id) VALUES (2,1);

#create table tags
CREATE TABLE tags (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  tag_name VARCHAR(255) UNIQUE,
  created_at TIMESTAMP DEFAULT NOW()
);
DESC tags;

# Insert values into tags
INSERT INTO tags(tag_name) VALUES
('adorable'),
('cute'),
('sunrise');

SELECT * FROM tags;

# Create table photo tags
CREATE TABLE photo_tags (
    photo_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)    -- Ensures user cannot use the same tag twice in one photo
);
DESC photo_tags;

# Insert values into photo tags
INSERT INTO photo_tags(photo_id, tag_id) VALUES
(1,1),
(1,2),
(2,3),
(3,2);

-- Duplicate insert won't work due to primary key constraint on photo_id, tag_id combination
-- INSERT INTO photo_tags(photo_id, tag_id) VALUES(1,1); 

SELECT * FROM photo_tags;

# Check out all tables from the database schema
SHOW TABLES;







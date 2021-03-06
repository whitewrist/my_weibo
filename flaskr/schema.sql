DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS blog;
DROP TABLE IF EXISTS follower;
DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS user_comment;
DROP TABLE IF EXISTS user_blog;
DROP TABLE IF EXISTS blog_comment;


CREATE TABLE user(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  dated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE blog(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  dated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  context TEXT NOT NULL,
  ori_blog_id INTEGER DEFAULT 0,
  FOREIGN KEY (ori_blog_id) REFERENCES blog(id) ON DELETE SET DEFAULT
);

insert into blog (id, context) values (0, 'This blog had been deleted');
insert into blog (id, context) values (-1, 'This blog had been deleted');

CREATE TABLE comment(
  user_id INTEGER NOT NULL,
  blog_id INTEGER NOT NULL,
  context TEXT NOT NULL,
  dated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE follower(
  follower_id INTEGER NOT NULL,
  leader_id INTEGER NOT NULL,
  dated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (follower_id) REFERENCES user (id)
  FOREIGN KEY (leader_id) REFERENCES user (id)
);



CREATE TABLE user_comment(
  user_id INTEGER NOT NULL,
  comment_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user(id)
  FOREIGN KEY (comment_id) REFERENCES comment(id)
);


CREATE TABLE blog_comment(
  blog_id INTEGER NOT NULL,
  comment_id INTEGER NOT NULL,
  FOREIGN KEY (comment_id) REFERENCES comment(id)
  FOREIGN KEY (blog_id) REFERENCES blog(id)
);


CREATE TABLE user_blog(
  dated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  blog_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user(id)
  FOREIGN KEY (blog_id) REFERENCES blog(id)
);


SET @username = '%dave%' COLLATE utf8_unicode_ci;

SELECT *
FROM users
WHERE username LIKE @username;

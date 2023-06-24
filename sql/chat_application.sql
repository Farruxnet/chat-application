-- CREATE users TABLE
CREATE TABLE IF NOT EXISTS users(
    id BIGSERIAL PRIMARY KEY,
    full_name CHAR(128)  NOT NULL,
    email CHAR(128) UNIQUE NOT NULL,
    password CHAR(256)  NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- CREATE user_profile TABLE
CREATE TABLE IF NOT EXISTS user_profile(
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT UNIQUE REFERENCES users(id) NOT NULL,
    profile_image CHARACTER(256),
    phone_number CHARACTER(20),
    address TEXT CHECK(LENGTH(address) <= 256),
    date_of_birth TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW()
);

-- CREATE user_tokens TABLE
CREATE TABLE IF NOT EXISTS user_tokens(
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT UNIQUE REFERENCES users(id) NOT NULL,
    refresh CHARACTER(512) NOT NULL,
    access CHARACTER(512) NOT NULL,
    token CHARACTER(128) NOT NULL,
    exp_access TIMESTAMP NOT NULL,
    exp_refresh TIMESTAMP NOT NULL,
    exp_token TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW()
);

-- CREATE media TABLE
CREATE TABLE IF NOT EXISTS media(
    id BIGSERIAL PRIMARY KEY,
    photo CHARACTER(256),
    video CHARACTER(256),
    file CHARACTER(256),
    gif CHARACTER(256),
    created_at TIMESTAMP DEFAULT NOW()
);

-- CREATE messages TABLE
CREATE TABLE IF NOT EXISTS messages(
    id BIGSERIAL PRIMARY KEY,
    from_user BIGINT NOT NULL,
    to_user BIGINT NOT NULL,
    message TEXT CHECK (LENGTH(message) <= 1024),
    media BIGINT UNIQUE REFERENCES media(id),
    reply_to BIGINT REFERENCES messages(id),
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (from_user) references users(id),
    FOREIGN KEY (to_user) references users(id)
);


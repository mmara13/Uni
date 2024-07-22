--tabel USER
CREATE TABLE USERS (
    user_id INT PRIMARY KEY,
    username VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    email VARCHAR(255),
    birth_date DATE,
    country VARCHAR(255)
);

--table ARTIST
CREATE TABLE ARTIST(
    artist_id INT PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    description VARCHAR(255)
);

--tabel ALBUM
CREATE TABLE ALBUM (
    album_id INT PRIMARY KEY,
    genre VARCHAR(255),
    price DECIMAL(10,2) CHECK (price>0),
    release_date DATE,
    artist_id INT,
    CONSTRAINT album_artist_fk FOREIGN KEY (artist_id) REFERENCES ARTIST (artist_id)
    --dam nume pt fk ca sa putem identifica erori
);

--tabel USER_LIKES_ALBUM
CREATE TABLE USER_LIKES_ALBUM(
    user_id INT, 
    album_id INT,
    PRIMARY KEY(user_id, album_id),
    FOREIGN KEY(user_id) REFERENCES USERS(user_id),
    FOREIGN KEY(album_id) REFERENCES ALBUM (album_id)
);

--tabel ARTIST_LAUNCH_ALBUM
CREATE TABLE ARTIST_LAUNCH_ALBUM(
    artist_id INT,
    album_id INT,
    PRIMARY KEY(artist_id, album_id),
    FOREIGN KEY(artist_id) REFERENCES ARTIST (artist_id),
    FOREIGN KEY(album_id) REFERENCES ALBUM(album_id)
);

--tabel USER_FOLLOWS_ARTIST
CREATE TABLE USER_FOLLOWS_ARTIST(
    user_id INT,
    artist_id INT,
    PRIMARY KEY (user_id, artist_id),
    FOREIGN KEY(user_id) REFERENCES USERS(user_id),
    FOREIGN KEY(artist_id) REFERENCES ARTIST(artist_id)
);

--tabel SONG
CREATE TABLE SONG(
    song_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    duration NUMBER(3,0) NOT NULL,
    release_date DATE,
    album_id INT,
    artist_id INT,
    CONSTRAINT song_artist_fk FOREIGN KEY (artist_id) REFERENCES ARTIST(artist_id),
    CONSTRAINT song_album_fk FOREIGN KEY (album_id) REFERENCES ALBUM(album_id)
);

--tabel ARTIST_SINGS_SONG
CREATE TABLE ARTIST_SINGS_SONG (
    artist_id INT,
    song_id INT,
    PRIMARY KEY(artist_id, song_id),
    FOREIGN KEY (artist_id) REFERENCES ARTIST (artist_id),
    FOREIGN KEY (song_id) REFERENCES SONG(song_id)
);

--tabel PLAYLIST
CREATE TABLE PLAYLIST (
    playlist_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    creation_date DATE NOT NULL
);

--TABEL songs_in_playlist_user
CREATE TABLE SONGS_IN_PLAYLIST_USER(
    song_id INT,
    playlist_id INT,
    user_id INT,
    add_date DATE,  --data adaugarii melodiei in playlist-ul userului
    PRIMARY KEY (song_id, playlist_id, user_id),
    FOREIGN KEY(song_id) REFERENCES SONG(song_id),
    FOREIGN KEY (playlist_id) REFERENCES PLAYLIST(playlist_id),
    FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);

--tabel USER_LIKES_PLAYLIST
CREATE TABLE USER_LIKES_PLAYLIST(
    user_id INT,
    playlist_id INT,
    PRIMARY KEY (user_id, playlist_id),
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY(playlist_id) REFERENCES PLAYLIST(playlist_id)
);

--tabel SONG_HISTORY
CREATE TABLE SONG_HISTORY(
    song_history_id INT PRIMARY KEY,
    user_id INT,
    song_id INT,
    listen_Date DATE,
    FOREIGN KEY (user_id) REFERENCES USERS (user_id),
    FOREIGN KEY(song_id) REFERENCES SONG (song_id)
);

--table PODCAST
CREATE TABLE PODCAST (
    podcast_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    nr_episodes INT CHECK (nr_episodes >0),
    author_name VARCHAR(255)
);

--tabel EPISODE
CREATE TABLE EPISODE(
    episode_id INT PRIMARY KEY,
    podcast_id INT,
    title VARCHAR(255) NOT NULL,
    FOREIGN KEY (podcast_id) REFERENCES PODCAST(podcast_id)
);

--tabel PODCAST_HISTORY
CREATE TABLE PODCAST_HISTORY(
    podcast_history_id INT PRIMARY KEY,
    user_id INT,
    episode_id INT,
    listen_date DATE,
    FOREIGN KEY (user_id) REFERENCES USERs (user_id),
    FOREIGN KEY (episode_id) REFERENCES EPISODE(episode_id)
);

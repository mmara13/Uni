select * from playlist;

SELECT a.constraint_name AS fk_constraint_name,
       a.table_name AS source_table,
       b.table_name AS referenced_table,
       c.column_name AS source_column,
       d.column_name AS referenced_column
  FROM all_constraints a
       JOIN all_constraints b
       ON a.r_constraint_name = b.constraint_name
       JOIN all_cons_columns c
       ON a.constraint_name = c.constraint_name
       JOIN all_cons_columns d
       ON b.constraint_name = d.constraint_name
 WHERE a.constraint_type = 'R'
       AND a.table_name = 'PODCAST';
       
       
SELECT cc.column_name
FROM all_constraints c
JOIN all_cons_columns cc
ON c.constraint_name = cc.constraint_name
WHERE c.table_name = 'PODCAST'
AND c.constraint_type = 'P';

ALTER TABLE ARTIST_CANTA_MELODIE
ADD CONSTRAINT PK_ARTIST_CANTA_MELODIE
PRIMARY KEY (artist_id, melodie_id);

ALTER TABLE ARTIST_CANTA_MELODIE
ADD CONSTRAINT FK_ARTIST_CANTA_MELODIE_MELODIE
FOREIGN KEY (melodie_id)
REFERENCES MELODIE(melodie_id);

commit;

-- Drop the existing foreign key constraints
ALTER TABLE MELODIE DROP CONSTRAINT ARTIST_SINGS_SONG_SONG_ID_FK;
ALTER TABLE MELODIE DROP CONSTRAINT song_album_fk;

-- Add the correct foreign key constraints
ALTER TABLE MELODIE
ADD CONSTRAINT song_artist_fk
FOREIGN KEY (artist_id)
REFERENCES ARTIST(artist_id);

ALTER TABLE MELODIE
ADD CONSTRAINT song_album_fk
FOREIGN KEY (album_id)
REFERENCES ALBUM(album_id);

commit;

ALTER TABLE MELODIE_IN_PLAYLIST_UTILIZATOR
ADD CONSTRAINT PK_MELODIE_IN_PLAYLIST_UTILIZATOR
PRIMARY KEY (melodie_id, playlist_id, utilizator_id);


ALTER TABLE UTILIZATOR_APRECIAZA_PLAYLIST
ADD CONSTRAINT PK_UTILIZATOR_APRECIAZA_PLAYLIST PRIMARY KEY (utilizator_id, playlist_id);

ALTER TABLE UTILIZATOR_APRECIAZA_PLAYLIST
ADD CONSTRAINT FK_UA_PLAYLIST_ID FOREIGN KEY (playlist_id) REFERENCES PLAYLIST(playlist_id);

commit;
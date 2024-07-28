select * from melodie;
select * from melodiecopy;
describe melodie;
create table melodiecopy as (select * from melodie);

SELECT CONSTRAINT_NAME
FROM USER_CONSTRAINTS
WHERE lower(TABLE_NAME) = 'melodie' AND R_CONSTRAINT_NAME IS NOT NULL;

ALTER TABLE MELODIE DROP CONSTRAINT song_artist_fk;
ALTER TABLE MELODIE DROP COLUMN ARTIST_ID;

drop table melodiecopy;
select * from user_tables;
commit;

describe artist_lanseaza_album;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'ALBUM';


ALTER TABLE artist_lanseaza_album
DROP CONSTRAINT SYS_C008324;

ALTER TABLE artist_lanseaza_album
DROP CONSTRAINT SYS_C008325;


DROP TABLE artist_lanseaza_album;
 select * from user_tables;
 select * from album;
 
 select * from album, artist
 where album.artist_id=artist.artist_id;
 commit;
 
 select * from istoric_melodii;
select a.artist_id, a.nume, count(uua.utilizator_id) as nr_urm
from artist a
left join utilizator_urmareste_artist uua on a.artist_id = uua.artist_id
group by a.artist_id, a.nume
order by nr_urm desc
fetch first 1 row only;


with nrcantece as (
    select a.gen, count(ist.melodie_id) as nr_cantece
    from istoric_melodii ist
    join melodie m on ist.melodie_id = m.melodie_id
    join album a on m.album_id=a.album_id
    group by a.gen
)
select gen, nr_cantece
from nrcantece
where nr_cantece = (
    select max(nr_cantece)
    from nrcantece);

 
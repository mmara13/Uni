select * from episode;
select * from podcast;

--inserare inregistrari podcast + episoade

insert into episode(episode_id, podcast_id, title)
VALUES(2, 1, 'The Killer Brothers Pt. 2');

insert into episode(episode_id, podcast_id, title)
values(3,1,'"The Buried Bodies Killer" Robert Garrow Pt. 1');

insert into episode(episode_id, podcast_id, title)
values(4, 1, '"The Buried Bodies Killer" Robert Garrow Pt. 2');

update podcast
set nr_episodes = 4
where podcast_id=1;

insert into podcast(podcast_id, name, nr_episodes, author_name)
values(2, 'Crime, Pisici si Cafea', 4, 'Alerina');

insert into episode(episode_id, podcast_id, title)
values(5, 2,'Primul Episod : Misterul reginei frumusetii ai anilor ''90 (Cazul JonBenet Ramsey)');

insert into episode(episode_id, podcast_id, title)
values(6, 2,'Episodul 2: Disparitia lui Madeline McCann');

insert into episode(episode_id, podcast_id, title)
values(7,2,'Episodul 3: Cultul lui Charles Manson - Cum arata "Procesul Secolului"');

insert into episode(episode_id, podcast_id, title)
values(8,2,'Episodul 4 : Este Ted Bundy cel mai malefic om a Americii anilor ''70?');

insert into podcast(podcast_id, name, nr_episodes, author_name)
values(3, 'Mind Architect', 2, 'Mind Architect');

insert into episode(episode_id, podcast_id, title)
values(9,3, 'Sezonul 1, Episodul 1 - Introducere in Arhitectura Cerebrala');

insert into episode(episode_id, podcast_id, title)
values(10,3, 'Sezonul 1, Episodul 2 - Calaretul si elefantul din capul fiecaruia dintre noi');

INSERT INTO podcast(podcast_id, name, nr_episodes, author_name)
VALUES (4, 'La Fileu', 1, 'Speak');

insert into episode(episode_id, podcast_id, title)
values(11, 4, '"E gratis sa oferi un zambet!" - LA FILEU cu Levi Elekes');

insert into podcast(podcast_id, name, nr_episodes, author_name)
values(5, 'MCN Podcast', 1, 'MCN Podcast');

insert into episode(episode_id, podcast_id, title)
values(12,5, 'Blues extraterestri si chemtrails');

insert into podcast(podcast_id, name, nr_episodes, author_name)
values(6, 'Vin de-o poveste', 1, 'Radu Tibulca');

insert into episode(episode_id, podcast_id, title)
values(13, 6, 'BACKPACKYOURLIFE: CU UN GHIOZDAN IN JURUL LUMII');

insert into podcast(podcast_id, name, nr_episodes, author_name)
values(7,'TED Talks Daily', 1, 'TED');

insert into episode(episode_id, podcast_id, title)
values(14,7, 'How "second chance" laws could transform the US justice system | Sheena Meade');

insert into podcast(podcast_id, name, nr_episodes, author_name)
values(8, 'Jocurile Mintii', 1, 'Raluca Anton');

insert into episode(episode_id, podcast_id, title)
values(15, 8, 'Jocurile Mintii- Ep.1-"Sa iti dai voie si tie sa existi"');

insert into podcast(podcast_id, name, nr_episodes, author_name)
values(9, 'Secrete de la Psiholog', 1, 'Psiholog Alexandru Plesea');

insert into episode(episode_id, podcast_id, title)
values(16, 9, 'Iubire versus Atasament - 5 diferente');

insert into podcast(podcast_id, name, nr_episodes, author_name)
values(10,'Podcastul medical', 1, 'Cristian Badescu');

insert into episode(episode_id, podcast_id, title)
values(17, 10, 'Dr. Gheorghe Gica | Recoltarea Celulelor Stem la nastere');


select * from artist;
select * from song;

--completare artisti
insert into artist(artist_id, name, age, description)
values(6, 'Dilja', 21, 'Icelandic singer');
insert into song(song_id, title, description, duration, release_date, album_id, artist_id)
values(22, 'POWER', '', 184, to_date('04-03-2023','dd-mm-yyyy'), null, 6);

insert into artist(artist_id, name, age, description)
values(7, 'Brunette', 21, 'Armenian singer-songwriter');
insert into song(song_id, title, description, duration, release_date, album_id, artist_id)
values(23, 'Future Lover', '', 166, to_date('15-03-2023','dd-mm-yyyy'), null, 7);

insert into artist(artist_id, name, age, description)
values(8, 'anees', 30, 'American singer, rapper, and songwriter');
insert into song(song_id, title, description, duration, release_date, album_id, artist_id)
values(24, 'Sun and Moon', '', 224, to_date('06-04-2022','dd-mm-yyyy'), null, 8);

insert into artist(artist_id, name, age, description)
values(9, 'Sonder', null, 'Band created by the artist Brent Faiyaz');
insert into song(song_id, title, description, duration, release_date, album_id, artist_id)
values(25, 'Searchin', '', 264, to_date('27-01-2017','dd-mm-yyyy'), null, 9);

insert into artist(artist_id, name, age, description)
values(10, 'Brent Faiyaz', 27, 'American R'||'&'||'B singer');
insert into song(song_id, title, description, duration, release_date, album_id, artist_id)
values(26, 'Fuck The World (Summer in London)', '', 237, to_date('07-02-2020','dd-mm-yyyy'), null, 10);


SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE constraint_name = 'SYS_C008351';

select * from user_likes_album;
insert into USER_LIKES_ALBUM(user_id, ALBUM_ID)
values(1,2);
insert into USER_LIKES_ALBUM(user_id, ALBUM_ID)
values(1,7);
insert into USER_LIKES_ALBUM(user_id, ALBUM_ID)
values(1,11);
insert into USER_LIKES_ALBUM(user_id, ALBUM_ID)
values(2, 5);
insert into USER_LIKES_ALBUM(user_id, ALBUM_ID)
values(2,8);
insert into USER_LIKES_ALBUM(user_id, ALBUM_ID)
values(2, 3);
insert into USER_LIKES_ALBUM(user_id, ALBUM_ID)
values(5,10);
insert into USER_LIKES_ALBUM(user_id, ALBUM_ID)
values(6,10);
insert into USER_LIKES_ALBUM(user_id, ALBUM_ID)
values(7,10);
insert into USER_LIKES_ALBUM(user_id, ALBUM_ID)
values(10,10);
insert into USER_LIKES_ALBUM(user_id, ALBUM_ID)
values(10,11);


select * from artist_launch_album;
select * from album;
--1- alicia -album 1
--2- ne yo -album 2
--3 adele - album 3, 4, 5
--4 the wekn -album 6,7,8,9
--5 fletcher - album 10,11
insert into artist_launch_album(artist_id, album_id)
values(2,2);
insert into artist_launch_album(artist_id, album_id)
values(3,3);
insert into artist_launch_album(artist_id, album_id)
values(3,4);
insert into artist_launch_album(artist_id, album_id)
values(3,5);
insert into artist_launch_album(artist_id, album_id)
values(4,6);
insert into artist_launch_album(artist_id, album_id)
values(4,7);
insert into artist_launch_album(artist_id, album_id)
values(4,8);
insert into artist_launch_album(artist_id, album_id)
values(4,9);
insert into artist_launch_album(artist_id, album_id)
values(5,10);
insert into artist_launch_album(artist_id, album_id)
values(5,11);

select* from user_follows_artist;
select * from users;
insert into user_follows_artist(user_id, artist_id)
values(1,2);
insert into user_follows_artist(user_id, artist_id)
values(1,3);
insert into user_follows_artist(user_id, artist_id)
values(1,4);
insert into user_follows_artist(user_id, artist_id)
values(1,5);
insert into user_follows_artist(user_id, artist_id)
values(1,6);
insert into user_follows_artist(user_id, artist_id)
values(1,7);
insert into user_follows_artist(user_id, artist_id)
values(1,8);
insert into user_follows_artist(user_id, artist_id)
values(1,9);
insert into user_follows_artist(user_id, artist_id)
values(1,10);
insert into user_follows_artist(user_id, artist_id)
values(7,3);
insert into user_follows_artist(user_id, artist_id)
values(5,2);
insert into user_follows_artist(user_id, artist_id)
values(8,4);
insert into user_follows_artist(user_id, artist_id)
values(9,10);
insert into user_follows_artist(user_id, artist_id)
values(7,10);

select * from artist_sings_song;
select * from song;
insert into artist_sings_song(artist_id, song_id)
values(1,2);
insert into artist_sings_song(artist_id, song_id)
values(1,3);
insert into artist_sings_song(artist_id, song_id)
values(1,4);
insert into artist_sings_song(artist_id, song_id)
values(1,5);
insert into artist_sings_song(artist_id, song_id)
values(1,6);
insert into artist_sings_song(artist_id, song_id)
values(1,7);
insert into artist_sings_song(artist_id, song_id)
values(1,8);
insert into artist_sings_song(artist_id, song_id)
values(1,9);
insert into artist_sings_song(artist_id, song_id)
values(1,10);
insert into artist_sings_song(artist_id, song_id)
values(1,11);
insert into artist_sings_song(artist_id, song_id)
values(2,12);
insert into artist_sings_song(artist_id, song_id)
values(2,18);
insert into artist_sings_song(artist_id, song_id)
values(2,19);
insert into artist_sings_song(artist_id, song_id)
values(2,20);
insert into artist_sings_song(artist_id, song_id)
values(2,21);
insert into artist_sings_song(artist_id, song_id)
values(2,22);
insert into artist_sings_song(artist_id, song_id)
values(2,23);
insert into artist_sings_song(artist_id, song_id)
values(2,24);
insert into artist_sings_song(artist_id, song_id)
values(2,25);
insert into artist_sings_song(artist_id, song_id)
values(2,26);
insert into artist_sings_song(artist_id, song_id)
values(6,13);
insert into artist_sings_song(artist_id, song_id)
values(7,14);
insert into artist_sings_song(artist_id, song_id)
values(8,15);
insert into artist_sings_song(artist_id, song_id)
values(9,16);
insert into artist_sings_song(artist_id, song_id)
values(10,17);

select * from songs_in_playlist_user;
select * from playlist;
select* from song;
select* from users;

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(2,1,1,to_date('12-12-2014','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(2,1,4,to_date('12-12-2014','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(2,1,9, to_date('12-12-2014','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(2,1,2, to_date('14-12-2014','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(2,2,4, to_date('16-12-2014','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(2,2,9, to_date('16-12-2014','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(2,7,4, to_date('18-12-2014','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(2,7,9, to_date('18-12-2014','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(2,7,1, to_date('18-12-2014','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(1,1,4, to_date('04-04-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(1,1,10, to_date('04-04-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(1,2,4, to_date('09-04-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(1,2,9, to_date('09-04-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(1,7,4, to_date('09-04-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(1,7,10, to_date('09-04-2020','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(3,1,3, to_date('09-04-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(3,1,7,to_date('09-04-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(3,1,8, to_date('09-04-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(3,1,2, to_date('09-04-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(3,2,3, to_date('09-04-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(3,2,7,to_date('09-04-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(3,2,8,to_date('09-04-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(3,2,2,to_date('09-04-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(3,7,3,to_date('09-04-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(3,7,7,to_date('09-04-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(3,7,8, to_date('09-04-2020', 'dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(3,7,2,to_date('10-04-2020','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(4,2,1,to_date('13-04-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(4,2,2,to_date('13-04-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(4,2,3, to_date('13-04-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(4,7,1,to_date('13-04-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(4,7,2,to_date('13-04-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(4,7,3,to_date('13-04-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(4,10,1,to_date('13-04-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(4,10,2,to_date('13-04-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(4,10,3,to_date('13-04-2021','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(5,1,4,to_date('10-08-2022','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(5,1,5,to_date('10-08-2022','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(5,1,6,to_date('10-08-2022','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(5,2,4,to_date('10-08-2022','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(5,2,5,to_Date('10-08-2022','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(5,2,6,to_date('10-08-2022','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(5,7,4,to_date('10-08-2022','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(5,7,5,to_date('10-08-2022','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(5,7,6,to_date('10-08-2022','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(5,10,4,to_date('10-08-2022','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(5,10,5,to_date('10-08-2022','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(5,10,6,to_date('10-08-2022','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(6,1,7,to_date('10-10-2010','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(6,2,7,to_date('10-10-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(6,7,7,to_date('10-10-2010','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(6,10,7,to_date('10-10-2010','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(7,1,8,to_date('24-04-2022','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(7,1,10, to_date('24-04-2022','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(7,7,8,to_date('24-04-2022','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(7,7,10,to_date('24-04-2022','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(8,1,2,to_date('13-09-2015','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(8,1,3,to_date('13-09-2015','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(9,1,4,to_date('30-05-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(9,1,5,to_date('30-05-2020','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(10,1,6,to_date('02-02-2022','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(10,1,7,to_date('02-02-2022','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(11,1,8,to_date('10-10-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(11,1,10,to_date('10-10-2020','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(12,2,2,to_date('27-08-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(12,7,2,to_date('27-08-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(12,10,2,to_date('27-08-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(12,2,3,to_date('27-08-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(12,7,3, to_date('27-08-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(12,10,3,to_date('27-08-2020','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(13,2,4,to_date('03-03-2023','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(13,7,4,to_date('03-03-2023','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(13,10,4,to_date('03-03-2023','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(14,2,5,to_date('05-05-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(14,7,5,to_date('05-05-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(14,10,5,to_date('05-05-2020','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(15,2,6,to_date('06-06-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(15,7,6,to_date('06-06-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(15,10,6,to_date('06-06-2021','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(16,7,8,to_date('07-07-2022', 'dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(16,7,7,to_date('07-07-2022', 'dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(17,7,10,to_date('07-07-2022','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(17,7,11, to_date('07-07-2022','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(18,7,11,to_date('08-08-2022','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(18,7,2,to_date('08-08-2022','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(19,7,11,to_date('01-04-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(19,7,10,to_date('01-04-2020','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(20,2,1,to_date('04-12-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(20,7,1,to_date('04-12-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(20,9,1,to_date('04-12-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(20,10,1,to_date('04-12-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(20,2,7,to_date('04-12-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(20,7,7,to_date('04-12-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(20,9,7,to_date('04-12-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(20,10,7,to_date('04-12-2021','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(21,7,1,to_date('04-12-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(21,9,1,to_date('04-12-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(21,7,7,to_date('04-12-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(21,9,7,to_date('04-12-2021','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(22,2,3,to_date('09-06-2019','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(22,5,3,to_date('09-06-2019','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(22,12,3,to_date('09-06-2019','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(23,2,4,to_date('09-06-2019','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(23,5,4,to_date('09-06-2019','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(23,12,4,to_date('09-06-2019','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(24,2,6,to_date('10-08-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(24,5,6,to_date('10-08-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(24,9,6,to_date('10-08-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(24,12,6,to_date('10-08-2021','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(25,2,8,to_date('10-08-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(25,5,8,to_date('10-08-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(25,7,8,to_date('10-08-2021','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(25,12,8,to_date('10-08-2021','dd-mm-yyyy'));

insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(26,2,11,to_date('12-02-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(26,5,11,to_date('12-02-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(26,7,11,to_date('12-02-2020','dd-mm-yyyy'));
insert into songs_in_playlist_user(song_id, playlist_id, user_id, add_date)
values(26,12,11,to_date('12-02-2020','dd-mm-yyyy'));

select * from user_likes_playlist;
select * from playlist;
select * from users;
--1 2/4/9
--2 1/5/12
--3 6/7
--4 3/4
--5 8
--6 10
--7 2/5/9
--8 7
--9 1
--10 8
--1 5/12
insert into user_likes_playlist(user_id,playlist_id)
values(1,2);
insert into user_likes_playlist(user_id,playlist_id)
values(1,4);
insert into user_likes_playlist(user_id,playlist_id)
values(1,9);
insert into user_likes_playlist(user_id,playlist_id)
values(2,1);
insert into user_likes_playlist(user_id,playlist_id)
values(2,5);
insert into user_likes_playlist(user_id,playlist_id)
values(2,12);
insert into user_likes_playlist(user_id,playlist_id)
values(3,6);
insert into user_likes_playlist(user_id,playlist_id)
values(3,7);
insert into user_likes_playlist(user_id,playlist_id)
values(4,3);
insert into user_likes_playlist(user_id,playlist_id)
values(4,4);
insert into user_likes_playlist(user_id,playlist_id)
values(5,8);
insert into user_likes_playlist(user_id,playlist_id)
values(6,10);
insert into user_likes_playlist(user_id,playlist_id)
values(7,2);
insert into user_likes_playlist(user_id,playlist_id)
values(7,5);
insert into user_likes_playlist(user_id,playlist_id)
values(7,9);
insert into user_likes_playlist(user_id,playlist_id)
values(8,7);
insert into user_likes_playlist(user_id,playlist_id)
values(9,1);
insert into user_likes_playlist(user_id,playlist_id)
values(10,8);
insert into user_likes_playlist(user_id,playlist_id)
values(1,5);
insert into user_likes_playlist(user_id,playlist_id)
values(1,12);
commit;

select * from song_history;
insert into song_history(song_history_id, user_id, song_id, listen_date)
values(2,2,2,to_date('10-09-2022','dd-mm-yyyy'));
insert into song_history(song_history_id, user_id, song_id, listen_date)
values(3,3,5,to_date('10-10-2022','dd-mm-yyyy'));
insert into song_history(song_history_id, user_id, song_id, listen_date)
values(4,4,7,to_date('04-12-2021','dd-mm-yyyy'));
insert into song_history(song_history_id, user_id, song_id, listen_date)
values(5,5,10,to_date('09-12-2021','dd-mm-yyyy'));
insert into song_history(song_history_id, user_id, song_id, listen_date)
values(6,6,12,to_date('31-12-2021','dd-mm-yyyy'));
insert into song_history(song_history_id, user_id, song_id, listen_date)
values(7,7,14,to_date('28-01-2022','dd-mm-yyyy'));
insert into song_history(song_history_id, user_id, song_id, listen_date)
values(8,8,15,to_date('28-02-2022','dd-mm-yyyy'));
insert into song_history(song_history_id, user_id, song_id, listen_date)
values(9,9,16,to_date('04-06-2022','dd-mm-yyyy'));
insert into song_history(song_history_id, user_id, song_id, listen_date)
values(10,10,21,to_date('14-08-2022','dd-mm-yyyy'));
insert into song_history(song_history_id, user_id, song_id, listen_date)
values(11,11,26,to_date('04-12-2022','dd-mm-yyyy'));
insert into song_history(song_history_id, user_id, song_id, listen_date)
values(12,1,14,to_date('04-12-2021','dd-mm-yyyy'));
insert into song_history(song_history_id, user_id, song_id, listen_date)
values(13,7,15,to_date('04-12-2021','dd-mm-yyyy'));
select * from song_history;

select * from podcast_history;
select * from episode;

insert into podcast_history(podcast_history_id, user_id, episode_id, listen_date)
values(2,1,2,to_date('14-05-2023','dd-mm-yyyy'));
insert into podcast_history(podcast_history_id, user_id, episode_id, listen_date)
values(3,3,5,to_date('13-04-2023','dd-mm-yyyy'));
insert into podcast_history(podcast_history_id, user_id, episode_id, listen_date)
values(4,4,4,to_date('04-12-2021','dd-mm-yyyy'));
insert into podcast_history(podcast_history_id, user_id, episode_id, listen_date)
values(5,5,8,to_date('04-04-2020','dd-mm-yyyy'));
insert into podcast_history(podcast_history_id, user_id, episode_id, listen_date)
values(6,6,10,to_date('19-10-2020','dd-mm-yyyy'));
insert into podcast_history(podcast_history_id, user_id, episode_id, listen_date)
values(7,7,8,to_date('13-09-2020','dd-mm-yyyy'));
insert into podcast_history(podcast_history_id, user_id, episode_id, listen_date)
values(8,8,9,to_date('13-04-2023','dd-mm-yyyy'));
insert into podcast_history(podcast_history_id, user_id, episode_id, listen_date)
values(9,9,9,to_date('20-04-2023','dd-mm-yyyy'));
insert into podcast_history(podcast_history_id, user_id, episode_id, listen_date)
values(10,10,12,to_date('13-03-2023','dd-mm-yyyy'));
insert into podcast_history(podcast_history_id, user_id, episode_id, listen_date)
values(11, 11, 15,to_date('12-12-2020','dd-mm-yyyy'));
select * from podcast_history;
commit;
select * from users;
select * from artist;
select * from album;
select * from user_likes_album;
select * from artist_launch_album;
select * from user_follows_artist;
select * from song;
select * from artist_sings_song;
select * from playlist;
select * from songs_in_playlist_user;
select * from user_likes_playlist;
select * from song_history;
select * from podcast;
select * from episode;
select * from podcast_history;

--1 subcerere sincronizata cu 3 tabele

select u.username, a.title
from users u
join user_likes_album ula on u.user_id=ula.user_id
join album a on ula.album_id=a.album_id
where a.genre='Pop'
and u.username in(
    select username
    from users
    where country='US'
);

--2 subqueries unsynchronized in the FROM clause:
select u.username, (
    select count(*) from user_likes_playlist ulp
    where ulp.user_id = u.user_id
) as playlist_count
from users u;
select * from user_likes_playlist;

--3 groups of data  with unsynchronized subqueries and group functions:
select a.artist_id, a.name, avg(s.duration) as avg_duration
from artist a 
join album al on a.artist_id=al.artist_id
join song s on al.album_id=s.album_id
group by a.artist_id, a.name
having count(distinct al.album_id) = (select count(*) from user_follows_artist ufa
    where ufa.artist_id=a.artist_id
);
select * from users;
--4 orders, nvl and decode fct
select username, NVL(to_char(birth_date,'DD-MON-YYYY'), 'Not provided') as birth_date,
    decode(country, 'NL', 'Netherlands', 'Other') as country_alias
from users
order by username desc;

--5 Utilization of functions on strings, calendar data, and a CASE expression:
WITH song_data AS (
  SELECT s.title, s.release_date,
    CASE
      WHEN s.release_date > SYSDATE THEN 'Upcoming'
      WHEN s.release_date = TRUNC(SYSDATE) THEN 'Released today'
      ELSE 'Released'
    END AS release_status
  FROM SONG s
)
SELECT title, TO_CHAR(release_date, 'DD-MON-YYYY') AS formatted_date, release_status
FROM song_data
WHERE UPPER(title) LIKE '%YOU%'
  AND EXTRACT(YEAR FROM release_date) = 2007;
  
select * from song
where upper(title) like '%YOU%';

commit;
--1 update the price of the 1st album to the avg price of other albums by the same artist
UPDATE ALBUM
SET price = (
  SELECT AVG(price)
  FROM ALBUM
  WHERE artist_id = (
    SELECT artist_id
    FROM ALBUM
    WHERE album_id = 3
  )
)
WHERE album_id = 3;
select * from album;
rollback;
commit;
select * from son1g;
--2 update the release date of the first song to the latest release date
--of other songs by the same artist
UPDATE SONG
SET release_date = (
  SELECT MAX(release_date)
  FROM SONG
  WHERE artist_id = (
    SELECT artist_id
    FROM SONG
    WHERE song_id = 1
  )
)
WHERE song_id = 1;
commit;
--3 updating the username of the user with the maximum nr of liked albums
UPDATE USERS
SET username = 'mara1333'
WHERE user_id = (
  SELECT user_id
  FROM (
    SELECT user_id
    FROM USER_LIKES_ALBUM
    GROUP BY user_id
    ORDER BY COUNT(*) DESC
  )
  WHERE ROWNUM = 1
);

select * from users;
select * from user_likes_album;
commit;

select * from song;

DELETE FROM songs_in_playlist_user
WHERE playlist_id IN (
  SELECT playlist_id
  FROM playlist
  WHERE playlist_id IN (
    SELECT playlist_id
    FROM songs_in_playlist_user
    WHERE song_id IN (
      SELECT song_id
      FROM song
      WHERE EXTRACT(YEAR FROM release_date) < 2004
    )
  )
);
rollback;
DELETE FROM playlist
WHERE playlist_id IN (
  SELECT playlist_id
  FROM songs_in_playlist_user
  WHERE song_id IN (
    SELECT song_id
    FROM song
    WHERE EXTRACT(YEAR FROM release_date) < 2004
  )
);
select * from songs_in_playlist_user;

DELETE FROM song
WHERE song_id IN (
  SELECT song_id
  FROM song
  WHERE EXTRACT(YEAR FROM release_date) < 2004
);


rollback;
select * from songs_in_playlist_user;
DELETE FROM SONGS_IN_PLAYLIST_USER
WHERE playlist_id = (
  SELECT playlist_id
  FROM (
    SELECT playlist_id, COUNT(*) AS song_count
    FROM SONGS_IN_PLAYLIST_USER
    GROUP BY playlist_id
    ORDER BY song_count
    FETCH FIRST 1 ROW ONLY
  ) subquery
);

commit;

SELECT a.genre, COUNT(DISTINCT ula.user_id) AS num_users
FROM ALBUM a
JOIN USER_LIKES_ALBUM ula ON a.album_id = ula.album_id
GROUP BY a.genre;

SELECT a.genre, COUNT(DISTINCT ula.user_id) AS num_users
FROM ALBUM a
JOIN USER_LIKES_ALBUM ula ON a.album_id = ula.album_id
GROUP BY a.genre
HAVING COUNT(DISTINCT ula.user_id) > 1;

delete from songs_in_playlist_user
where song_id =21;

SELECT s.title AS song_name, s.song_id, a.title AS album_title, ar.name AS artist_name
FROM SONG s
LEFT JOIN ALBUM a ON s.album_id = a.album_id
LEFT JOIN ARTIST ar ON s.artist_id = ar.artist_id
LEFT JOIN (
  SELECT DISTINCT song_id
  FROM SONGS_IN_PLAYLIST_USER
) sp ON s.song_id = sp.song_id
WHERE sp.song_id IS NULL;

select * from songs_in_playlist_user;

SELECT p.playlist_id, p.title
FROM PLAYLIST p
WHERE p.playlist_id IN (
  SELECT sp.playlist_id
  FROM SONGS_IN_PLAYLIST_USER sp
  GROUP BY sp.playlist_id
  HAVING COUNT(sp.song_id) > 10
);

SELECT s.title AS song_name, COUNT(sh.song_id) AS listen_count
FROM SONG s
LEFT JOIN SONG_HISTORY sh ON s.song_id = sh.song_id
GROUP BY s.song_id, s.title
ORDER BY listen_count DESC
FETCH FIRST 5 ROWS ONLY;


--redenumire tabele in romana
ALTER TABLE USERS RENAME TO UTILIZATOR;
ALTER TABLE UTILIZATOR RENAME COLUMN user_id to utilizator_id;
alter table utilizator rename column username to nume_utilizator;
alter table utilizator rename column password to parola;
alter table utilizator rename column birth_date to data_nastere;
alter table utilizator rename column country to tara;

alter table ARTIST rename column name to nume;
alter table ARTIST rename column age to varsta;
alter table ARTIST rename column description to descriere;
alter table ALBUM rename column genre to gen;
alter table ALBUM rename column price to pret;
alter table ALBUM rename column title to titlu;
alter table ALBUM rename column release_date to data_lansare;
alter table USER_LIKES_ALBUM RENAME TO UTILIZATOR_APRECIAZA_ALBUM;
alter table UTILIZATOR_APRECIAZA_ALBUM RENAME column user_id to utilizator_id;
ALTER TABLE ARTIST_LAUNCH_ALBUM RENAME TO ARTIST_LANSEAZA_ALBUM;
ALTER TABLE USER_FOLLOWS_ARTIST RENAME TO UTILIZATOR_URMARESTE_ARTIST;
ALTER TABLE UTILIZATOR_URMARESTE_ARTIST RENAME column user_id to utilizator_id;
alter TABLE SONG RENAME TO MELODIE;
ALTER table MELODIE rename column song_id to melodie_id;
ALTER table MELODIE rename column title to titlu;
ALTER table MELODIE rename column description to descriere;
ALTER table MELODIE rename column release_date to data_lansare;
ALTER table MELODIE rename column duration to durata;
alter table ARTIST_SINGS_SONG RENAME TO ARTIST_CANTA_MELODIE;
alter table ARTIST_CANTA_MELODIE rename column song_id to melodie_id;
ALTER TABLE PLAYLIST RENAME COLUMN title to titlu;
ALTER TABLE PLAYLIST RENAME COLUMN creation_date to data_creare;
alter table SONGS_IN_PLAYLIST_USER RENAME TO MELODIE_IN_PLAYLIST_UTILIZATOR;
ALTER TABLE MELODIE_IN_PLAYLIST_UTILIZATOR RENAME COLUMN song_id to melodie_id;
ALTER TABLE MELODIE_IN_PLAYLIST_UTILIZATOR RENAME COLUMN user_id to utilizator_id;
ALTER TABLE MELODIE_IN_PLAYLIST_UTILIZATOR RENAME COLUMN add_date to data_adaugare;
ALTER TABLE USER_LIKES_PLAYLIST RENAME TO UTILIZATOR_APRECIAZA_PLAYLIST;
ALTER TABLE UTILIZATOR_APRECIAZA_PLAYLIST RENAME COLUMN user_id to utilizator_id;
ALTER TABLE SONG_HISTORY RENAME TO ISTORIC_MELODII;
ALTER TABLE ISTORIC_MELODII RENAME COLUMN song_history_id to istoric_melodii_id;
ALTER TABLE ISTORIC_MELODII RENAME COLUMN user_id to utilizator_id;
ALTER TABLE ISTORIC_MELODII RENAME COLUMN song_id to melodie_id;
ALTER TABLE ISTORIC_MELODII RENAME COLUMN listen_date to data_ascultare;
ALTER TABLE PODCAST RENAME COLUMN name to nume;
ALTER TABLE PODCAST RENAME COLUMN nr_episodes to nr_episoade;
ALTER TABLE PODCAST RENAME COLUMN author_name to nume_autor;
ALTER TABLE EPISODE RENAME TO EPISOD;
ALTER TABLE EPISOD RENAME COLUMN episode_id to episod_id;
ALTER TABLE EPISOD RENAME COLUMN title to titlu;
ALTER TABLE PODCAST_HISTORY RENAME TO PODCAST_ISTORIC;
ALTER TABLE PODCAST_ISTORIC RENAME COLUMN podcast_history_id to podcast_istoric_id;
ALTER TABLE PODCAST_ISTORIC RENAME COLUMN user_id to utilizator_id;
ALTER TABLE PODCAST_ISTORIC RENAME COLUMN episode_id to episod_id;
ALTER TABLE PODCAST_ISTORIC RENAME COLUMN listen_date to data_ascultare;

--ALTER TABLE UTILIZATOR_URMARESTE_ARTIST RENAME CONSTRAINT SYS_C001106 TO SYS_C001106_OLD;
--ALTER TABLE UTILIZATOR_URMARESTE_ARTIST ADD CONSTRAINT SYS_C001106 FOREIGN KEY (utilizator_id) REFERENCES UTILIZATOR(utilizator_id);

-- Rename the foreign key constraints in UTILIZATOR_URMARESTE_ARTIST table
ALTER TABLE UTILIZATOR_URMARESTE_ARTIST RENAME CONSTRAINT SYS_C008327 TO SYS_C008327_OLD;
ALTER TABLE UTILIZATOR_URMARESTE_ARTIST RENAME CONSTRAINT SYS_C008328 TO SYS_C008328_OLD;
ALTER TABLE UTILIZATOR_URMARESTE_ARTIST RENAME CONSTRAINT SYS_C008326 TO SYS_C008326_OLD;

ALTER TABLE MELODIE RENAME CONSTRAINT SONG_ARTIST_FK TO SONG_ARTIST_FK_OLD;
ALTER TABLE MELODIE RENAME CONSTRAINT SONG_ALBUM_FK TO SONG_ALBUM_FK_OLD;

ALTER TABLE MELODIE RENAME CONSTRAINT SONG_ARTIST_FK_OLD TO ARTIST_CANTA_MELODIE_FK;
ALTER TABLE MELODIE RENAME CONSTRAINT SONG_ALBUM_FK_OLD TO MELODIE_ALBUM_FK;

--SELECT CONSTRAINT_NAME
--FROM ALL_CONSTRAINTS
--WHERE TABLE_NAME = 'ARTIST_CANTA_MELODIE';

ALTER TABLE ARTIST_CANTA_MELODIE DROP CONSTRAINT SYS_C008335;
ALTER TABLE ARTIST_CANTA_MELODIE DROP CONSTRAINT SYS_C008336;
ALTER TABLE ARTIST_CANTA_MELODIE DROP CONSTRAINT SYS_C008334;

--ALTER TABLE ARTIST_CANTA_MELODIE DROP CONSTRAINT ARTIST_SINGS_SONG_ARTIST_ID_FK;
ALTER TABLE ARTIST_CANTA_MELODIE ADD CONSTRAINT ARTIST_SINGS_SONG_ARTIST_ID_FK FOREIGN KEY (artist_id) REFERENCES ARTIST(artist_id);

--SELECT CONSTRAINT_NAME
--FROM USER_CONSTRAINTS
--WHERE TABLE_NAME = 'MELODIE' AND CONSTRAINT_TYPE = 'R';


ALTER TABLE MELODIE DROP CONSTRAINT ARTIST_CANTA_MELODIE_FK;
ALTER TABLE MELODIE DROP CONSTRAINT MELODIE_ALBUM_FK;
--ALTER TABLE MELODIE DROP CONSTRAINT SONGS_IN_PLAYLIST_USER_SONG_ID_FK;

--ALTER TABLE MELODIE_ALBUM DROP CONSTRAINT SONGS_IN_PLAYLIST_USER_SONG_ID_FK;
--ALTER TABLE MELODIE ADD CONSTRAINT ARTIST_SINGS_SONG_SONG_ID_FK FOREIGN KEY (melodie_id) REFERENCES MELODIE(melodie_id);
--ALTER TABLE MELODIE ADD CONSTRAINT SONGS_IN_PLAYLIST_USER_SONG_ID_FK FOREIGN KEY (melodie_id) REFERENCES MELODIE(melodie_id);

select constraint_name
from all_constraints
where table_name = 'MELODIE_IN_PLAYLIST_UTILIZATOR';

ALTER TABLE UTILIZATOR_APRECIAZA_PLAYLIST DROP CONSTRAINT SYS_C008345;
ALTER TABLE UTILIZATOR_APRECIAZA_PLAYLIST DROP CONSTRAINT SYS_C008346;
ALTER TABLE UTILIZATOR_APRECIAZA_PLAYLIST DROP CONSTRAINT SYS_C008344;
ALTER TABLE UTILIZATOR_APRECIAZA_PLAYLIST ADD CONSTRAINT USER_LIKES_PLAYLIST_USER_ID_FK FOREIGN KEY (utilizator_id) REFERENCES UTILIZATOR(utilizator_id);


ALTER TABLE MELODIE_IN_PLAYLIST_UTILIZATOR DROP CONSTRAINT SYS_C008341;
ALTER TABLE MELODIE_IN_PLAYLIST_UTILIZATOR DROP CONSTRAINT SYS_C008342;
ALTER TABLE MELODIE_IN_PLAYLIST_UTILIZATOR DROP CONSTRAINT SYS_C008343;
ALTER TABLE MELODIE_IN_PLAYLIST_UTILIZATOR DROP CONSTRAINT SYS_C008340;
ALTER TABLE MELODIE_IN_PLAYLIST_UTILIZATOR ADD CONSTRAINT SONGS_IN_PLAYLIST_USER_SONG_ID_FK FOREIGN KEY (melodie_id) REFERENCES MELODIE(melodie_id);
ALTER TABLE MELODIE_IN_PLAYLIST_UTILIZATOR ADD CONSTRAINT SONGS_IN_PLAYLIST_USER_PLAYLIST_ID_FK FOREIGN KEY (playlist_id) REFERENCES PLAYLIST(playlist_id);
ALTER TABLE MELODIE_IN_PLAYLIST_UTILIZATOR ADD CONSTRAINT SONGS_IN_PLAYLIST_USER_USER_ID_FK FOREIGN KEY (utilizator_id) REFERENCES UTILIZATOR(utilizator_id);

SELECT a.gen, COUNT(DISTINCT ula.utilizator_id) AS nr_utilizatori
FROM ALBUM a
JOIN UTILIZATOR_APRECIAZA_ALBUM ula ON a.album_id = ula.album_id
GROUP BY a.gen;

select * from UTILIZATOR;

UPDATE ALBUM
SET pret = (
  SELECT AVG(pret)
  FROM ALBUM
  WHERE artist_id = (
    SELECT artist_id
    FROM ALBUM
    WHERE album_id = 3
  )
)
WHERE album_id = 3;
rollback;
select * from album;

select nume_utilizator, NVL(to_char(data_nastere,'DD-MON-YYYY'), 'Not provided') as data_nastere,
    decode(tara, 'NL', 'Netherlands', 'Other') as alias_tara
from utilizator
order by nume_utilizator desc;


select u.nume_utilizator, a.titlu
from utilizator u
join utilizator_apreciaza_album ula on u.utilizator_id=ula.utilizator_id
join album a on ula.album_id=a.album_id
where a.gen='Pop'
and u.nume_utilizator in(
    select nume_utilizator
    from utilizator
    where tara='US'
);

select * from utilizator;
commit;


--normalizare BCNF
--singura dependenta e ca nume_utilizator determina utilizator_id
CREATE TABLE NUME_UTILIZATORI (
    nume_utilizator varchar(50) unique,
    utilizator_id int,
    foreign key (utilizator_id) references utilizator(utilizator_id)
);
select * from utilizator;

--stergem coloana nume_utilizator din utilizatori
ALTER TABLE UTILIZATOR DROP COLUMN nume_utilizator;

INSERT INTO NUME_UTILIZATORI(nume_utilizator,utilizator_id)
values('mara133',1);
INSERT INTO NUME_UTILIZATORI(nume_utilizator,utilizator_id)
values('thelibrasavannah',2);
INSERT INTO NUME_UTILIZATORI(nume_utilizator,utilizator_id)
values('boatelcy',3);
INSERT INTO NUME_UTILIZATORI(nume_utilizator,utilizator_id)
values('Finalka',4);
INSERT INTO NUME_UTILIZATORI(nume_utilizator,utilizator_id)
values('Johnadbo',5);
INSERT INTO NUME_UTILIZATORI(nume_utilizator,utilizator_id)
values('Allotikri',6);
INSERT INTO NUME_UTILIZATORI(nume_utilizator,utilizator_id)
values('Myzgeo',7);
INSERT INTO NUME_UTILIZATORI(nume_utilizator,utilizator_id)
values('Pltoex',8);
INSERT INTO NUME_UTILIZATORI(nume_utilizator,utilizator_id)
values('Matweeknd',9);
INSERT INTO NUME_UTILIZATORI(nume_utilizator,utilizator_id)
values('Fletch04',10);
INSERT INTO NUME_UTILIZATORI(nume_utilizator,utilizator_id)
values('vestovlone',11);

select * from nume_utilizatori nu
join utilizator u on u.utilizator_id=nu.utilizator_id;

--denormalizare
ALTER TABLE UTILIZATOR ADD (nume_utilizator VARCHAR(50));
UPDATE UTILIZATOR
SET nume_utilizator =
(
    SELECT nume_utilizator
    FROM NUME_UTILIZATORI
    WHERE UTILIZATOR.utilizator_id = NUME_UTILIZATORI.utilizator_id
);

select * from utilizator;
select * from nume_utilizator;
commit;

drop table nume_utilizatori;
commit;

alter table melodie
modify data_lansare DATE NOT NULL;

alter table utilizator
modify tara varchar(2) not null;
alter table melodie_in_playlist_utilizator
modify data_adaugare date not null;

select * from all_tables;
SELECT 
  all_tab_columns.column_name,
  all_tab_columns.data_type,
  CASE 
    WHEN pk.column_name IS NOT NULL THEN 'PK'
    WHEN fk.column_name IS NOT NULL THEN 'FK'
    ELSE 'Neither' 
  END AS key_type
FROM 
  all_tab_columns
LEFT JOIN (
  SELECT 
    a.column_name
  FROM 
    all_cons_columns a
    INNER JOIN all_constraints c ON a.owner = c.owner AND a.constraint_name = c.constraint_name
  WHERE 
    c.constraint_type = 'P'
    AND c.table_name = 'YourTableName'
    --AND c.owner = 'YourSchemaName'
) pk ON all_tab_columns.column_name = pk.column_name
LEFT JOIN (
  SELECT 
    a.column_name
  FROM 
    all_cons_columns a
    INNER JOIN all_constraints c ON a.owner = c.owner AND a.constraint_name = c.constraint_name
  WHERE 
    c.constraint_type = 'R'
    AND c.table_name = 'YourTableName'
    --AND c.owner = 'YourSchemaName'
) fk ON all_tab_columns.column_name = fk.column_name
WHERE 
  all_tab_columns.table_name = 'YourTableName';
  --AND all_tab_columns.owner = 'YourSchemaName';

insert into artist(artist_id, nume, varsta, descriere)
values(11, 'Usher', 44, 'American R' || '&' || 'B singer');

select * from utilizator;
 insert into melodie(melodie_id, titlu, descriere, durata, data_lansare,album_id,artist_id)
 values(27, 'My Boo', '', 223, to_date('29-08-2004','dd-mm-yyyy'), null, 11);
 
--song
--artist
--album
--playlist
--utilizator
--episod
--podcast
--artist_lanseaza_Album
--artist-canta
--utilizator apreciaza album
--utilizator urmareste art
--mel in playlist
--utilizator apreciaza playlist
--istoric melodii
--podcast istoric
select * from podcast_istoric;

SELECT u.nume_utilizator, t.playlist_nr
FROM utilizator u
CROSS JOIN (
    SELECT utilizator_id, COUNT(*) as playlist_nr
    FROM utilizator_apreciaza_playlist
    GROUP BY utilizator_id
) t
WHERE u.utilizator_id = t.utilizator_id;

select * from utilizator_apreciaza_playlist;

WITH song_data AS (
  SELECT s.titlu, s.data_lansare,
    CASE
      WHEN s.data_lansare > SYSDATE THEN 'Upcoming'
      WHEN s.data_lansare = TRUNC(SYSDATE) THEN 'Released today'
      ELSE 'Released'
    END AS release_status
  FROM melodie s
)
SELECT SUBSTR(titlu, 1, 3) AS substring_titlu, TO_CHAR(data_lansare, 'DD-MON-YYYY') AS data_formatata, release_status
FROM song_data
WHERE UPPER(titlu) LIKE '%YOU%'
  AND EXTRACT(MONTH FROM data_lansare) = 11;

SELECT * FROM MELODIE
where UPPER(titlu) LIKE '%YOU%';
UPDATE ALBUM
SET pret = (
  SELECT AVG(pret)
  FROM ALBUM
  WHERE artist_id = (
    SELECT artist_id
    FROM ALBUM
    WHERE album_id = 3
  )
)
WHERE album_id = 3;
rollback;
select * from album;
UPDATE MELODIE
SET data_lansare = (
  SELECT MAX(data_lansare)
  FROM MELODIE
  WHERE artist_id = (
    SELECT artist_id
    FROM MELODIE
    WHERE melodie_id = 1
  )
)
WHERE melodie_id = 1;


rollback;
select * from album;

UPDATE UTILIZATOR
SET nume_utilizator= 'mara1333'
WHERE utilizator_id = (
  SELECT utilizator_id
  FROM (
    SELECT utilizator_id
    FROM UTILIZATOR_APRECIAZA_ALBUM
    GROUP BY utilizator_id
    ORDER BY COUNT(*) DESC
  )
  WHERE ROWNUM = 1
);

DELETE FROM MELODIE_IN_PLAYLIST_UTILIZATOR
WHERE playlist_id = (
  SELECT playlist_id
  FROM (
    SELECT playlist_id, COUNT(*) AS song_count
    FROM MELODIE_IN_PLAYLIST_UTILIZATOR
    GROUP BY playlist_id
    ORDER BY song_count
    FETCH FIRST 1 ROW ONLY
  ) subquery
);

rollback;

SELECT a.gen, COUNT(DISTINCT ula.utilizator_id) AS nr_utilizatori
FROM ALBUM a
JOIN UTILIZATOR_APRECIAZA_ALBUM ula ON a.album_id = ula.album_id
GROUP BY a.gen;

SELECT a.gen, COUNT(DISTINCT ula.utilizator_id) AS nr_utilizatori
FROM ALBUM a
JOIN UTILIZATOR_APRECIAZA_ALBUM ula ON a.album_id = ula.album_id
GROUP BY a.gen
HAVING COUNT(DISTINCT ula.utilizator_id) > 1;


SELECT s.titlu AS nume_melodie, s.melodie_id, a.titlu AS album_titlu, ar.nume AS nume_artist
FROM MELODIE s
LEFT JOIN ALBUM a ON s.album_id = a.album_id
LEFT JOIN ARTIST ar ON s.artist_id = ar.artist_id
LEFT JOIN (
  SELECT DISTINCT melodie_id
  FROM MELODIE_IN_PLAYLIST_UTILIZATOR
) sp ON s.melodie_id = sp.melodie_id
WHERE sp.melodie_id IS NULL;

SELECT p.playlist_id, p.titlu
FROM PLAYLIST p
WHERE p.playlist_id IN (
  SELECT sp.playlist_id
  FROM MELODIE_IN_PLAYLIST_UTILIZATOR sp
  GROUP BY sp.playlist_id
  HAVING COUNT(sp.melodie_id) > 10
);

SELECT s.titlu AS nume_cantec, COUNT(sh.melodie_id) AS nr_ascultari
FROM melodie s
LEFT JOIN istoric_melodii sh ON s.melodie_id = sh.melodie_id
GROUP BY s.melodie_id, s.titlu
ORDER BY nr_ascultari DESC
FETCH FIRST 5 ROWS ONLY;

SELECT p.titlu AS playlist_nume, COUNT(s.melodie_id) AS nr_mel
FROM PLAYLIST p
JOIN MELODIE_IN_PLAYLIST_UTILIZATOR spu ON p.playlist_id = spu.playlist_id
JOIN MELODIE s ON spu.melodie_id = s.melodie_id
WHERE spu.utilizator_id = 1
GROUP BY p.titlu;

SELECT p.titlu AS playlist_nume, COUNT(*) AS nr_mel
FROM PLAYLIST p
JOIN MELODIE_IN_PLAYLIST_UTILIZATOR spu ON p.playlist_id = spu.playlist_id
WHERE spu.utilizator_id = :utilizator_id
GROUP BY p.titlu;

select * from artist;
update album
set gen='R'||'&'||'B'
where album_id=7 or album_id = 8 or album_id = 9;

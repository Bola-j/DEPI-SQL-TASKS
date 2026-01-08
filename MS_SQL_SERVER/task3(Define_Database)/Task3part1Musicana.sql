create database Musicana;




create table Musician(
Musician_ID int Primary key identity(10000,1),
Musician_name nvarchar(30) not null,
city nvarchar(20) not null,
street nvarchar(20) not null
);

create table Album(
AlbumIdentifier int Primary key identity(20000,1),
Title nvarchar(30) not null,
CopyRightsDate date not null,
Musician_ID int references dbo.Musician(Musician_ID)
);


create table Song(
SongTitle nvarchar(30) Primary key,
Author nvarchar(30) not null,
AlbumIdentifier int references dbo.Album(AlbumIdentifier)
);

create table Instrument(
InstrumentName nvarchar(10) Primary key,
Musical_Key nvarchar(30) not null
);


create table MusicianPlayInstrument(
Musician_ID int references dbo.Musician(Musician_ID),
InstrumentName nvarchar(10) references dbo.Instrument(InstrumentName),
primary key(Musician_ID , InstrumentName)
);



create table MusicianPerformSong(
Musician_ID int references dbo.Musician(Musician_ID),
SongTitle nvarchar(30) references dbo.Song(SongTitle),

primary key(Musician_ID , SongTitle)
);


INSERT INTO Musician (Musician_name, city, street) VALUES
('John Mayer', 'Los Angeles', 'Sunset Blvd'),
('Adele Laurie', 'London', 'Baker Street'),
('Carlos Santana', 'San Francisco', 'Mission St'),
('Taylor Swift', 'Nashville', 'Music Row'),
('Hans Zimmer', 'Berlin', 'Tiergarten Str'),
('Bruno Mars', 'Honolulu', 'Kalakaua Ave'),
('Ed Sheeran', 'Manchester', 'Deansgate'),
('Lindsey Stirling', 'Phoenix', 'Camelback Rd'),
('The Weeknd', 'Toronto', 'Queen St'),
('Billie Eilish', 'Los Angeles', 'Highland Ave');



INSERT INTO Album (Title, CopyRightsDate, Musician_ID) VALUES
('Continuum', '2006-09-12', 10000),
('21', '2011-01-24', 10001),
('Supernatural', '1999-06-15', 10002),
('Folklore', '2020-07-24', 10003),
('Inception OST', '2010-07-16', 10004),
('Unorthodox Jukebox', '2012-12-06', 10005),
('Divide', '2017-03-03', 10006),
('Shatter Me', '2014-04-29', 10007),
('After Hours', '2020-03-20', 10008),
('Happier Than Ever', '2021-07-30', 10009);


INSERT INTO Song (SongTitle, Author, AlbumIdentifier) VALUES
('Gravity', 'John Mayer', 20000),
('Rolling in the Deep', 'Adele Laurie', 20001),
('Smooth', 'Carlos Santana', 20002),
('Cardigan', 'Taylor Swift', 20003),
('Time', 'Hans Zimmer', 20004),
('Locked Out of Heaven', 'Bruno Mars', 20005),
('Shape of You', 'Ed Sheeran', 20006),
('Shatter Me', 'Lindsey Stirling', 20007),
('Blinding Lights', 'The Weeknd', 20008),
('NDA', 'Billie Eilish', 20009);



INSERT INTO Instrument (InstrumentName, Musical_Key) VALUES
('Guitar', 'C Major'),
('Piano', 'A Minor'),
('Drums', 'No Key'),
('Violin', 'G Major'),
('Bass', 'E Minor'),
('Flute', 'D Major'),
('Cello', 'F Major'),
('Trumpet', 'Bb Major'),
('Saxophone', 'Eb Major'),
('Harp', 'C Major');



INSERT INTO MusicianPlayInstrument (Musician_ID, InstrumentName) VALUES
(10000, 'Guitar'),
(10001, 'Piano'),
(10002, 'Guitar'),
(10002, 'Drums'),
(10003, 'Piano'),
(10004, 'Violin'),
(10005, 'Drums'),
(10006, 'Guitar'),
(10007, 'Violin'),
(10009, 'Piano');


INSERT INTO MusicianPerformSong (Musician_ID, SongTitle) VALUES
(10000, 'Gravity'),
(10001, 'Rolling in the Deep'),
(10002, 'Smooth'),
(10003, 'Cardigan'),
(10004, 'Time'),
(10005, 'Locked Out of Heaven'),
(10006, 'Shape of You'),
(10007, 'Shatter Me'),
(10008, 'Blinding Lights'),
(10009, 'NDA');

SELECT * FROM Musician;


SELECT Musician_name, city, street
FROM Musician
WHERE city = 'Los Angeles';


SELECT a.AlbumIdentifier, a.Title, m.Musician_name
FROM Album a
JOIN Musician m ON a.Musician_ID = m.Musician_ID;


SELECT SongTitle, Author
FROM Song
WHERE AlbumIdentifier = 20000;  -- Example album ID




SELECT m.Musician_name, i.InstrumentName, i.Musical_Key
FROM MusicianPlayInstrument mpi
JOIN Musician m ON mpi.Musician_ID = m.Musician_ID
JOIN Instrument i ON mpi.InstrumentName = i.InstrumentName;

SELECT m.Musician_name
FROM MusicianPlayInstrument mpi
JOIN Musician m ON mpi.Musician_ID = m.Musician_ID
WHERE mpi.InstrumentName = 'Piano';



SELECT m.Musician_name, s.SongTitle
FROM MusicianPerformSong mps
JOIN Musician m ON mps.Musician_ID = m.Musician_ID
JOIN Song s ON mps.SongTitle = s.SongTitle
WHERE s.SongTitle = 'Gravity';


SELECT *
FROM MusicianPlayInstrument mpi
join Musician m on m.Musician_ID = mpi.Musician_ID
join MusicianPerformSong mps on mps.Musician_ID = mpi.Musician_ID
where InstrumentName = 'Guitar';

SELECT m.Musician_name, s.SongTitle
FROM MusicianPerformSong mps
JOIN Musician m ON mps.Musician_ID = m.Musician_ID
JOIN Song s ON mps.SongTitle = s.SongTitle;


SELECT *
FROM MusicianPlayInstrument
WHERE (Musician_ID = 10000 AND InstrumentName = 'Guitar')
   OR (Musician_ID = 10003 AND InstrumentName = 'Piano');

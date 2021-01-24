


select * from film
select * from oyuncu
select * from tur
select * from yonetmen
select * from karakter

insert into film values ('The Lord of the Rings: The Fellowship of the Ring',2001,887,1)
insert into karakter values ('Frodo','Baggins')
update Karakter set Adi='Aragorn', Soyadi=null where Id=2
update karakter set Adi='Frodo' , Soyadi='Baggins' where Id=1
delete from film 
delete from karakter

insert into film values ('The Lord of the Rings: The Fellowship of the Ring',2001,887)
insert into film values ('harry potter and the prisoner of azkaban',2004,796)
insert into film values ('Star Wars: The Rise of Skywalker',2019,1074)

insert into oyuncu values ('Elijah','Wood','1981-01-28')
insert into oyuncu values ('Ian','McKellen','1939-05-25')
insert into oyuncu values ('Orlando','Bloom','1977-01-13')
insert into oyuncu values ('Daniel','Radcliffe','1989-07-23')
insert into oyuncu values ('Emma','Watson','1990-04-15')
insert into oyuncu values ('Rupert','Grint','1988-08-24')
insert into oyuncu values ('Daisy','Ridley','1992-04-10')
insert into oyuncu values ('Oscar','Isaac','1979-03-09')
insert into oyuncu values ('Mark','Hamill','1951-09-25')
begin tran
insert into tur values ('Aksiyon')
rollback tran
insert into tur values ('Bilimkurgu')
insert into tur values ('Gerilim')
insert into tur values ('Macera')
insert into tur values ('Fantastik')

insert into yonetmen values ('Peter','Jackson')
insert into yonetmen values ('Alfonso','Cuarón')
insert into yonetmen values ('J.J.','Abrams')
insert into yonetmen values ('Çaðan','Irmak')
insert into yonetmen values ('Quentin','Tarantino')

DBCC CHECKIDENT ('Karakter', RESEED ,0 )
insert into karakter values ('Frodo Baggins')
insert into karakter values ('Gandalf')
insert into karakter values ('Legolas')
insert into karakter values ('HarryPotter')
insert into karakter values ('HermioneGranger')
insert into karakter values ('RonWeasley')
insert into karakter values ('Rey')
insert into karakter values ('PoeDameron')
insert into karakter values ('LukeSkywalker')

select * from oyuncu
--select * from karakter

select * from Oyuncu
select * from film
select * from filmoyuncukarakter
select * from karakter

insert into FilmOyuncuKarakter values (8,1,1)
insert into FilmOyuncuKarakter values (8,2,2)
insert into FilmOyuncuKarakter values (8,3,3)
insert into FilmOyuncuKarakter values (9,4,5)
insert into FilmOyuncuKarakter values (9,5,6)
insert into FilmOyuncuKarakter values (9,8,4)
insert into FilmOyuncuKarakter values (10,6,7)
insert into FilmOyuncuKarakter values (10,7,8)
insert into FilmOyuncuKarakter values (10,9,9)

insert into FilmTur values (8,5)
insert into FilmTur values (8,4)
insert into FilmTur values (9,5)
insert into FilmTur values (9,1)
insert into FilmTur values (10,2)
insert into FilmTur values (10,3)

select * from filmyonetmen
select * from film
select * from yonetmen

insert into FilmYonetmen values(8,1)
insert into FilmYonetmen values(9,2)
insert into FilmYonetmen values(10,3)

update film set Adi='Harry Potter and the Prisoner of Azkaban' where Id=9

select f.Adi,f.Gisesi from film f 

delete from karakter

create database FÝLMLER
go
create table Karakter(
Id int not null identity(1,1) primary key,
AdiSoyadi varchar(100)
)

select * from karakter
select * from Oyuncu

select * from Karakter where adisoyadi like '%ter'

select count(*) from oyuncu

select * from yonetmen order by adi desc

select * from film where Id >= 9

select * from karakter where Id>5 order by Id desc

select * from Tur where Adi is not null


create view vw_Filmler
as
select f.Adi as [Film Adý], f.YapimYili as [Yapým Yýlý], f.Gisesi as [Giþesi], t.Adi as [Türü], k.AdiSoyadi as [Ana Karakterler],
o.Adi as [Baþrol Adi],o.Soyadi as [Baþrol Soyadi],o.DogumTarihi as [Baþrol Doðum Tarihi],y.Adi as [Yönetmen Adi],y.Soyadi as [Yönetmen Soyadi]
from film f inner join FilmOyuncuKarakter fok on fok.FilmId=f.Id
inner join oyuncu o on fok.OyuncuId=o.Id
inner join karakter k on fok.KarakterId=k.Id
inner join FilmYonetmen fy on fy.FilmId=f.Id
inner join yonetmen y on fy.YonetmenId=y.Id
inner join FilmTur ft on ft.FilmId=f.Id
inner join tur t on ft.TurId=t.Id

select * from vw_Filmler where Türü='bilimkurgu'
select * from vw_Filmler where Türü='fantastik'

select sum(distinct giþesi) from vw_Filmler

select * from vw_filmler where Giþesi=(select max(giþesi) from vw_Filmler)

select distinct Türü,[Film Adý] from vw_filmler order by [Film Adý]

select oyuncu.Adi+' '+oyuncu.Soyadi as Aktör,Film.Adi as [Film Adi]
from film inner join FilmOyuncuKarakter on film.Id=FilmOyuncuKarakter.FilmId
inner join oyuncu on FilmOyuncuKarakter.OyuncuId=Oyuncu.Id
where oyuncu.adi like 'd%' 

select y.Adi+' '+y.Soyadi as [Yönetmen],f.Adi [Film Adý],f.Gisesi [Giþesi],f.YapimYili as [Çýkýþ Tarihi]
from yonetmen as y inner join FilmYonetmen as fy on fy.YonetmenId=y.Id
inner join film as f on fy.FilmId=f.Id

select y.Adi+' '+y.Soyadi as [Yönetmen],f.Adi [Film Adý],f.Gisesi [Giþesi],f.YapimYili as [Çýkýþ Tarihi]
from yonetmen as y inner join FilmYonetmen as fy on fy.YonetmenId=y.Id
inner join film as f on fy.FilmId=f.Id
where y.Adi='Peter'

select f.Id as FilmId,f.Adi as FilmAdý, o.Id as OyuncuId, o.Adi+' '+o.Soyadi as OyuncuAdýSoyadý
from film as f full outer join FilmOyuncuKarakter as fok on f.Id=fok.FilmId
inner join oyuncu as o on o.Id=fok.OyuncuId

select f.Id as FilmId,f.Adi as FilmAdý,y.Id as YönetmenId,y.Adi+' '+y.soyadi as YönetmenAdý
from film as f full join FilmYonetmen fy on f.Id=fy.FilmId
full join Yonetmen as y on y.Id=fy.YonetmenId

select f.Adi as [Film Adý],y.Adi as [Yönetmen Adý], o.Adi+' '+o.Soyadi as [Oyuncu] from film f 
inner join FilmOyuncuKarakter fok on f.Id=fok.FilmId
inner join oyuncu o on o.Id=fok.OyuncuId
inner join FilmYonetmen fy on fy.FilmId=f.Id
inner join yonetmen y on fy.YonetmenId=y.Id
where f.Id=10

select count(o.Adi) from film f 
inner join FilmOyuncuKarakter fok on f.Id=fok.FilmId
inner join oyuncu o on o.Id=fok.OyuncuId
where f.Id=10

select datediff(year,max(o.DogumTarihi),min(o.DogumTarihi)) from film f 
inner join FilmOyuncuKarakter fok on f.Id=fok.FilmId
inner join oyuncu o on o.Id=fok.OyuncuId
where f.Id=10

select f.Adi as [Film Adý], o.Adi+' '+o.Soyadi as [Oyuncu], convert(varchar,o.DogumTarihi,104) as [Doðum Tarihi] from film f 
inner join FilmOyuncuKarakter fok on f.Id=fok.FilmId
inner join oyuncu o on o.Id=fok.OyuncuId

select f.Adi as [Film Adý], o.Adi+' '+o.Soyadi as [Oyuncu], o.DogumTarihi [Doðum Tarihi] from film f 
inner join FilmOyuncuKarakter fok on f.Id=fok.FilmId
inner join oyuncu o on o.Id=fok.OyuncuId
where o.DogumTarihi >= '1981'

select f.Adi as [Film Adý], o.Adi+' '+o.Soyadi as [Oyuncu], convert(varchar,o.DogumTarihi,104)[Doðum Tarihi] from film f 
inner join FilmOyuncuKarakter fok on f.Id=fok.FilmId
inner join oyuncu o on o.Id=fok.OyuncuId
where o.DogumTarihi<='1981'


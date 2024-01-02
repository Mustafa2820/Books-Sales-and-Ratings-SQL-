SELECT * FROM my.books;

-- Q-1  Find the top 5 books with the highest average ratings.

SELECT *
FROM books
ORDER BY Book_average_rating DESC
LIMIT 5;

-- Q-2  Count the number of books in each genre.

select count(*) , genre from books
group by genre;

-- Q-3  Calculate the total gross sales and publisher revenue.

select sum(gross_sales) as total_gross_sales, SUM(publisher_revenue) as total_publisher_revenue from books ;

-- Q-4  Calculate the average number of ratings for books in each language.

select language_code , avg(book_average_rating) as average_rating from books
group by language_code;

-- Q-5 Identify books with the highest units sold.

select *  from books 
order by units_sold desc 
limit 1;

--  Q-6 Calculate the total number of books and total units sold for each genre.

SELECT genre, COUNT(*) as total_books, SUM(units_sold) as total_units_sold
FROM books
GROUP BY genre;

--  Q-7  Retrieve the names of all authors in the dataset.

 select distinct Author from books ;
 
-- Q-8  Calculate the average book rating for each author.

SELECT Author, AVG(Book_average_rating) as avg_author_rating
FROM books
GROUP BY Author;

--  Q-9  List the top 5 authors with the highest average sales rank.

select author , avg(sales_rank) as high_average_sales_rank from books 
group by Author
order by high_average_sales_rank desc 
limit 5;

--  Q-10  Find the total revenue for each genre, considering both gross sales and publisher revenue.

select genre , sum( gross_sales + publisher_revenue ) as total_genre_revenu from books
group by genre;
 
--  Q-11  Calculate the percentage of total sales contributed by each language.
 
 select   language_code , sum(gross_sales)/ (select sum(gross_sales) from books) * 100 as sales_percentage from books 
group by language_code;

--  Q-12 List the top 10 languages with the highest total units sold.
 
SELECT language_code, SUM(units_sold) as total_units_sold
FROM books
GROUP BY language_code
ORDER BY total_units_sold DESC
LIMIT 3;

--  Q-13  Calculate the average sales rank for books in each genre.
 
select genre , avg(sales_rank) as average_sales_rank from books
group by genre;

--  Q-14  Find authors who have written books in more than one language.
 
select author from books
group by author 
having count(  distinct language_code > 1 ) ;

-- Q-15  Calculate the total sales revenue for each author.

select  distinct( author) , sum(gross_sales) as total_sales_revenue from books
group by Author ;
 
-- Q-16  Identify books with a higher-than-average rating in their respective genres.
 
select * from books 
where Book_average_rating > (select avg(Book_average_rating) from books where genre=books.genre) ;

-- Q-17  Rank authors based on total gross sales revenue:

SELECT Author, SUM(gross_sales) AS total_gross_sales
FROM books
GROUP BY Author
ORDER BY total_gross_sales DESC;

-- Q-18  List the books with their authors and average ratings, but only include books with ratings higher than the average rating of their respective authors.

select b.book_name , b.Author , b.book_average_rating from books b
join (
      select Author , avg( book_average_rating)  as avg_author_rating
      from books 
      group by Author
      ) a on b.Author=a.Author
      where b.book_average_rating > a.avg_author_rating ;

--  Q-19  Calculate the total revenue for each genre, considering both gross sales and  publisher revenue, and include the highest-grossing book for each genre.
 
 SELECT genre, SUM(gross_sales + publisher_revenue) as total_revenu from books
 group by genre ;
 
-- Q-20 Find the books with the highest sales rank in each genre.
 
 SELECT genre, Book_Name, sales_rank
FROM books b
WHERE sales_rank = (
    SELECT MAX(sales_rank)
    FROM books
    WHERE genre = b.genre
);


-- Q-21  Identify authors who have written books with a higher average rating than the overall average rating of all books.

SELECT DISTINCT Author , Book_average_rating 
FROM books b
WHERE (SELECT AVG(Book_average_rating) FROM books) <
      (SELECT AVG(Book_average_rating) FROM books a WHERE a.Author = b.Author);

-- Q-22  List the books with ratings above the average rating of books written by authors who have books in multiple genres.

select * from books b
where Book_average_rating > ( select avg(Book_average_rating) from books a
 where a.Author=b.Author
 group by a.Author 
 HAVING COUNT(DISTINCT a.genre) > 1) ;
 
--  Q-23  Retrieve the authors who have written books in both English (language_code = 'EN') and Spanish (language_code = 'ES').

select distinct author, language_code from books
where language_code in ('EN' & 'ES' )
GROUP BY Author
HAVING COUNT(DISTINCT language_code) = 2;

--  Q-24 List the books with the highest total revenue (gross sales + publisher revenue) in each language

SELECT language_code, Book_Name, (gross_sales + publisher_revenue) as total_revenue
FROM books b
WHERE (language_code, (gross_sales + publisher_revenue)) = (
    SELECT language_code, MAX(gross_sales + publisher_revenue) as max_revenue
    FROM books a
    WHERE a.language_code = b.language_code
    GROUP BY language_code
);  




 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
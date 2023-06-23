-- Normalization

/*
Normalization is the process of organizing data in a database. 
This includes creating tables and establishing relationships between those
 tables according to rules designed both to protect 
the data and to make the database more flexible by eliminating redundancy and inconsistent dependency.store
-- Software Development Life Cycle
-- ---- Waterfall model--Requirements gathering phase
--- Analysis and Design
-- Coding /Development Phase
-- Testing 
-- Deployment
-- Maven movies use case
1. Can have multiple stores
2. A store can have Multiple Staff
3. A store can have multiple Film
4. A film can have multiple actors
5. A actor can have multiple awards
6. A film can have multiple categories
7. Inventory holds the information of each store, film 
8. Film can be rented to customers, based on location
9. A customer can have One address
10. Payment information of the rented movie by the customer is stored.



*/


-- Cardinality -- one to one, One to Many, many to many, many to one

-- 1 NF -- each attribute should have an atomic value, Remove repeating groups and create a new table, Identify -- Identifiers or place Identifier

-- 2NF-- states that , thre cannot be any Partial Dependancy i.e., ALl the non-prime attributes 
-- should be dependant on the prime attribute

-- 3nf-- Should satisfy 2nf and there should be no transitive functional Dependanc


select * from customer

-- tables A(ActorID) and B(ActorID) are said to be in strong relation only when the Prime key of B is similar to Prime --key of A

-- tables A() and B() are said to be in weak relation only when the B has its own prime key and a candidate key from table A

-- what is Index

-- Clustered Index, Non-Clustered Index
-- select * from film where film_id=20



/*
An index is an on-disk structure associated with a table or view that speeds retrieval of rows from the table or view. An index contains keys built from one or more columns in the table or view. These keys are stored in a structure (B-tree) that enables SQL Server to find the row or rows associated with the key values quickly and efficiently.

Clustered

Clustered indexes sort and store the data rows in the table or view based on their key values. These are the columns included in the index definition. There can be only one clustered index per table, because the data rows themselves can be stored in only one order.  
The only time the data rows in a table are stored in sorted order is when the table contains a clustered index. When a table has a clustered index, the table is called a clustered table. If a table has no clustered index, its data rows are stored in an unordered structure called a heap.
Nonclustered

Nonclustered indexes have a structure separate from the data rows. A nonclustered index contains the nonclustered index key values and each key value entry has a pointer to the data row that contains the key value.

The pointer from an index row in a nonclustered index to a data row is called a row locator. The structure of the row locator depends on whether the data pages are stored in a heap or a clustered table. For a heap, a row locator is a pointer to the row. For a clustered table, the row locator is the clustered index key.

You can add nonkey columns to the leaf level of the nonclustered index to by-pass existing index key limits, and execute fully covered, indexed, queries. For more information, see Create indexes with included columns. For details about index key limits see Maximum capacity specifications for SQL Server.

Both clustered and nonclustered indexes 
*/




drop table customer_info;
Create table Customer_Info(
Customer_ID INT,
Customer_Name VARCHAR(30) ,
Customer_Code Varchar(20),
Gender varchar(1),
Age INT NOT NULL
)
;
Alter Table Customer_Info ADD PRIMARY KEY(Customer_ID, Customer_Name);

Create INDEX IX_CUstomer_Name ON Customer_Info(Customer_Name);
Create INDEX IX_CUstomer_Name_Age ON Customer_Info(Customer_Name,Gender);
Create INDEX IX_CUstomer_Name_Age_ID ON Customer_Info(Customer_ID,Customer_Name,Gender);

Drop Index IX_CUstomer_Name_Age_ID ON Customer_INFO;

SHOW INDEXes FROM  Customer_Info;


select * from Film F INNER JOIn film_actor FA on F.Film_ID=FA.FIlm_ID;

DROP PROCEDURE IF EXISTS P_Film_Details;
delimiter $$
CREATE Procedure P_Film_Details(actorID int)
BEGIN
	Select F.Title,A.First_Name  from film_actor FA
    INNER JOIN Film F ON F.FIlm_ID=FA.Film_ID
    INNER JOIN Actor A ON A.Actor_ID=FA.Actor_ID
    where A.actor_ID=actorID
    ;
    
    select A.First_Name,IFNULL(Awards,'No awards') Awards  from Actor A LEFT join actor_award AW
    ON A.Actor_ID=AW.actor_id where A.actor_ID=actorID;
    

END $$
delimiter ;

Call P_Film_Details(15);
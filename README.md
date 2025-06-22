# SQL Bootcamp s21

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-blue)
![Level](https://img.shields.io/badge/Level-Intensive-red)

**SQL Bootcamp s21** is an intensive course on working with relational databases, covering all aspects of SQL: from basic queries to advanced concepts of data warehousing and transactions.

---

## 🗂️ Project Structure

### **Day 00: SQL Basics**

* 9 exercises on basic SQL syntax  
* Constructs: `SELECT`, `WHERE`, `ORDER BY`, `CASE`, subqueries  
* Working with filtering, sorting, and data transformation

---

### **Day 01: Sets and JOIN**

* 11 exercises on set operations  
* Constructs: `UNION`, `EXCEPT`, `INTERSECT`, various types of `JOIN`  
* Comparison of `IN` vs `EXISTS` approaches

---

### **Day 02: Advanced JOIN**

* 10 exercises on deep JOIN logic  
* Types of `JOIN`: `LEFT`, `RIGHT`, `FULL`, `CROSS`  
* Using `CTE (Common Table Expressions)`  
* Solving complex analytical tasks

---

### **Day 03: Data Manipulation**

* 13 exercises on DML operations  
* Commands: `INSERT`, `UPDATE`, `DELETE`  
* Dynamic ID generation  
* Bulk data operations

---

### **Day 04: Views**

* 8 exercises on virtual and materialized views  
* Creating and managing `VIEW` and `MATERIALIZED VIEW`  
* Time series generation  
* Symmetric difference of sets

---

### **Day 05: Optimization**

* 6 exercises on indexes  
* Index types: B-Tree, functional, multi-column  
* Performance analysis with `EXPLAIN ANALYZE`  
* Unique and partial indexes

---

### **Day 06: Database Design**

* 6 exercises on database design  
* Creating a discount table  
* Data integrity constraints  
* Automating key generation  
* Personalized discount system

---

### **Day 07: Analytics**

* 9 exercises on data aggregation  
* Functions: `COUNT`, `AVG`, `MAX`, `MIN`, `ROUND`  
* Grouping with `GROUP BY` and `HAVING`  
* Advanced analytical queries

---

### **Day 08: Transactions**

* 8 exercises on transaction isolation  
* Isolation levels: `READ COMMITTED`, `REPEATABLE READ`, `SERIALIZABLE`  
* Reproducing anomalies: lost updates, dirty reads, phantoms  
* Handling deadlocks

---

### **Day 09: Functions and Triggers**

* 9 exercises on functional blocks  
* Creating triggers for data auditing  
* SQL and PL/pgSQL functions  
* Implementing algorithms (Fibonacci, finding minimum)

---

## 🧑‍🤝‍🧑 Group Assignments

### SQL_Team_00: **Traveling Salesman**

* Solving TSP using recursive queries

---

### SQL_Team_00: **Data Warehousing**

* ETL processes, working with temporal data

---

## ⚙️ Technologies

* PostgreSQL 15+ — database management system  
* ANSI SQL — standardized query language  
* psql / pgAdmin — tools for working with DB  
* Window functions — for analytical queries  
* Recursive `CTE` — for hierarchical data processing

---

## 🚀 Getting Started

1. Install PostgreSQL  
2. Restore the database structure:

```bash
psql -U postgres -f materials/model.sql
```

3. Complete the tasks by day:

```bash
# Example for Day 00
cd ex00
psql -U postgres -f day00_ex00.sql
```

4. Use the following for performance analysis:

```sql
EXPLAIN ANALYZE
-- Your query
```

---

## 📌 Highlights

* Sequential task completion  
* Real-world pizza shop data model  
* Restrictions on using certain constructs  
* Practice with different solution approaches  
* Working with mutable data (DML)  
* Initialization scripts for each day

> **Note**: Some exercises modify data — it's recommended to back up before performing DML operations.

---

![schema](misc/images/schema.png)

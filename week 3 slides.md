# Week 3 – Data Modeling for E-commerce (60-Minute Session)


---


## Lecture 3.1 – Entities & Relationships (Conceptual)
**Time: 25 minutes**


### Topics
- **Introduction to Data Modeling**
- Why data modeling is essential for e-commerce.
- Real-world analogy: supermarket layout vs. database schema.


- **Core Entities in E-commerce**
- **Products**: attributes (title, price, category, stock, discount).
- **Users**: attributes (name, email, password, roles).
- **Orders**: how customers and products connect.
- **Payments & Shipping**: storing financial & logistical info.


- **Relationships**
- One-to-many (1–N): One user can place many orders.
- Many-to-many (M–N): Products appear in multiple orders.
- Use of junction/bridge tables (OrderDetails).


- **Schema Best Practices**
- Avoid redundancy (normalization).
- Keep indexes for speed.
- Use foreign keys for integrity.


---


## Discussion Questions (5 minutes)
- What happens if we don’t normalize a product catalog?
- Why separate “Orders” and “OrderDetails”?
- Should we store passwords in plain text? (Hint: NEVER)


---


## Lecture 3.2 – ERD Workshop (Hands-on)
**Time: 25 minutes**


### Step-by-Step Walkthrough
1. **Identify entities**
Example for an online bookstore: Books, Authors, Customers, Orders, Payments.
2. **Define attributes**
For “Book”: ISBN, Title, AuthorId, Price, Stock, CategoryId.
3. **Establish relationships**
- Book ↔ Author (M–N).
- Customer ↔ Order (1–N).
- Order ↔ Book (M–N, resolved by OrderDetails).
4. **Normalization exercise**
Split “Customer Address” into a separate table (avoid repeating addresses per order).
5. **Demo with dbdiagram.io**
Instructor shows how to drag/drop entities and export SQL.


---


## In-Class Group Activity (Hands-on)
**Time: 15 minutes**


- Form groups of 3–4 students.
- Choose your Week 2 business idea.
- List **at least 5 core entities**.
- Draw ERD on dbdiagram.io or paper.
- Share with another group and explain relationships.


---


## Deliverables (Homework)
- **ERD diagram**: export image or PDF.
- **Short write-up (1 page)**: explain entity choices and relationships.
- Due: Next week (Week 4).


---


## Key Takeaways
- A well-structured database = smoother development later.
- Entities = business objects, relationships = how they interact.
- ERDs are the **blueprints** for your MSSQL database in Week 4.
- Your business idea will come alive only if the data layer is solid.


---


⏱️ **Total Duration: 60 minutes**
- 25 min lecture (concepts)
- 5 min class discussion
- 25 min ERD demo/workshop
- 15 min group activity (overlaps with workshop time)
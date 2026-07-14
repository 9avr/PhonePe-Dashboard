# PhonePe-Dashboard
### 1.	Project Title
 PhonePe Transactions Insights Dashboard

### 2.Purpose
The PhonePe Transactions Insights Dashboard is a visually engaging and analytical Power BI report designed to help users analyse over 300000 transactions of over 100000 users accounting for more than 3.5 Bn in valuation. The dashboard focuses on highlighting Age segment contribution, variation in transaction on weekdays and over months, services which account for maximum transactions,Top 5 users in each category. 

### 3.Tech Stack
The dashboard was built using the following tools and technologies:<br>
•	📊 Power BI Desktop – Main data visualization platform used for report creation.<br>
•	📂 Power Query – Data transformation and cleaning layer for reshaping and preparing the data.<br>
•	🧠 DAX (Data Analysis Expressions) – Used for calculated measures, dynamic visuals, and conditional logic.<br>
•	📝 Data Modeling – Relationships established among tables (Transactions, User details, Date) to enable cross-filtering and aggregation.<br>
•	📁 File Format – .pbix for development and .png for dashboard previews.

### 4.	Data Source
Source: https://www.kaggle.com 
The dataset contains PhonePE transaction records for year 2024 including:

         Transaction_ID

         Amount

         user_ID 

         Service 

         Service Type 

         Payment_Status 

         Reason 

         Date

         Name 

         Age

         Join_Date

### 5.	Business quetions answered
        1.How many transactions were done in a year?
        
        2.What is the total value of the transactions?
        
        3.How many unique users are using the platform?
        
        4.Trends, growth, decline, or recurring patterns in transactions and their value over different months?
        
        5.Age segment contribution?
        
        6.Which service type accounts for maximum and minimum transactions?
        
        7.Which service type contributed maximum and minimum revenue?
        
        8.Who are top 5 users and what transactions they have done?
        
        9.Intensity of transactions over weekdays?
        
        10.Success rate of transactions?



### 6.	Features / Highlights
Key KPIs 

        Total Transactions: 300000	

        Total value:3.47 Bn

        Unique Users: 101K

        Success Rate: 96%


Month and Status Filter Panel

        An interactive slicer lets users filter all visuals by selected month and status of transaction.

Transactions over time (Dual Line Chart)

        Two line visuals side by side: one for total transactions, another for transaction value.

Age segment contributuion (Donut chart)

        Displays the contributuion of different age groups in total transaction
Service type bar chart 

        Displays which services contributed to maximum transaction value

Top 5 Users (Column Chart)

        Gives information about top 5 most contributing users

Transaction by weekdays (Line  Chart)

       Shows intensity of transactions distributed over weekdays.




### 6.	Screenshots / Demos

 ![Dashboard Preview](https://github.com/9avr/PhonePe-Dashboard/blob/main/PhonePe%20dashboard%20screenshot.PNG)

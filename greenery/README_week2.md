## Week 2 

### Part 1 Models 

*1. What is our user repeat rate?*

 **Answer:**
 94.3%

Query:
```ruby
with  repeat_purchase as (
    select
      sum(case when number_of_orders>0 then 1 else 0 end) as purchasers,
      sum(case when number_of_orders>1 then 1 else 0 end) as repeat_purchasers

  from dbt_stef_c.fct_user_orders
  )
 
  select
    cast(repeat_purchasers as int)/cast (purchasers as int) as repeat_purchase
  from repeat_purchase
```


*2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?*

**Answer:**

* Good indicators: 
  * 
  * 
    * 
    * 

* Bad indicators:
  * 
  * 
    * 
    * 

* Additional data / questions:
  * 
  * 
  * 
  * 


*3. Explain the marts models you added. Why did you organize the models in the way you did?*

**Answer:**

* Core:
* Marketing: 
* Product: 


*4. Use the dbt docs to visualize your model DAGs to ensure the model layers make sense.*

**DAG:**

![alt text](link)


### Part 2 Tests

*1. What assumptions are you making about each model? (i.e. why are you adding each test?)*

**Answer**

 

*2. Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?*

**Answer**


*3. Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.*

**Answer**


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
  * Purchase amount?
  * Previous number of purchases (ie, people who purcahse 3 times are likely to become habitual customers)
  * Purchase type: are people who purchase certain items likely to re purchase?
  * Promo Amount? 
  * Promo frequency-- ie, people who always/never use a promo?

  


*3. Explain the marts models you added. Why did you organize the models in the way you did?*

**Answer:**

* Core: 
   * dim_products: here I join products and order items so I can have access to both products and the quantity that is only available in order_items

   * dim_users: here I join users and addresses, so I have access to both

   * fct_events: no real changes here, but I added this for completeness or in case changes have to happen in the future

   * fct_orders:I combine order with order items so I can have information from both tables
* Marketing: 
    * imm_user_orders: I create and imm table that just joins users and orders
    * fct_user_orders: I create more usable and grouped columns like number_of_orders here
* Product: 
    * None yet! I could add the sessions work we did in class 


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

At work, we use dbt cloud that automatically sends a daily email when tests fail. That's a good start, but I could also integrate with slack, to give the whole team better awareness and coverage about the tests. 

Typically, when a lot of bad data is coming through it's time to talk to eng to see if there is something on their end that can be done. I like to get really organized before those convos so I can be super specific. 
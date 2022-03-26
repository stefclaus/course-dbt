# Week 2 Project

## Part 1 - Models

### What is our user repeat rate? Repeat Rate = Users who purchased 2 or more times / users who purchased
Here I will create a CTE that provides purchase count by user, and use that to calculate the repeat rate. 
```
with user_purchases as (
  select
    user_id,
    count(order_id) as num_purchases
  from
    dbt_mike_c.stg_orders
  group by
    user_id
)

select
  count(case when num_purchases > 1 then user_id else null end) as repeat_purchasers,
  count(user_id) as total_purchasers,
  count(case when num_purchases > 1 then user_id else null end)::float/count(user_id)::float AS repeat_rate
from
  user_purchases
```

### What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

To understand what are indicators of whether a user will repeat purchase or not, I would consider evaluating the following:
 * Whether they used a promo code and if so, how large (is there a willingness to pay full price?)
 * Order timeline (how long until it shipped? how long until it delivered?)
 * Items in first purchase + volume
 * Cost of total purchase
 * Who the purchase was for (could infer whether address on order matches address in users table)
 * User interaction with site after purchase but _before_ first order arrives
 * General Demographic data (location, age, gender)
 * Days from creating an account to purchasing
 
 Additional data that does not exist but would be helpful includes:
  * Review (How did you like your purchase?)
  * Survey (How many plants do you already own?)
  * Whether it was shared on social media
  * Data describing the items
  * Income

### Create a marts folder, so we can organize our models, with the following subfolders for business units: Core, Marketing, Product

See [`greenery/models/marts`](https://github.com/mcaruana/course-dbt/tree/main/greenery/models/marts)

### Explain the marts models you added. Why did you organize the models in the way you did?

For **core**, see [`greenery/models/marts/core/core.md](https://github.com/mcaruana/course-dbt/tree/main/greenery/models/marts/core/core.md)

For **marketing**, see [`greenery/models/marts/marketing/marketing.md](https://github.com/mcaruana/course-dbt/tree/main/greenery/models/marts/marketing/marketing.md)

For **product**, see [`greenery/models/marts/product/product.md](https://github.com/mcaruana/course-dbt/tree/main/greenery/models/marts/product/product.md)

### Use the dbt docs to visualize your model DAGs to ensure the model layers make sense

See https://github.com/mcaruana/course-dbt/blob/main/assets/20220321_lineage.png

## Part 2 (Tests)

### We added some more models and transformed some data! Now we need to make sure they’re accurately reflecting the data. Add dbt tests into your dbt project on your existing models from Week 1, and new models from the section above

Added in code

### Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

There's a few ways of doing this. You can presuambly log failures and report on them, or integrate with Slack so that failures are being sent as alerts. The tests are only good if you're monitoring and understanding why they failed. 
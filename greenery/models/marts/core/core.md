# Brainstorm

 * Could have a fact_sessions table where we have 1 record per session. Could include:
   * session start and end date
   * duration
   * no page views
   * no products viewed
   * whether an item was added to cart
   * whether it ended in a purchase
   * where it has been shipped (end of session appears to be shipped, which is weird)
   * whether it was delivered (req joining to orders) <- maybe split into sep fact table

 * Could combine product + session data so we have a cleaner view of products viewed in a session? Could use product_id column
   * product viewed
   * product added to cart
   * product purchased
   * product shipped

* Could 

* dimension could be event_type
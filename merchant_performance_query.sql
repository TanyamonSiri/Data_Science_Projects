--- merchant tracking
--- 958 distinct merchants
--- 15 shippshipping_option_name
WITH sub_1 AS (
  SELECT 
    merchant_id,
    merchant_title,
    ROUND(merchant_rating,1) AS merchant_rating,
 	merchant_rating_count,
    title_orig,
    product_id,
    ROUND(rating,1) AS product_rating,
  	rating_count,
    price,
    retail_price,
  	100.0*(retail_price-price)/retail_price AS discount, 
    units_sold,
  	price*units_sold AS revenue,
    tags,
    product_color,
    product_variation_size_id,
    has_urgency_banner,
    uses_ad_boosts,
    product_variation_inventory,
    shipping_option_name,
    shipping_option_price,
    shipping_is_express,
    inventory_total
FROM summerproductswithratingandperformance_202008 
)

SELECT 
	merchant_id,
    merchant_title,
    merchant_rating,
    AVG(merchant_rating_count) AS merchant_rating_count,
    COUNT(product_id) AS n_product,
    ROUND(AVG(product_rating),1) AS avg_product_rating,
   	ROUND(AVG(rating_count),0) AS avg_product_rating_count,
    SUM(units_sold) AS total_units_sold,
    ROUND(SUM(revenue),2) AS total_revenue,
    ROUND(AVG(price),2) AS avg_price_per_product,
    ROUND(AVG(retail_price),2) AS avg_retail_price_per_product,
    ROUND(AVG(discount),2) AS avg_percent_discount
FROM sub_1
GROUP BY 1,2
ORDER BY total_units_sold DESC










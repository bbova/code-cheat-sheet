#create row numbers that start over at each new rate_plan_component_id and start at the newest start_date
select @row_num := IF(@prev_value=rr.rate_plan_component_id,@row_num+1,1) AS row_number
       , rr.id
       , rr.rate_plan_component_id
       , rr.price
       , rr.start_date
       , rr.end_date
       , @prev_value := rr.rate_plan_component_id
from re_rate rr,
      (select @row_num := 1) x,
      (select @prev_value := '') y
where rr.rate_plan_component_id in (select id from re_rate_plan_component where code regexp @codes_regexp)
   and rr.rate_plan_component_id not in (select id from re_rate_plan_component where calculator_code = @not_calc_code)
order by rr.rate_plan_component_id, rr.start_date desc
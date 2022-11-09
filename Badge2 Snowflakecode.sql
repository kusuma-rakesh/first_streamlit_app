--Welcome To Snowflake
--('RAKESHKUSUMA', 'FC52711', 'AWS_CA_CENTRAL_1')


select current_region();
select current_account();

------------------LEASSON 4 Started -------------------

/*Creates the DORA Integration*/
use role accountadmin;
create or replace api integration dora_api_integration
api_provider = aws_api_gateway
api_aws_role_arn = 'arn:aws:iam::321463406630:role/snowflakeLearnerAssumedRole'
enabled = true
api_allowed_prefixes = ('https://awy6hshxy4.execute-api.us-west-2.amazonaws.com/dev/edu_dora');

/*Lists All The Available Integration*/
Show Integrations;

/*Creates GRADER Functions*/
use role accountadmin;  
create or replace external function demo_db.public.grader(
      step varchar
    , passed boolean
    , actual integer
    , expected integer
    , description varchar)
returns variant
api_integration = dora_api_integration 
context_headers = (current_timestamp,current_account, current_statement) 
as 'https://awy6hshxy4.execute-api.us-west-2.amazonaws.com/dev/edu_dora/grader'
; 

/*Is DORA Working? Run This to Find Out!*/
select demo_db.public.GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DORA_IS_WORKING' as step
 ,(select 223) as actual
 , 223 as expected
 ,'Dora is working!' as description
); 



-- Set your worksheet drop lists
-- DO NOT EDIT ANYTHING BELOW THIS LINE
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DABW01' as step
 ,(select count(*) 
   from PC_RIVERY_DB.INFORMATION_SCHEMA.SCHEMATA 
   where schema_name ='PUBLIC') as actual
 , 1 as expected
 ,'Rivery is set up' as description
);




-- Set your worksheet drop lists
-- DO NOT EDIT ANYTHING BELOW THIS LINE
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DABW02' as step
 ,(select count(*) 
   from PC_RIVERY_DB.INFORMATION_SCHEMA.TABLES 
   where ((table_name ilike '%FORM%') 
   and (table_name ilike '%RESULT%'))) as actual
 , 1 as expected
 ,'Rivery form results table is set up' as description
);
------------------LEASSON 4 Completed -------------------


------------------LESSON 6 Starte------------------
select * from FRUITYVICE  --WHERE NAME = 'Mango';
--DELETE FROM FRUITYVICE WHERE NAME = 'Mango'


-- Set your worksheet drop lists

-- DO NOT EDIT ANYTHING BELOW THIS LINE
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DABW03' as step
 ,(select sum(round(nutritions_sugar)) 
   from PC_RIVERY_DB.PUBLIC.FRUITYVICE) as actual
 , 35 as expected
 ,'Fruityvice table is perfectly loaded' as description
);
------------------LESSON 6 Completed------------------

------------------LESSON 7 Start------------------
select * from PC_RIVERY_DB.PUBLIC.FDC_FOOD_INGEST

-- Set your worksheet drop lists
-- DO NOT EDIT ANYTHING BELOW THIS LINE
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DABW04' as step
 ,(select count(*) 
   from pc_rivery_db.public.fdc_food_ingest
   where lowercasedescription like '%cheddar%') as actual
 , 50 as expected
 ,'FDC_FOOD_INGEST Cheddar 50' as description
);
------------------LESSON 7 Completed------------------

------------------LESSON 8 Start------------------

--select *  from pc_rivery_db.public.FDC_FOOD_INGEST
--Cloning
--create table pc_rivery_db.public.FDC_FOOD_INGEST_CHEDDAR clone pc_rivery_db.public.fdc_food_ingest;
 --truncate table pc_rivery_db.public.FDC_FOOD_INGEST
 
 select * from PC_RIVERY_DB.PUBLIC.FDC_FOOD_INGEST
 
 create table PC_RIVERY_DB.PUBLIC.FDC_FOOD_INGEST_303 clone PC_RIVERY_DB.PUBLIC.FDC_FOOD_INGEST;
 
 CREATE TABLE pc_rivery_db.public.FRUIT_LOAD_LIST
 (
     FRUIT_NAME VARCHAR(25)
 )
 select * from pc_rivery_db.public.FRUIT_LOAD_LIST
 
 --DROP TABLE pc_rivery_db.public.fruit_load_list
 insert into pc_rivery_db.public.fruit_load_list
values 
('banana')
,('cherry')
,('strawberry')
,('pineapple')
,('apple')
,('mango')
,('coconut')
,('plum')
,('avocado')
,('starfruit');

--after loop checknig the rec count in the table
 select * from PC_RIVERY_DB.PUBLIC.FDC_FOOD_INGEST
 
 -- DO NOT EDIT ANYTHING BELOW THIS LINE
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DABW05' as step
 ,(select count(*) 
   from pc_rivery_db.public.fdc_food_ingest) as actual
 , 927 as expected
 ,'All the fruits!' as description
);
------------------LESSON 8 Completed------------------
------------------LESSON 11 Start------------------
Show stages in account;
list @my_internal_named_stage;
select $1   from @my_internal_named_stage/File1.txt.gz;
select $1 from @my_internal_named_stage/file2.txt.gz;
select $1 from @my_internal_named_stage/file3.txt.gz;

-- Set your worksheet drop lists
-- DO NOT EDIT ANYTHING BELOW THIS LINE
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DABW06' as step
 ,(select count(distinct METADATA$FILENAME) 
   from @demo_db.public.my_internal_named_stage) as actual
 , 3 as expected
 ,'I PUT 3 files!' as description
);

------------------LESSON 11 Completed------------------

------------------LESSON 12 started------------------
select * from fruit_load_list;
insert into fruit_load_list values ('Test');
delete from fruit_load_list where fruit_name in ('from streamlit','Test');
update pc_rivery_db.public.fruit_load_list set fruit_name = 'jackfruit' where fruit_name= 'Jackfruit'

-- DO NOT EDIT ANYTHING BELOW THIS LINE
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
   SELECT 'DABW07' as step 
   ,(select count(*) 
     from pc_rivery_db.public.fruit_load_list 
     where fruit_name in ('jackfruit','papaya', 'kiwi', 'test', 'from streamlit', 'guava')) as actual 
   , 4 as expected 
   ,'Followed challenge lab directions' as description
); 
------------------LESSON 12 Completed------------------

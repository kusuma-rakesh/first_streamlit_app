import streamlit
import pandas
import requests
import snowflake.connector

streamlit.title('My Parent New Healthy Diner')
streamlit.header('Breakfast Menu')
streamlit.text('🥣 Omega 3 & Blueberry Oatmeal')
streamlit.text('🥗 kale, Spinach & Rocket Smoothie')
streamlit.text('🐔 Hard-Boiled Free-Range Egg')
streamlit.text('🥑 Avocado Toast')
streamlit.header('🍌🥭 Build Your Own Fruit Smoothie 🥝🍇')

my_fruit_list = pandas.read_csv("https://uni-lab-files.s3.us-west-2.amazonaws.com/dabw/fruit_macros.txt")

#first loading then later filtering and showing only filtered fruites
#streamlit.dataframe(my_fruit_list)

#If index is not specified, then by defaul it take row 0 as index, if want to set any particular column as index then do like below:
my_fruit_list = my_fruit_list.set_index('Fruit')

#Let's put a pick list here so they can pick the fruit they want to include
#To pre-populate add the items after the list(my_fruit_list.index) --> ,['Avocado','Cantaloupe']
fruits_selected = streamlit.multiselect("pick some fruites: ", list(my_fruit_list.index))
fruites_to_show = my_fruit_list.loc[fruits_selected]
#display the table on the page
streamlit.dataframe(fruites_to_show)

#lesson-9
# header to the fruitvice 
streamlit.header("Fruitvice Fruit Advice!")

#Adding search text bax and passing it as param to api call
fruit_choice= streamlit.text_input('What fruit information would you like to know?','kiwi')
streamlit.write('The user entered',fruit_choice)
fruityvice_response = requests.get("https://fruityvice.com/api/fruit/"+fruit_choice)
streamlit.text(fruityvice_response)

#this below command help us show the response json on onscreen
#streamlit.text(fruityvice_response.json())

#Normalize the json
fruitevice_normalize = pandas.json_normalize(fruityvice_response.json())

#show output on screen in a grid
streamlit.dataframe(fruitevice_normalize)

#to correct the records which are inserting into snoflake-- duplicate records like from streamlit in fruitlist table, first stop streamlit here
streamlit.stop()

#lesson12
my_conx = snowflake.connector.connect(**streamlit.secrets["snowflake"])
my_cur = my_conx.cursor()
my_cur.execute("select CURRENT_USER(),CURRENT_ACCOUNT(),CURRENT_REGION()")
my_data_row = my_cur.fetchone()
streamlit.text("Hello/Welcome from Snowflake")
streamlit.text(my_data_row)


#lesson12- Retrieving the fruit_load_list table data
my_conx = snowflake.connector.connect(**streamlit.secrets["snowflake"])
my_cur = my_conx.cursor()
my_cur.execute("select * from fruit_load_list")
my_data_row = my_cur.fetchone()
streamlit.text("Snowflake - fruit_load_list Data:")
streamlit.text(my_data_row)

#lesson12- 
#Changing the above text to Header
#Retrieving the fruit_load_list table data to a data frame 
my_conx = snowflake.connector.connect(**streamlit.secrets["snowflake"])
my_cur = my_conx.cursor()
my_cur.execute("select * from fruit_load_list")
my_data_row = my_cur.fetchone()
streamlit.header('Snowflake - Fruit Load List Data:')
streamlit.dataframe(my_data_row)

#lesson12- 
#Modifying the above code to fetch all fruits data instead of only fetch one.
#Retrieving the fruit_load_list table data to a data frame 
my_conx = snowflake.connector.connect(**streamlit.secrets["snowflake"])
my_cur = my_conx.cursor()
my_cur.execute("select * from fruit_load_list")
my_data_row = my_cur.fetchall()
streamlit.header('Snowflake - Fruit Load List Data:')
streamlit.dataframe(my_data_row)

#Adding second search text bax and passing it as param to api call
ad_my_fruit = streamlit.text_input('What fruit would you like to add?','jackfruit')
streamlit.write('Thanks for adding',ad_my_fruit)
#fruityvice_response = requests.get("https://fruityvice.com/api/fruit/"+fruit_choice)
#streamlit.text(fruityvice_response)

my_cur.execute("insert into fruit_load_list values ('from streamlit')")

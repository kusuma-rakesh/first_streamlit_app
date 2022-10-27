import streamlit
import pandas

streamlit.title('My Parent New Healthy Diner')
streamlit.header('Breakfast Menu')
streamlit.text('🥣 Omega 3 & Blueberry Oatmeal')
streamlit.text('🥗 kale, Spinach & Rocket Smoothie')
streamlit.text('🐔 Hard-Boiled Free-Range Egg')
streamlit.text('🥑 Avocado Toast')
streamlit.header('🍌🥭 Build Your Own Fruit Smoothie 🥝🍇')

my_fruit_list = pandas.read_csv("https://uni-lab-files.s3.us-west-2.amazonaws.com/dabw/fruit_macros.txt")

#first loading then later filtering and showing only filtered fruites
streamlit.dataframe(fruites_to_show)

#If index is not specified, then by defaul it take row 0 as index, if want to set any particular column as index then do like below:
my_fruit_list = my_fruit_list.set_index('Fruit')

#Let's put a pick list here so they can pick the fruit they want to include
#To pre-populate add the items after the list(my_fruit_list.index) --> ,['Avocado','Cantaloupe']
fruits_selected = streamlit.multiselect("pick some fruites: ", list(my_fruit_list.index))
fruites_to_show = my_fruit_list.loc[fruits_selected]
#display the table on the page
streamlit.dataframe(fruites_to_show)

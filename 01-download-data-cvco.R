library(RSelenium)
library(rvest)
library(xml2)

# Start a RSelenium client
# Create a server
rD <- rsDriver(browser = "firefox",
               chromever = NULL)

# Create a driver to R
remDr <- rD$client

#Abre o servidor
remDr$open()

# Navigate to the website
remDr$navigate("http://www2.curitiba.pr.gov.br/gtm/pmat_consultardadosalvaraconstrucao/DefaultDinamico.htm")

# Wait for the page to load
Sys.sleep(5)

# Find and click the radio button for the type of input
radio_button <- remDr$findElement(using = "xpath",
                                  value = "//input[@id='rdoTipoPesquisa_3']/td/tr/tbody/table/td/tr")

radio_button$click()

# Wait briefly to ensure the page reacts to the radio button selection
Sys.sleep(2)

# Find the first input field by XPath and enter the first numeric value
first_input_field <- remDr$findElement(using = 'type', value = '3')
first_input_field$sendKeysToElement(list("32097011"))

# Find the second input field by XPath and enter the second numeric value
second_input_field <- remDr$findElement(using = "xpath", "/html/body/form/table[3]/tbody/tr[4]/td[2]/input")
second_input_field$sendKeysToElement(list("000"))

# Find the search button and click it
search_button <- remDr$findElement(using = "css selector", "input[id='WUCBarra1_Pesquisar']")
search_button$click()

# Wait for the search results to load
Sys.sleep(5)

# Scrape the table data
page_source <- remDr$getPageSource()[[1]]
table_html <- read_html(page_source) %>% html_nodes("table") %>% .[[1]]  # Adjust the index if necessary
table_data <- html_table(table_html, fill = TRUE)

# Print the scraped table data
print(table_data)

# Find the hyperlink in the first column and click it
# Assuming the hyperlink is in the first row
link_element <- remDr$findElement(using = 'xpath', "//table//tr[2]//td[1]//a")  # Adjust the XPath if necessary
link_element$click()

# Additional code for further interactions goes here

# Close the browser when done
remDr$close()

# end

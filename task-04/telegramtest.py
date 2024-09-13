import requests
sq=input("Enter search query: ")
url = "https://www.googleapis.com/books/v1/volumes"    
pm = {
    'q': sq,         # The search query
    'maxResults': 10,   # Maximum number of results to return
    'key': 'AIzaSyCJ97LSHZMd_sxNRLQglR_z-tMaLxxHNp8'      # Your API key
    }
response=requests.get(url, pm)
result=response.json()
if 'items' in result:
    print(f"Books found for query '{sq}':\n")
    # Loop through the list of books and print their titles
    for book in result['items']:
        title = book['volumeInfo'].get('title', 'No title available')
        print(title)
else:
    print(f"No books found for query '{query}'.")

from pymongo import MongoClient

from settings import MONGO_DB_INSTANCE_URL


if __name__ == '__main__':
    client = MongoClient(MONGO_DB_INSTANCE_URL)
    database = client.user_account # the new created db
    print(database)
    tables = database.list_collection_names()
        
    for count, table in enumerate(tables):
        print(f"table{count}: {table}")
    
    print("insert data in the users table")
    
    users_table = database.users
    mylist = [
        { "name": "Amy", "address": "Apple st 652"},
        { "name": "Hannah", "address": "Mountain 21"},
        { "name": "Michael", "address": "Valley 345"},
        { "name": "Sandy", "address": "Ocean blvd 2"},
        { "name": "Betty", "address": "Green Grass 1"},
        { "name": "Richard", "address": "Sky st 331"},
        { "name": "Susan", "address": "One way 98"},
        { "name": "Vicky", "address": "Yellow Garden 2"},
        { "name": "Ben", "address": "Park Lane 38"},
        { "name": "William", "address": "Central st 954"},
        { "name": "Chuck", "address": "Main Road 989"},
        { "name": "Viola", "address": "Sideway 1633"}
    ]
    
    x = users_table.insert_many(mylist)
    print(x.inserted_ids)

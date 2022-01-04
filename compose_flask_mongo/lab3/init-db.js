
db = db.getSiblingDB("account_user");
db.users.drop();

db.users.insertMany([
    {
        "id": 1,
        "name": "Lion",
        "address": "wild str 904237"
    },
    {
        "id": 2,
        "name": "Cow",
        "address": "domestic place 423789"
    },
    {
        "id": 3,
        "name": "Tiger",
        "address": "wild hunter str 89024"
    },
]);
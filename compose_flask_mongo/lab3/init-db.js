
db = db.getSiblingDB("account_user");
db.users.drop();

db.users.insertMany([
    {
        "name": "Lion",
        "address": "wild str 904237"
    },
    {
        "name": "Cow",
        "address": "domestic place 423789"
    },
    {
        "name": "Tiger",
        "address": "wild hunter str 89024"
    },
]);
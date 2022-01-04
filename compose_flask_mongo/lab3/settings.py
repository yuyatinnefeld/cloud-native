import os

MONGO_HOST="mongodb" 
MONGO_DB_NAME="account_user"

MONGO_DB_USERNAME="root" #fix value
MONGO_DB_PASSWOR="pass" #fix value
MONGO_PORT=27017 #fix value

ENVIRONMENT_DEBUG = os.environ.get("APP_DEBUG", True)
ENVIRONMENT_PORT = os.environ.get("APP_PORT", 5000)
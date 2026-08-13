import requests

API_URL = "https://control.fandom.com/api.php"
BASE_URL = "https://control.fandom.com/wiki/"

ROOT_CATEGORIES = [
    "Category:Collectibles_/_Correspondence",
    "Category:Collectibles_/_Multimedia",
    "Category:Collectibles_/_Research_&_Records",
    "Category:Collectibles_/_Case_Files",
    "Category:Collectibles_/_Hotline",
]

session = requests.Session()
session.headers.update({"User-Agent": "ControlCollectiblesResearch/1.0"})

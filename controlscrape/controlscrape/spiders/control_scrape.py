import scrapy

class ControlSpider(scrapy.Spider):
    name = "control_scraper"
    start_urls = [
        'https://control.fandom.com/wiki/Category:Collectibles_/_Research_%26_Records'
    ]
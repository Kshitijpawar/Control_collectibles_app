import scrapy

class ControlSpider(scrapy.Spider):
    name = "control_scraper"
    start_urls = [
        'https://control.fandom.com/wiki/Category:Collectibles_/_Research_%26_Records'
    ]

    def parse(self, response):
        research = response.xpath('//a[@class="category-page__member-link"]/@href')
        for link in research:
            
            yield response.follow(link.get(), callback= self.parse_research)

    
    def parse_research(self, response):
        research_items = response.xpath('//a[@class="category-page__member-link"]/text()')
        print(f"this is research items: {research_items}")
        for item in research_items:
            print(item.get())

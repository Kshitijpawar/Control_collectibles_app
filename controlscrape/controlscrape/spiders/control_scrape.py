import scrapy
import json
import random
import re


class ControlSpider(scrapy.Spider):
    name = "control_scraper"
    start_urls = [
        "https://control.fandom.com/wiki/Category:Collectibles_/_Research_%26_Records"
    ]
    json_content = {}
    new_json = {}

    def parse(self, response):
        research = response.xpath('//a[@class="category-page__member-link"]/@href')

        for i, link in enumerate(research):
            if i == 0:
                continue
            topic = link.get().split("/")[-1].replace("_", " ").strip()
            yield response.follow(
                link.get(), callback=self.parse_research_topic, meta={"topic": topic}
            )

    def parse_research_topic(self, response):
        research_items = response.xpath(
            '//a[@class="category-page__member-link"]/text()'
        )
        research_items_url = response.xpath(
            '//a[@class="category-page__member-link"]/@href'
        )
        for idx, item in enumerate(research_items):
            yield response.follow(
                research_items_url[idx].get(),
                callback=self.parse_research_item,
            )

    def parse_research_item(self, response):
        image_src = response.xpath('//img[@class="pi-image-thumbnail"]/@src').getall()
        if len(image_src) > 1:
            print("woah woah woah easy there bucko")
        item_name = response.xpath('//*[@id="firstHeading"]/text()').get().strip()
        topic_name = (
            response.xpath('//a[@data-tracking-label="categories-top-more-0"]/@title')
            .get()
            .split("/")[-1]
            .strip()
        )
        self.new_json[str(random.getrandbits(20))] = {
            "topic_name": topic_name,
            "item_name": item_name,
            "item_image_src": re.sub(r"/revision.*", "", image_src),
        }

    def closed(self, reason):
        # with open(
        #     f"/home/kshitij/Desktop/control_project/Control_collectibles_app/test.json",
        #     "w",
        #     encoding="utf-8",
        # ) as fout:
        #     json.dump(self.json_content, fout, indent=4)
        with open(
            f"/home/kshitij/Desktop/control_project/Control_collectibles_app/new.json",
            "w",
            encoding="utf-8",
        ) as fout:
            json.dump(self.new_json, fout, indent=4)

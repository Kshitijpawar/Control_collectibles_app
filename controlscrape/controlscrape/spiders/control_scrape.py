import scrapy
import json
import random
import re


class ControlResearchSpider(scrapy.Spider):
    name = "control_research_scraper"
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
        item_para = response.xpath('//div[@class="poem va-transcript-text"]/p').get()
        if len(image_src) == 0:
            item_image_src = "n/a"

        else:
            item_image_src = re.sub(r"/revision.*", "", image_src[0])
            item_to_append = {
                # "topic_name": topic_name,
                "item_name": item_name,
                "item_url": response.url,
                "item_text": item_para if item_para is not None else "n/a",
                "item_image_src": item_image_src,
            }
            if topic_name not in self.new_json.keys():
                self.new_json[topic_name] = [item_to_append]
            else:
                self.new_json[topic_name].append(item_to_append)

    def closed(self, reason):
        # with open(
        #     f"/home/kshitij/Desktop/control_project/Control_collectibles_app/test.json",
        #     "w",
        #     encoding="utf-8",
        # ) as fout:
        #     json.dump(self.json_content, fout, indent=4)
        with open(
            f"/home/kshitij/Desktop/control_project/Control_collectibles_app/json_files/research_and_records.json",
            "w",
            encoding="utf-8",
        ) as fout:
            json.dump(self.new_json, fout, indent=4)


class ControlCorrespondenceSpider(scrapy.Spider):
    name = "control_corr_scraper"
    start_urls = [
        # "https://control.fandom.com/wiki/Category:Collectibles_/_Research_%26_Records",
        "https://control.fandom.com/wiki/Category:Collectibles_/_Correspondence"
    ]
    # json_content = {}
    new_json = {}

    def parse(self, response):
        research = response.xpath('//a[@class="category-page__member-link"]/@href')

        for i, link in enumerate(research):
            # if i == 0:
            # continue
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
        item_para = response.xpath('//div[@class="poem va-transcript-text"]/p').get()
        if len(image_src) == 0:
            item_image_src = "n/a"

        else:
            item_image_src = re.sub(r"/revision.*", "", image_src[0])
            item_to_append = {
                # "topic_name": topic_name,
                "item_name": item_name,
                "item_url": response.url,
                "item_text": item_para if item_para is not None else "n/a",
                "item_image_src": item_image_src,
            }
            if topic_name not in self.new_json.keys():
                self.new_json[topic_name] = [item_to_append]
            else:
                self.new_json[topic_name].append(item_to_append)

    def closed(self, reason):
        # with open(
        #     f"/home/kshitij/Desktop/control_project/Control_collectibles_app/test.json",
        #     "w",
        #     encoding="utf-8",
        # ) as fout:
        #     json.dump(self.json_content, fout, indent=4)
        with open(
            f"/home/kshitij/Desktop/control_project/Control_collectibles_app/json_files/correspondence.json",
            "w",
            encoding="utf-8",
        ) as fout:
            json.dump(self.new_json, fout, indent=4)


class ControlHotlineSpider(scrapy.Spider):
    name = "control_hotline_scraper"
    start_urls = [
        # "https://control.fandom.com/wiki/Category:Collectibles_/_Research_%26_Records",
        # "https://control.fandom.com/wiki/Category:Collectibles_/_Correspondence",
        "https://control.fandom.com/wiki/Category:Collectibles_/_Hotline",
    ]
    # json_content = {}
    new_json = {}

    def parse(self, response):
        research = response.xpath('//a[@class="category-page__member-link"]/@href')

        for i, link in enumerate(research):
            # if i == 0:
            # continue
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
            response.xpath('//div[@class="page-header__categories"]/a/text()')
            .getall()[-1]
            .split("/")[-1]
            .strip()
        )

        item_para = response.xpath('//div[@class="poem va-transcript-text"]/p').get()
        if len(image_src) == 0:
            item_image_src = "n/a"
        else:
            item_image_src = re.sub(r"/revision.*", "", image_src[0])

        item_to_append = {
            # "topic_name": topic_name,
            "item_name": item_name,
            "item_url": response.url,
            "item_text": item_para if item_para is not None else "n/a",
            "item_image_src": item_image_src,
        }

        if topic_name not in self.new_json.keys():
            print(topic_name)
            self.new_json[topic_name] = [item_to_append]
        else:
            self.new_json[topic_name].append(item_to_append)

        # self.new_json[str(random.getrandbits(20))] = {
        #     "topic_name": topic_name,
        #     "item_name": item_name,
        #     "item_url": response.url,
        #     "item_text": item_para,
        #     "item_image_src": item_image_src,
        # }

    def closed(self, reason):
        # with open(
        #     f"/home/kshitij/Desktop/control_project/Control_collectibles_app/test.json",
        #     "w",
        #     encoding="utf-8",
        # ) as fout:
        #     json.dump(self.json_content, fout, indent=4)
        with open(
            f"/home/kshitij/Desktop/control_project/Control_collectibles_app/json_files/hotline.json",
            "w",
            encoding="utf-8",
        ) as fout:
            json.dump(self.new_json, fout, indent=4)


class ControlCaseFilesSpider(scrapy.Spider):
    name = "control_casefiles_scraper"
    start_urls = [
        "https://control.fandom.com/wiki/Category:Collectibles_/_Case_Files",
    ]
    json_content = {}
    new_json = {}

    def parse(self, response):
        research = response.xpath('//a[@class="category-page__member-link"]/@href')
        print(f"printing research items: {len(research)}")
        print(research)
        for i, link in enumerate(research):
            # if i == 0:
            # print(f'skipping {link}')
            # continue
            topic = link.get().split("/")[-1].replace("_", " ").strip()
            if topic.startswith("Altered Items"):
                print("YEAH BOI")
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
        # topic_name = (
        #     response.xpath('//a[@data-tracking-label="categories-top-more-0"]/text()')
        #     .get()
        #     .split("/")[-1]
        #     .strip()
        # )

        topic_name = (
            response.xpath('//div[@class="pi-data-value pi-font"]')[0]
            .root.text.split("/")[-1]
            .strip()
        )
        item_para = response.xpath('//div[@class="poem va-transcript-text"]/p').get()
        if len(image_src) == 0:
            item_image_src = "n/a"

        else:
            item_image_src = re.sub(r"/revision.*", "", image_src[0])
            item_to_append = {
                # "topic_name": topic_name,
                "item_name": item_name,
                "item_url": response.url,
                "item_text": item_para if item_para is not None else "n/a",
                "item_image_src": item_image_src,
            }
            if topic_name not in self.new_json.keys():
                self.new_json[topic_name] = [item_to_append]
            else:
                self.new_json[topic_name].append(item_to_append)

    def closed(self, reason):
        # with open(
        #     f"/home/kshitij/Desktop/control_project/Control_collectibles_app/test.json",
        #     "w",
        #     encoding="utf-8",
        # ) as fout:
        #     json.dump(self.json_content, fout, indent=4)
        with open(
            f"/home/kshitij/Desktop/control_project/Control_collectibles_app/json_files/case_files.json",
            "w",
            encoding="utf-8",
        ) as fout:
            json.dump(self.new_json, fout, indent=4)

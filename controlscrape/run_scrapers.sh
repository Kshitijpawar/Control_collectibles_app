#!/bin/bash
source /home/kshitij/Desktop/control_project/cenv/bin/activate
scrapy crawl control_research_scraper
scrapy crawl control_corr_scraper
scrapy crawl control_hotline_scraper
scrapy crawl control_casefiles_scraper
scrapy crawl control_multimedia_scraper
cd /home/kshitij/Desktop/control_project/Control_collectibles_app/json_files/
python merge_json.py research_and_records.json hotline.json correspondence.json case_files.json multimedia.json

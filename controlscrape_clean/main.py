import json
from pathlib import Path

import requests
from markdownify import markdownify as md
from bs4 import BeautifulSoup
from urllib.parse import quote, urlsplit

from utils import extract_payload, nest_by_categories, process_blob_link
from constants import API_URL, BASE_URL, ROOT_CATEGORIES, session


def get_category_members(category):
    """Reutrn every page/subcategory directly contained in a category

    Args:
        category (_type_): _description_
    """

    members = []
    params = {
        "action": "query",
        "format": "json",
        "list": "categorymembers",
        "cmtitle": category,
        "cmlimit": "max",
        "cmtype": "page|subcat",
    }

    while True:
        response = session.get(API_URL, params=params)
        response.raise_for_status()

        data = response.json()
        members.extend(data["query"]["categorymembers"])
        if "continue" not in data:
            break

        params.update(data["continue"])

    return members


def crawl_category(category, path=None, visited_categories=None):
    if category.endswith("images"):
        print(f"Found irrelevant category: {category}")
        return []
    if path is None:
        path = []

    if visited_categories is None:
        visited_categories = set()

    if category in visited_categories:
        return []

    visited_categories.add(category)

    print(f"Crawling: {category}")

    collectibles = []

    members = get_category_members(category)

    current_name = category.removeprefix("Category:")

    for member in members:
        title = member["title"]
        namespace = member["ns"]

        # Regular wiki article
        if namespace == 0:
            collectibles.append({"title": title, "category": current_name})
        # another category
        elif namespace == 14:
            collectibles.extend(
                crawl_category(
                    title, path=current_name, visited_categories=visited_categories
                )
            )

    return collectibles


def get_page_html(title):
    params = {
        "action": "parse",
        "format": "json",
        "page": title,
        "prop": "text",
        "redirects": 1,
    }
    response = session.get(API_URL, params=params)
    response.raise_for_status()
    data = response.json()
    return data["parse"]["text"]["*"]


def parse_collectible(title):
    html = get_page_html(title)
    soup = BeautifulSoup(html, "html.parser")

    # Extract collectible payload
    payload = extract_payload(soup)
    if payload is None:
        print(f"[WARNING]: No text found for {title}")

    # Extract blob
    blob = process_blob_link(soup)
    if blob is None:
        print(f"[WARNING]: No blob found for {title}")
        blob = {}
    return {
        "title": title,
        "uri": BASE_URL + quote(title.replace(" ", "_"), safe=""),
        "payload": payload,
        "blob": blob,
    }


def main():

    discovered = []

    for category in ROOT_CATEGORIES:
        discovered.extend(crawl_category(category))
    print(f"Discovered {len(discovered)} collectible entries")
    unique_collectibles = {}
    for item in discovered:
        title = item["title"]

        if title not in unique_collectibles:
            unique_collectibles[title] = {"title": title, "category": ""}
        unique_collectibles[title]["category"] = item["category"]

    print(f"Unique Collectibles: {len(unique_collectibles)}")

    results = []
    for i, item in enumerate(unique_collectibles.values(), start=1):
        title = item["title"]
        print(f"[{i} / {len(unique_collectibles)}]" f"Parsing: {title}")

        try:
            collectible = parse_collectible(title)
            collectible["category"] = item["category"]

            results.append(collectible)
        except Exception as e:
            print(f"ERROR parsing {title}: {e}")

    with open( Path(__file__).parents[1] / "json_files" / ".collectibles.json", "w", encoding="utf-8") as f:
        json.dump(results, f, indent=4, ensure_ascii=False)

    print(f"Saved {len(results)} collectibles " f"to .collectibles.json")
    
    structure_json_data = nest_by_categories(results)
    with open( Path(__file__).parents[1] / "json_files" / "collectibles.json", "w", encoding="utf-8") as f:
        json.dump(structure_json_data, f, indent=4, ensure_ascii=False)
    print(f"Saved {len(structure_json_data)} collectibles " f"to collectibles.json")
    
if __name__ == "__main__":
    main()
    

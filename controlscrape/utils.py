from urllib.parse import urlsplit, unquote

from markdownify import markdownify as md
from constants import session, API_URL


def extract_payload(soup):
    possible_types = {
        "quote": "table.cquote td[style*='font-style:italic']",
        "video_description": "h2 span#Video_description",
        "transcript": [
            "h2 span#Transcript",
            "h2 span#Trancript",
            "h2 span#File_text",
            "h3 span#Transcript",
        ],
        "lyrics": "h2 span#Lyrics",
    }

    for exc, selector in possible_types.items():

        if isinstance(selector, list):
            for i in selector:
                anchor = soup.select_one(i)
                if anchor is None:
                    continue
                else:
                    get_selector_name = i
                    break
        elif isinstance(selector, str):
            get_selector_name = selector
            anchor = soup.select_one(selector)

        if anchor is None:
            continue

        if exc == "quote":
            text = anchor.decode_contents().strip()
            return {"type": exc, "text": text}

        elif exc == "video_description":
            h2 = anchor.find_parent(f"{get_selector_name[:2]}")
            paragraphs = []

            for sibling in h2.find_next_siblings():
                if sibling.name in ["h2", "h3"]:
                    break

                if sibling.name == "p":
                    paragraphs.append(str(sibling).replace("\n", ""))

            if not paragraphs:
                return {}

            return {"type": exc, "text": "<br>".join(paragraphs)}

        elif exc in ["transcript", "lyrics"]:
            h2 = anchor.find_parent(f"{get_selector_name[:2]}")

            transcript_wrapper = h2.find_next("div", class_="va-transcript")

            text = None

            if transcript_wrapper:
                transcript_text = transcript_wrapper.select_one(
                    "div.va-transcript-text"
                )

                if transcript_text:
                    text = transcript_text.decode_contents().replace("\n", "").strip()
            else:
                paragraphs = []
                for sibling in h2.find_next_siblings():
                    if sibling.name in ["h2", "h3"]:
                        break
                    if sibling.name == "p":
                        paragraphs.append(str(sibling).replace("\n", ""))
                text = "<br>".join(paragraphs)
            if text is None:
                return {}
            return {"type": exc, "text": text}


def get_yt_link(file_title: str):
    params = {
        "action": "query",
        "format": "json",
        "prop": "imageinfo",
        "titles": file_title,
        "iiprop": "url|metadata|extmetadata",
    }
    response = session.get(API_URL, params=params)
    response.raise_for_status()
    data = response.json()
    page = next(iter(data["query"]["pages"].values()))
    imageinfo = page["imageinfo"][0]
    metadata = imageinfo.get("metadata", [])

    metadata_dict = {item["name"]: item["value"] for item in metadata}

    if metadata_dict.get("provider") == "youtube":
        video_id = metadata_dict.get("videoId")

        youtube_url = (
            f"https://www.youtube.com/watch?v={video_id}" if video_id else None
        )
    else:
        youtube_url = None

    return youtube_url


def process_blob_link(soup):
    possible_blobs = {
        "audio": "audio[src]",
        "video": "figure.pi-item a.video-thumbnail",
        "image": "figure.pi-item a",
    }

    for exc, selector in possible_blobs.items():
        anchor = soup.select_one(selector)
        if anchor is None:
            continue

        if exc == "audio":
            blob_link = urlsplit(anchor.get("src"))._replace(query="").geturl()
            return {"type": exc, "link": blob_link}
        elif exc == "video":
            img = anchor.select_one("img")
            video_key = img.get("data-video-key") if img else None
            file_title = "File:" + unquote(video_key)

            yt_link = get_yt_link(file_title)
            return {"type": exc, "link": yt_link}

        elif exc == "image":
            image_link = urlsplit(anchor.get("href"))._replace(query="").geturl()
            return {"type": exc, "link": image_link}

def nest_by_categories(data, preserve_category_key=False):
    result = {}

    for item in data:
        raw_cat = item.get("category", "")
        parts = [p.strip() for p in raw_cat.split("/") if p.strip()]

        categories = parts[1:] if len(parts) > 1 else parts


        item_data = item if preserve_category_key else {k: v for k, v in item.items() if k != "category"}

        current_level = result
        for cat in categories[:-1]:
            if cat not in current_level:
                current_level[cat] = {}
            current_level = current_level[cat]

        last_cat = categories[-1]
        if last_cat not in current_level:
            current_level[last_cat] = []
            
        current_level[last_cat].append(item_data)

    return result
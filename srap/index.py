import csv
from dataclasses import dataclass
from typing import Optional
import requests
from bs4 import BeautifulSoup
import time
import random
from info import user_agents
from info import referers

@dataclass
class Product:
    title: str
    price: Optional[str]
    image_url: Optional[str]
    description: str
    availability: str
   

def scrape_amazon():
    base_url = "https://sale.alibaba.com/category/theme/index.html?spm=a27aq.cp_3.3622017510.2.36a75b91UCUbLl&wx_navbar_transparent=true&path=/category/theme/index.html&ncms_spm=a27aq.27059075&prefetchKey=met&cardType=2684401&cardId=2675803&topOfferIds=1600294976998&categoryIds=3&tracelog=fy23_all_categories_home_lp"
 

    headers = {"User-Agent": random.choice(user_agents),
                    "Referer":random.choice(referers)
                   }
    response = requests.get(base_url, headers=headers)

    if response.status_code == 200:
        soup = BeautifulSoup(response.content, "html.parser")


        products = []
        for product_link in soup.find_all("a", class_="hugo-dotelement hugo4-product hugo4-product-vertical hugo4-product-pc hugo3-common-style-pc bg-white"):
          product_url = product_link.get("href")
          print(product_url)
          product_info = scrape_product_info(product_url, headers)
          products.append(product_info)

          save_to_csv(products)

  
def scrape_product_info(url, headers):
    # sourcery skip: extract-method, remove-unnecessary-else
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        soup = BeautifulSoup(response.content, "html.parser")

        title_elem = soup.find("div", class_="product-title-container")
        title = title_elem.get_text(strip=True) if title_elem else ""

        price_elem = soup.find("div", class_="price")
        price = price_elem.get_text(strip=True) if price_elem else None
        
        image_elem = soup.find("img", class_="detail-main-img")
        image_url = image_elem.get("src") if image_elem else None
        
        
        description_elem = soup.find("div", class_="attribute-info")
        description = description_elem.get_text(strip=True) if description_elem else ""
        availability_elem = soup.find("div", class_="quality")
        availability = availability_elem.get_text(strip=True) if availability_elem else ""
       
        return Product(title, price,image_url,  description, availability)
    else:
        print(f"Failed to fetch product info from {url}. Status code: {response.status_code}")
        return Product("", None, None, "", "", "")

def save_to_csv(products):
    with open("urbanware.csv", mode="a", encoding="utf-8", newline="") as file:
        writer = csv.writer(file)
        for product in products:
            writer.writerow([product.title, product.price, product.image_url, product.description, product.availability])

if __name__ == "__main__":
    scrape_amazon()
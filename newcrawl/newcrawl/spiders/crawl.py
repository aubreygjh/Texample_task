import scrapy
import os
from urllib import request

class TexSpider(scrapy.Spider):
    name = "latex"
    allowed_domains = ["texample.net"]
    start_urls = ["http://www.texample.net/tikz/examples"]

    def parse(self, response):
        hrefs = response.selector.xpath('//div[contains(@class, "tag-table tag-list")]//@href').extract()
        for href in hrefs:
            if "/tikz/examples/tag" not in href:
                continue
            #self.folder=href.split('/')[-1]
            url = response.urljoin(href)
            print(url)
            request = scrapy.Request(url,callback=self.parse_detail)
            yield request

    def parse_detail(self, response):
        path = 'result/'
        catagory = response.selector.xpath('//h1/text()').extract()   #extract tags to catagory
        catagory = catagory[0].replace(' ','_').replace('_examples','')
        path = path+catagory+'/'
        if os.path.exists(path) == False:
            os.mkdir(path)
        print(path)

        hrefs = response.selector.xpath('//div[contains(@class, "gallery")]//a[text()="TEX"]//@href').extract()
        for href in hrefs:
            url = response.urljoin(href)
            file_name=href.split('/')[-1]
            print(file_name)
            request.urlretrieve(url,path+file_name)

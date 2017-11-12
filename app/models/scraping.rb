require 'mechanize'

class Scraping
    def self.movie_urls
        links = [] # 個別ページのリンクを保存する配列
        agent = Mechanize.new
        
        next_url = ""
        
        while true do
            current_page = agent.get("http://review-movie.herokuapp.com")
            elements = current_page.search('.entry-title a')
            elements.each do |ele|
                links << ele[:href]
            end
            
            next_link = current_page.at('.pagination .next a')
            break unless next_link
            next_url = next_link[:href]
        end
        links.each do |link|
            get_product('http://review-movie.herokuapp.com/' + link)
        end
    end
    
    def self.get_product(link)
        agent = Mechanize.new
        page = agent.get(link)
        title = page.at('.entry-title').inner_text
        image_url = page.at('.entry-content img')[:src] if page.at('.entry-content img')
        director = page.at('.director span').inner_text if page.at('.director span')
        detail = page.at('.entry_content p').inner_text if page.at('.entry_content p')
        open_date = page.at('.date span').inner_text if page.at('date span')
        
        # product = Product.new(title: title, image_url: image_url)
        product = Product.where(title: title).first_or_initialize
        product.image_url = image_url
        product.title = title
        product.director = director
        product.detail = detail
        product.open_date = open_date
        product.save
    end
end
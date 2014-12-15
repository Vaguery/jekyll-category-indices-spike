module Jekyll

  class CategoryPage < Page
    def initialize(site, base, dir, category)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'category_index.html')
      self.data['category'] = category

      category_title_prefix = site.config['category_title_prefix'] || 'Category: '
      self.data['title'] = "#{category_title_prefix}#{category}"
    end
  end


  class GlobalCategoryListByCollectingThemFromPages < Generator
    def generate(site)
      site.pages.each do |page|
        site.config["all_categories"] = (site.config["all_categories"] + page["categories"]).uniq.sort unless page["categories"].nil?
      end
    end
  end


  class CategoryPageGenerator < Generator
    safe true

    def generate(site)
      puts "generating indices"
      if site.layouts.key? 'category_index'
        dir = site.config['category_dir'] || 'categories'
        site.config['all_categories'].each do |cat|
          puts "adding #{cat} index"
          site.pages << CategoryPage.new(site, site.source, File.join(dir, cat), cat)
        end
      end
    end
  end

end
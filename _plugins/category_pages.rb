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
      self.data['no_index'] = true
    end
  end

  class FinallyBuildGlobalCategoryHashes < Generator
    
    def generate(site)
      site.pages.each do |p|
        unless p["categories"].nil?
          p["categories"].each do |cat|
            site.config["all_categories"][cat] = Jekyll::Utils::slugify(cat) 
          end
        end
      end
    end
  end


  class CategoryPageGenerator < Generator
    safe true

    def generate(site)
      puts "generating indices"
      if site.layouts.key? 'category_index'
        dir = site.config['category_dir'] || 'categories'
        site.config['all_categories'].each do |k,v|
          puts "adding #{k} index"
          site.pages << CategoryPage.new(site, site.source, File.join(dir, v), k)
        end
        puts "adding overall index"
        site.pages << CategoryPage.new(site, site.source, File.join(dir, 'all'), 'all')
      end
    end
  end

end
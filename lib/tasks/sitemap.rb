class Sitemap 
  def initialize(sitemap_type)
    @sitemap_type = sitemap_type
    @date = Time.now.strftime("%Y-%m-%d")
    @xml_path_list = []
  end

  def create_sitemap
    @file_name_prefix = "public/sitemap/#{@sitemap_type}_fishtrip_danti"
    @template_file = "lib/tasks/#{@sitemap_type}_fishtrip_danti.erb" 
    index=0
    FishtripHotel.find_in_batches(batch_size: 5000) do |hotel_batch|
      res = ERB.new(File.read(@template_file)).result(binding)
      xml_file_name = "#{@file_name_prefix}_#{index}.xml"
      xml_file = File.open(xml_file_name,'w+')
      xml_file.write(res)
      @xml_path_list << xml_file_name
      index += 1
    end
    puts "Sitemap danti generated successfully "

    @file_name_prefix = "public/sitemap/#{@sitemap_type}_fishtrip_article"
    @template_file = "lib/tasks/#{@sitemap_type}_fishtrip_article.erb" 
    index=0
    FishtripArticle.find_in_batches(batch_size: 5000) do |hotel_batch|
      res = ERB.new(File.read(@template_file)).result(binding)
      xml_file_name = "#{@file_name_prefix}_#{index}.xml"
      xml_file = File.open(xml_file_name,'w+')
      xml_file.write(res)
      @xml_path_list << xml_file_name
      index += 1
    end
    puts "Sitemap article generated successfully "
  end

  def create_sitemap_index
    @index_file_name = "public/sitemap/#{@sitemap_type}_sitemap_index.xml"
    @template_index= "lib/tasks/#{@sitemap_type}_index.erb" 
    sitemap_index_file = File.new(@index_file_name,"w+")
    res = ERB.new(File.read(@template_index)).result(binding)
    sitemap_index_file.write(res)
  end
end

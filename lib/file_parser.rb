class FileParser
  def self.parse_file(params, provider = nil)
    file_name = params[:file] ? params[:file].original_filename : params[:file_url]
    case File.extname(file_name)
    when '.yaml'
      product_lists = YAML.load_file(params[:file].path)
    when '.json'
      product_lists = JSON.parse(File.read(params[:file].path))['products']
    when '.csv'
      product_lists = []
      csv = CSV.read(params['file'].path, :headers => true)
      csv.each do |row|
        product_lists << { categories: row['categories'], name: row['name'], twitter: row['twitter'] }
      end
    else
      error_message = "File extension #{File.extname(file_name)} not supported.Please provide valid file [.yaml, .json,.csv] "
    end

    begin
      product_lists.each do |product|
        product = product.with_indifferent_access
        next unless Product::CATEGORIES.include?(product.keys[0].downcase)
        values = product.values[0].class == String ? product.values[0].split(',') : product.values[0]

        values.each do |value|
          category = Category.find_or_create_by(name: value)
          Product.create(provider_id: provider , category_id: category.id, name: product['title'].presence || product['name'].presence, twitter: product['twitter'])
        end
      end
      success = "Product Uploaded Successfully."
    rescue Exception => e
      error_message = "Something went wrong. Error: #{e}"
    end

    return success, error_message
  end
end
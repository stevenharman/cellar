namespace :openbeerdb do

  desc 'export data from openbeer_db MySql database'
  task :export => [:environment] do
    require 'csv'
    mkdir_p export_path

    ActiveRecordize('Brewery', 'Beer', 'Style', 'Category', 'Geocode') do |model|
      CSV.open(csv_file(model.table_name), 'wb') do |csv|
        csv << model.column_names
        model.find_each { |m| csv << m.attributes.values }
      end
    end
  end

  desc "import the OpenBeerDB CSV files"
  task :import  => ['import:breweries', 'import:brews']

  namespace :import do
    task :breweries => [:environment] do
      require 'csv'

      import_csv('breweries') do |line|
        brewery = Brewery.new(name: line[:name], url: line[:website])
        puts "#{line[:id]} = #{brewery.name} :: #{brewery.errors.full_messages.join(", ")}" unless brewery.save
      end
    end

    task :brews => [:environment] do
      require 'csv'

      import_csv('beers') do |line|
        brew = Brew.new(name: line[:name], abv: line[:abv].to_f, ibu: line[:ibu].to_i, description: line[:descript])
        brew.brewery_id = line[:brewery_id]
        puts "#{line[:id]} - #{brew.name} :: #{brew.errors.full_messages.join(", ")}. brewery_id: #{line[:brewery_id]}" unless brew.save
      end
    end
  end

  def import_csv(file_name)
    imports = 0
    CSV.foreach(csv_file(file_name), headers: true, header_converters: :symbol) do |line|
      yield line
      imports+=1
    end
    puts "Processed #{imports} #{file_name}!"
  end

  def ActiveRecordize(*model_names)
    model_names.map do |klass|
      model = Kernel.const_set(klass, Class.new(ActiveRecord::Base))
      yield model
    end
  end

  def csv_file(table_name)
    File.join(export_path, "#{table_name}.csv")
  end

  def export_path
    File.join(File.expand_path('../../..', __FILE__), %W[db export])
  end

end

namespace :pg_search do
  namespace :multisearch do
    desc "rebuild search index for Breweries & Brews"
    task :rebuild_all => [:environment] do
      PgSearch::Multisearch.rebuild(Brewery)

      PgSearch::Document.delete_all(:searchable_type => "Brew")
      Brew.find_each { |b| b.update_pg_search_document }
    end
  end
end

module Search
  class ResultsSerializer < ActiveModel::ArraySerializer
    root :results

    def meta
      {
        pagination: {
          page: object.current_page,
          totalPages: object.total_pages,
          totalCount: object.total_count
        }
      }.merge(Hash(super))
    end
  end
end


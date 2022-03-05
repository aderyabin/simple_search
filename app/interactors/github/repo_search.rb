# frozen_string_literal: true

module Github
  class RepoSearch
    include Interactor

    PER_PAGE = 30

    def call
      return if context.query.blank?

      context.fail!(message: search.message) unless search.success?

      context.repos = paginated_repos
    end

    private

    def page
      @page ||= page_value(context.page)
    end

    def per_page
      @per_page ||= context.per_page.nil? ? PER_PAGE : page_value(context.per_page)
    end

    def search
      @search ||= Github::Adapters::OctokitAdapter.call(query: context.query, page:, per_page:)
    end

    def page_value(raw_value)
      [raw_value.to_i, 1].max
    end

    def paginated_repos
      Kaminari.paginate_array(search.repos, total_count: search.total_count).page(page).per(per_page)
    end
  end
end

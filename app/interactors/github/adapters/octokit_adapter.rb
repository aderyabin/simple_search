# frozen_string_literal: true

require 'octokit'

module Github
  module Adapters
    class OctokitAdapter
      include Interactor

      def call
        response = search_repositories
        context.repos = convert_to_repo(response[:items])
        context.total_count = response[:total_count]
      end

      private

      def search_repositories
        client.search_repositories(context.query, { page: context.page, per_page: context.per_page })
      rescue StandardError => e
        context.fail!(message: e.message)
      end

      def client
        @client ||= Octokit::Client.new
      end

      def convert_to_repo(items)
        items.map do |item|
          Repo.new(
            id: item[:id], name: item[:name], description: item[:description], url: item[:html_url],
            avatar_url: item[:owner][:avatar_url], username: item[:owner][:login], owner_type: item[:owner][:type],
            topics: item[:topics]
          )
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe Github::Adapters::OctokitAdapter do
  subject { described_class.call(page:, per_page:, query:) }

  let(:page) { 1 }
  let(:per_page) { 30 }
  let(:query) { 'rails' }

  shared_examples 'invalid search' do
    it 'returns failure' do
      expect(subject.failure?).to be(true)
    end

    it 'returns total_count as nil' do
      expect(subject.total_count).to be_nil
    end

    it 'returns repos as nil' do
      expect(subject.repos).to be_nil
    end

    it 'returns valid error message' do
      expect(subject.message).to eq(error_message)
    end
  end

  context 'when limit reached' do
    let(:error_message) do
      'GET https://api.github.com/search/repositories?page=1&per_page=30&q=rails: 403 - API rate limit exceeded'
    end

    before do
      stub_request(:get, 'https://api.github.com/search/repositories?page=1&per_page=30&q=rails')
        .to_return(body: 'API rate limit exceeded', status: 403)
    end

    include_examples 'invalid search'
  end

  context 'when not internet' do
    let(:error_message) { 'Failed to open TCP connection to api.github.com:443' }

    before do
      stub_request(:get, 'https://api.github.com/search/repositories?page=1&per_page=30&q=rails')
        .to_raise(Faraday::ConnectionFailed.new(error_message))
    end

    include_examples 'invalid search'
  end

  context 'with passed arguments' do
    context 'when change page' do
      let(:page) { 2 }

      it 'sends correct page value' do
        allow_any_instance_of(Octokit::Client)
          .to receive(:search_repositories)
          .with('rails', page: 2, per_page: 30)
          .and_return({ items: [] })

        subject
      end
    end

    context 'when change per_page' do
      let(:per_page) { 100 }

      it 'sends correct per_page value' do
        allow_any_instance_of(Octokit::Client)
          .to receive(:search_repositories)
          .with('rails', page: 1, per_page: 100)
          .and_return({ items: [] })

        subject
      end
    end

    context 'when change query' do
      let(:query) { 'sinatra' }

      it 'sends correct query' do
        allow_any_instance_of(Octokit::Client)
          .to receive(:search_repositories)
          .with('sinatra', page: 1, per_page: 30)
          .and_return({ items: [] })

        subject
      end
    end
  end

  context 'with valid response' do
    let(:repo) do
      Repo.new(
        id: 8514,
        avatar_url: 'https://avatars.githubusercontent.com/u/4223?v=4',
        description: 'Ruby on Rails',
        name: 'rails',
        owner_type: 'Organization',
        topics: %w[activejob activerecord framework html mvc rails ruby],
        url: 'https://github.com/rails/rails',
        username: 'rails'
      )
    end

    before do
      allow_any_instance_of(Octokit::Client)
        .to receive(:search_repositories)
        .and_return(json_fixture('rails.json'))
    end

    it 'returns total_count' do
      expect(subject.total_count).to eq(419_992)
    end

    it 'returns repos' do
      expect(subject.repos.count).to eq(10)
    end

    it 'returns valid repo' do
      expect(subject.repos[0]).to eq(repo)
    end
  end
end

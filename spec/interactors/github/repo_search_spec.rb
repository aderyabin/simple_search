# frozen_string_literal: true

require 'rails_helper'

describe Github::RepoSearch do
  subject { described_class.call(page:, per_page:, query:) }

  let(:page) { nil }
  let(:per_page) { nil }
  let(:query) { nil }

  context 'without query' do
    it { is_expected.to be_success }
  end

  context 'with failed search' do
    let(:query) { 'rails' }

    let(:adapter) do
      instance_double('adapter', 'success?' => false, message: 'Error message')
    end

    before do
      allow_any_instance_of(described_class).to(
        receive(:search).and_return(adapter)
      )
    end

    it { is_expected.not_to be_success }

    it 'returns message' do
      expect(subject.message).to eq('Error message')
    end

    it 'returns repos as nil' do
      expect(subject.repos).to be_nil
    end
  end

  context 'with valid search' do
    let(:query) { 'rails' }
    let(:adapter) do
      instance_double('adapter', 'success?' => true, repos: %w[a b c], total_count: 419_992)
    end

    before do
      allow_any_instance_of(described_class).to(
        receive(:search).and_return(adapter)
      )
    end

    it { is_expected.to be_success }

    it 'returns repos' do
      expect(subject.repos).to eq(%w[a b c])
    end

    it 'returns current page' do
      expect(subject.repos.current_page).to eq(1)
    end

    it 'returns total pages' do
      expect(subject.repos.total_pages).to eq(14_000)
    end
  end
end

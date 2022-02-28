# frozen_string_literal: true

require 'rails_helper'

describe Posts::Search do
  subject { described_class.call(q:).posts }

  let!(:lorem_ipsum) { create :post, :lorem_ipsum }
  let!(:come_from) { create :post, :come_from }
  let!(:why) { create :post, :why }

  shared_examples 'all posts' do
    it 'finds all posts' do
      expect(subject).to match_array([lorem_ipsum, come_from, why])
    end
  end

  context 'with empty query' do
    let(:q) { '' }

    include_examples 'all posts'
  end

  context 'without query' do
    let(:q) { nil }

    include_examples 'all posts'
  end

  context 'when search by title' do
    let(:q) { 'come from' }

    it 'finds post' do
      expect(subject).to eq([come_from])
    end
  end

  context 'when search multiple posts' do
    let(:q) { 'Lorem Ipsum' }

    it 'finds both posts' do
      expect(subject).to eq([lorem_ipsum, come_from])
    end
  end

  context 'when search non existed text' do
    let(:q) { 'repetition' }

    it 'finds nothing' do
      expect(subject).to be_empty
    end
  end
end

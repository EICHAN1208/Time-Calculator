# frozen_string_literal: true

require_relative '../lib/calculation'
require 'rspec'

RSpec.describe '時間の計算' do
  subject { TimeCalculation.listen(argv) }

  context '足し算' do
    context 'h + h = h' do
      let(:argv) { ['h', '1h', '+', '1h'] }

      it 'return 2h' do
        expect(subject.inspect).to eq('2.0h')
      end
    end

    context 'h + h = h' do
      let(:argv) { ['h', '3h', '+', '7h'] }

      it 'return 2h' do
        expect(subject.inspect).to eq('10.0h')
      end
    end

    context 'h + m = m' do
      let(:argv) { ['m', '1h', '+', '30m'] }

      it 'return 90m' do
        expect(subject.inspect).to eq('90.0m')
      end
    end

    context 'h + m = h' do
      let(:argv) { ['h', '1h', '+', '30m'] }

      it 'return 1.5h' do
        expect(subject.inspect).to eq('1.5h')
      end
    end

    context 'm + m = m' do
      let(:argv) { ['m', '45m', '+', '50m'] }

      it 'return 95.0 m' do
        expect(subject.inspect).to eq('95.0m')
      end
    end

    context 's + m = s' do
      let(:argv) { ['s', '30s', '+', '3m'] }

      it 'return 210.0 s' do
        expect(subject.inspect).to eq('210.0s')
      end
    end

    context 's + m = s' do
      let(:argv) { ['m', '30s', '+', '3m'] }

      it 'return 3.5 m' do
        expect(subject.inspect).to eq('3.5m')
      end
    end
  end

  context '引き算' do
    context 'h - h = h' do
      let(:argv) { ['h', '2h', '-', '1h'] }

      it 'return 1h' do
        expect(subject.inspect).to eq('1.0h')
      end
    end

    context 'h - m = m' do
      let(:argv) { ['m', '1h', '-', '30m'] }

      it 'return 30m' do
        expect(subject.inspect).to eq('30.0m')
      end
    end

    context 'h - m = h' do
      let(:argv) { ['h', '1h', '-', '30m'] }

      it 'return 0.5h' do
        expect(subject.inspect).to eq('0.5h')
      end
    end
  end
end

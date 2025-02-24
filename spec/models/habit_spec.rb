require 'rails_helper'

RSpec.describe Habit, type: :model do
  let(:user) { create(:user) }
  let(:habit) { create(:habit, user: user) }

  it { should belong_to(:user) }
  it { should have_many(:habit_tracks) }

  describe '.completed' do
    
    let!(:completed_habit) { create(:habit, status: 'Выполнена', user: user) }
    let!(:in_progress_habit) { create(:habit, status: 'Выполняется', user: user) }
    
    it 'returns only completed habits' do
      expect(Habit.completed).to include(completed_habit)
      expect(Habit.completed).not_to include(in_progress_habit)
    end
  end

  describe 'constants' do
    it 'includes expected TAGS' do
      expect(Habit::TAGS).to match_array([
        'Здоровье',
        'Спорт',
        'Правильное питание',
        'Чтение книг',
        'Продуктивность'
      ])
    end

    it 'includes expected HABIT_IMAGES' do
      expect(Habit::HABIT_IMAGES).to match_array([
        "habit_images/beautiful.png",
        "habit_images/eat.png",
        "habit_images/finance.png",
        "habit_images/ocean.png",
        "habit_images/present.png",
        "habit_images/travel.png"
      ])
    end

    it 'includes expected STATUS' do
      expect(Habit::STATUS).to match_array(['Выполняется', 'Не выполняется', 'Выполнена'])
    end
  end

  describe 'validations' do
    let(:habit) { build(:habit) }

    it 'validates presence of title' do
      habit.title = nil
      expect(habit).not_to be_valid
      expect(habit.errors[:title]).to include("can't be blank")
    end

    it 'validates inclusion of tags' do
      habit.tags = ['Invalid tag']
      expect(habit).not_to be_valid
      expect(habit.errors[:tags]).to include("is not included in the list")
    end

    it 'validates inclusion of status' do
      habit.status = 'Invalid status'
      expect(habit).not_to be_valid
      expect(habit.errors[:status]).to include("is not included in the list")
    end
  end

  describe '#set_status' do
    let(:habit) { create(:habit, status: 'Выполняется') }

    it 'updates status if new status is valid' do
      habit.set_status('Выполнена')
      expect(habit.status).to eq('Выполнена')
    end

    it 'does not update status if new status is invalid' do
      habit.set_status('Invalid status')
      expect(habit.status).to eq('Выполняется')
      expect(habit.errors[:status]).to include("Invalid status")
    end
  end
end

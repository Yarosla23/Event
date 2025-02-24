class SplitUsersAndProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false, foreign_key: true, index: true
      t.string :first_name, null: false           # Имя
      t.string :last_name, null: false            # Фамилия
      t.string :middle_name                      # Отчество (опционально)
      t.date :birthday_date                          # Дата рождения
      t.string :phone, null: false               # Номер телефона
      t.string :avatar                       # URL для аватарки пользователя
      t.string :gender, null: false                             # Пол (мужской, женский)
      t.string :city                             # Город
      t.text :options                               # Биография или краткая информация о себе
      t.boolean :is_active, default: true        # Активность профиля
      t.jsonb :social_media_links, default: {}
      
      t.timestamps
    end

    reversible do |data|
      data.up do
        User.find_each do |user|
          Profile.create!(
            user_id: user.id,
          )
        end
      end
    end
  end
end

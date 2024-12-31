class SplitUsersAndProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false, foreign_key: true, index: true
      t.date :birthday_date
      t.string :avatar
      t.string :username
      t.text :options
      t.string :first_name, null: false           # Имя
      t.string :last_name, null: false            # Фамилия
      t.string :middle_name                      # Отчество (опционально)
      t.date :birthdate                          # Дата рождения
      t.string :phone, null: false               # Номер телефона
      t.string :email                            # Электронная почта (может быть дублирована из User)
      t.string :avatar_url                       # URL для аватарки пользователя
      t.string :gender                           # Пол (мужской, женский, другое)
      t.string :address                          # Адрес пользователя
      t.string :city                             # Город
      t.string :country                          # Страна
      t.text :bio                                # Биография или краткая информация о себе
      t.boolean :is_active, default: true        # Активность профиля

      t.timestamps
    end

    reversible do |data|
      data.up do
        User.find_each do |user|
          Profile.create!(
            user_id: user.id,
            birthday_date: user.birthday_date,
            avatar: user.avatar,
            username: user.username,
            options: user.options
          )
        end
      end
    end

    remove_column :users, :birthday_year, :integer
    remove_column :users, :birthday_date, :date
    remove_column :users, :avatar, :string
    remove_column :users, :username, :string
    remove_column :users, :options, :text

  end
end

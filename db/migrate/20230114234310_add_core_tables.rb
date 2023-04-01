class AddCoreTables < ActiveRecord::Migration[7.0]
  def up
    enable_extension "uuid-ossp"

    create_table :users do |t|
      t.uuid :uuid, default: "uuid_generate_v4()", null: false
      t.integer :role, default: 0, null: false
      t.integer :gender, limit: 3, default: 0
      t.bigint :hakos, default: 0
      t.string :display_name
      t.string :ig_profile_link
      t.integer :provider, limit: 3, default: 0
      t.string :uid

      ## Database authenticatable
      t.string :phone,              default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :email,              null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.string :jti, null: false

      t.timestamps

      t.index :email, unique: true
    end

    create_table :events do |t|
      t.uuid :uuid, default: "uuid_generate_v4()", null: false
      t.integer :category, limit: 3, null: false, default: 0
      t.string :display_name, null: false
      t.string :description, null: false
      t.date :date, null: false
      t.datetime :from, null: false
      t.datetime :to
      t.datetime :discarded_at
      t.datetime :expires_at
      t.datetime :canceled_at
      t.decimal :longitude, precision: 10, scale: 6
      t.decimal :latitude, precision: 10, scale: 6
      # we can add prices later
      t.references :created_by, foreign_key: { to_table: :users }, null: false
      t.references :canceled_by, foreign_key: { to_table: :users }, null: true
      t.timestamps

      t.index :discarded_at
    end

    create_table :event_participants do |t|
      t.integer :status, limit: 3, default: 0
      t.references :participant, index: false, foreign_key: { to_table: :users }
      t.references :event, index: false, foreign_key: { to_table: :events }
    end

    create_table :kaha_profiles do |t|
      t.integer :goals, default: 0
      t.integer :appearances, default: 0
      t.integer :position, limit: 3, default: 0
      t.integer :rank, limit: 3, default: 0 # 1 to 5 stars by game master 
      t.integer :priority, limit: 3, default: 0 # for example (enables old hakas can skip waiting lists)
      t.integer :booking_preference, limit: 3, default: 0 # can be (manual booking or automatic weekly booking or bi-weekly automatic booking)
      t.references :player, foreign_key: { to_table: :users }
      t.timestamps
    end

    create_table :conversations do |t|
      t.uuid :uuid, default: "uuid_generate_v4()", null: false
      t.integer :conversation_type, limit: 3, null: false, default: 0
      t.string :display_name, null: true
      t.datetime :last_message_at
      t.datetime :first_message_at
      t.datetime :discarded_at
      t.references :created_by, foreign_key: { to_table: :users }, null: false
      t.timestamps

      t.index :discarded_at
    end

    create_table :conversation_participants do |t|
      t.uuid :uuid, default: "uuid_generate_v4()", null: false
      t.datetime :discarded_at
      t.timestamps
      t.references :user, index: true
      t.references :conversation, index: true
    end

    create_table :messages do |t|
      t.uuid :uuid, default: "uuid_generate_v4()", null: false
      t.string :source_id
      t.integer :message_type, limit: 3, null: false, default: 0
      t.integer :message_subtype, limit: 3, null: false, default: 0
      t.string :source_reply_to_message_id
      t.integer :source_forward_from_user_id
      t.integer :source_forward_from_conversation_id
      t.string :source_forward_from_message_id
      t.boolean :replied_to, default: false
      t.boolean :forwarded, default: false
      t.text :body
      t.references :user, index: false
      t.references :conversation, index: true
      t.datetime :delivered_at
      t.datetime :read_at
      t.datetime :discarded_at
      t.timestamps

      t.index [:conversation_id, :source_id], unique: true
    end

    add_index :users, :reset_password_token, unique: true
  end

  def down
    remove_index :users, :reset_password_token
    drop_table :messages
    drop_table :conversation_participants
    drop_table :conversations
    drop_table :kaha_profiles
    drop_table :event_participants
    drop_table :events
    drop_table :users
  end
end

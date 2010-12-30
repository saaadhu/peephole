class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :display_name
      t.string :login_name
      t.datetime :last_seen
      t.string :full_name
      t.string :email
      t.timestamps
    end

    if File.exist?('Users.txt') then
      File.read('Users.txt').each_line do |line|
        parts = line.split ';'

        u = User.new(:display_name => parts[0], :full_name => parts[1], :login_name => parts[2], :email => parts[3].split(':')[1])
        u.save!
      end
    end
  end

  def self.down
    drop_table :users
  end
end

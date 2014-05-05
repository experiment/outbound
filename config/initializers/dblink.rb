ActiveRecord::Base.connection.execute <<-SQL
  SELECT dblink_connect('app', '#{ENV['APP_DATABASE_URL']}')
SQL

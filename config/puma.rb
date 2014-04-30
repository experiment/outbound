workers 3
threads 4, 4

port ENV['PORT']
environment ENV['RACK_ENV']

preload_app!

on_worker_boot do
  ActiveSupport.on_load :active_record do
    ActiveRecord::Base.establish_connection
  end
end

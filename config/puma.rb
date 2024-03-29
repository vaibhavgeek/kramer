workers Integer(ENV['WEB_CONCURRENCY'] || 3)
threads_count_min = Integer(ENV['MIN_THREADS'] || 5)
threads_count_max = Integer(ENV['MAX_THREADS'] || 30)
threads threads_count_min, threads_count_max

preload_app!

on_worker_boot do
  ActiveRecord::Base.establish_connection
end

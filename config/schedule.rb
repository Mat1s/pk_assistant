every 2.days do
  runner 'ServiceWorker.perform_async'
end

every :day do 
  rake 'import:elasticsearch'
end

Dashing.scheduler.every '1s' do
  Dashing.send_event('widget_id', { value: rand(100) })
end

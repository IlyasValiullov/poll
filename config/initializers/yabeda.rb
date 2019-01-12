require 'yabeda'
require 'yabeda/datadog'


Yabeda.configure do

  self.datadog_api_key = ENV['DATADOG_API_KEY']
  self.datadog_app_key = ENV['DATADOG_APP_KEY']
  self.host = 'production'

  group :poll do
    counter   :count, comment: "Total number of bells being rang"
    gauge     :whistles_active,  comment: "Number of whistles ready to whistle"
    histogram :whistle_runtime do
      comment "How long whistles are being active"
      unit :seconds
      buckets ''
    end
  end

  collect do
    poll_whistles_active.set({}, Poll.all.count)
  end
end
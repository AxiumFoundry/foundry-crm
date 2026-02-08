class ApplicationJob < ActiveJob::Base
  before_perform do |job|
    Honeybadger.context(
      job_name: job.class.name,
      job_id: job.job_id,
      arguments: job.arguments
    )
  end
end

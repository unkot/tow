# vim: filetype=ruby
# vim: tabstop=2 expandtab
# encoding: utf-8
#
# tow_server.rb
#
# Generic worker

require "rubygems"
require "bundler/setup"
require "amqp"
require "cassandra"

class Worker
  JOBS_COLUMN_FAMILY="jobs"

  def run(job_key)
    begin
    c = Cassandra.new(@KEYSPACE, '127.0.0.1:9160')

    unless c.column_families.has_key?(JOBS_COLUMN_FAMILY)
      cf_def = CassandraThrift::CfDef.new(:KEYSPACE => KEYSPACE, :name => JOBS_COLUMN_FAMILY)
      c.add_column_family(cf_def)
    end

    job = c.get(JOBS_COLUMN_FAMILY, job_key)
    case job.job_type
      when "label_list"
        w = ReceiveLabelList.new()
        result = w.run(job)

        #updating job with results
        job[:result] = result
        c.insert(JOBS_COLUMN_FAMILY, job.key, job)
      else
        NotImplementedError.raise()
    end
    rescue Exception => e
      puts("Exception while processing #{job_key}: #{e.to_s}")
    end
  end
end


AMQP.start(:host => "localhost") do |connection|
  channel = AMQP::Channel.new(connection)
  queue   = channel.queue("task_queue", :durable => true)

  Signal.trap("INT") do
    connection.close do
      EM.stop { exit }
    end
  end

  puts " [*] Waiting for messages. To exit press CTRL+C"

  channel.prefetch(1)
  queue.subscribe(:ack => true) do |header, job_key|
    begin
      puts("Received #{job_key}")
      w = Worker.new()
      w.run(job_key)
      puts("Finished processing #{job_key}")
      header.ack()
    rescue Exception => e
      puts("Exception while processing #{job_key}: #{e.to_s}")
      header.reject()
    end
  end
end

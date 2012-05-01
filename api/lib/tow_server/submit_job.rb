require "rubygems"
require "amqp"
require "cassandra"

class SubmitJob
  KEYSPACE="codemire.tow"
  JOBS_COLUMN_FAMILY="jobs"
  LABEL_LIST_QUEUE = "codemire.tow.label_list"

  def SubmitJob.submit(job_spec)
    c = Cassandra.new(@KEYSPACE, '127.0.0.1:9160')

    unless c.column_families.has_key?(JOBS_COLUMN_FAMILY)
      cf_def = CassandraThrift::CfDef.new(:KEYSPACE => KEYSPACE, :name => JOBS_COLUMN_FAMILY)
      c.add_column_family(cf_def)
    end

    c.insert(JOBS_COLUMN_FAMILY, job_spec.key, job_spec.to_hash)

    EventMachine.run do
      connection = AMQP.connect(:host => '127.0.0.1')
      puts "Connected to AMQP broker. Running #{AMQP::VERSION} version of the gem..."

      channel  = AMQP::Channel.new(connection)
      queue    = channel.queue(LABEL_LIST_QUEUE, :auto_delete => true)
      exchange = channel.direct("")

      exchange.publish job_spec.key, :routing_key => queue.name
      connection.close { EventMachine.stop }
    end
  end
end
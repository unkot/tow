require "rubygems"
require "cassandra"

class JobResults
  KEYSPACE="codemire.tow"
  JOBS_COLUMN_FAMILY="jobs"

  def JobResults.receive(job_key)
    c = Cassandra.new(@KEYSPACE, '127.0.0.1:9160')

    unless c.column_families.has_key?(JOBS_COLUMN_FAMILY)
      cf_def = CassandraThrift::CfDef.new(:KEYSPACE => KEYSPACE, :name => JOBS_COLUMN_FAMILY)
      c.add_column_family(cf_def)
    end

    job = c.get(JOBS_COLUMN_FAMILY, job_key)
    if job.has_key?(:result)
      return job[:result]
    end
    return NIL
  end
end
# vim: filetype=ruby
# vim: tabstop=2 expandtab
# encoding: utf-8
# 
# job.rb
# 
# Contains API job description

class Job
  def initialize(job_type, user, password)
    @job_type = job_type
    @user = user
    @password = password
    self.status = :new
    @timestamp = Time.now.to_i
  end

  def key
    unless @job_id
      uuid = UUIDTools::UUID.sha1_create(UUIDTools::UUID_DNS_NAMESPACE, "tow.codemire.com")
      @job_id = "#{user}:#{job_type}:#{timestamp}:#{uuid}"
    end
    @job_id
  end
  def key=(key)
    @job_id = key
  end

  def job_type
    @job_type
  end
  def job_type=(type)
    @job_type = type
  end

  def status
    @status
  end
  def status=(status)
    available_statuses = %w(new assigned completed error abandoned)
    raise ArgumentError, "Status #{status} not in #{available_statuses}", caller if available_statuses.include? status

    @timestamp = nil
    @status = status
  end

  def user
    @user
  end
  def user=(user)
    @user = user
  end

  def password
    @password
  end
  def password=(password)
    @password = password
  end

  def timestamp
    unless @timestamp
      @timestamp = Time.now.to_i
    end
  end
  def timestamp=(timestamp)
    @timestamp = timestamp
  end

  def result
    @result
  end
  def result=(result)
    @result = result
  end

  def to_s
    "get #{job_type} for #{user} in #{status} since #{timestamp}"
  end

  def to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
  end
end

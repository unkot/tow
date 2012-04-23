# vim: filetype=ruby
# vim: tabstop=2 expandtab
# encoding: utf-8
# 
# job.rb
# 
# Contains API job description

class Job
  def job_id
    @job_id
  end
  def job_id=(id)
    @job_id = id
  end

  def job_type
    @job_type
  end
  def job_type=(type)
    @job_type = type
  end

  def account
    @account
  end
  def account=(account)
    @account = account
  end

  def password
    @password
  end
  def password=(password)
    @password = password
  end
end

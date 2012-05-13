class ProcessEmailJob
  def initialize(job_type, user, password, email_id, value=NIL)
    super(job_type, user, password)
    @email_id = email_id
    if value
      @value = value
    end
  end
end
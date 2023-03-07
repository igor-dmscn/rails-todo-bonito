class ValidationErrorSerializer

  def initialize(errors)
    @errors = errors
  end

  def as_json
    {
      'error' => {
        'message' => 'Validation Error',
        'details' => errors
      }
    }
  end

  private
  attr_reader :errors
end
